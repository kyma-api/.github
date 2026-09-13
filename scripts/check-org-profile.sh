#!/usr/bin/env bash
# Fails when profile/README.md drifts from live facts. Read-only: it never edits a file.
# Usage: scripts/check-org-profile.sh [path/to/README.md]
set -uo pipefail

readme="${1:-profile/README.md}"
models_url="https://api.kymaapi.com/v1/models"
ua="kyma-org-profile-check (+https://github.com/kyma-api/.github)"
fail=0
status() { curl -sL -A "$ua" -o /dev/null -m 20 --retry 2 -w '%{http_code}' "$1"; }

# Rule 1: every link a reader clicks or loads (href, src, markdown link) ends below 400 after redirects.
links=$(grep -oE '(href="|src="|\]\()https://[^")[:space:]]+' "$readme" | sed -E 's/^(href="|src="|\]\()//' | sort -u)
for url in $links; do
  code=$(status "$url")
  if [ "$code" = "000" ] || [ "$code" -ge 400 ]; then echo "FAIL link $url -> HTTP $code"; fail=1
  else echo "ok   link $url -> HTTP $code"; fi
done

# Rule 2: any other https URL is an API endpoint shown in code. A bare GET may answer 401 or 404,
# so it only has to answer at all: no connection or HTTP 5xx fails.
endpoints=$(grep -oE 'https://[^"'\''`)<>[:space:]]+' "$readme" | sort -u | grep -vxF -f <(printf '%s\n' "$links") || true)
for url in $endpoints; do
  code=$(status "$url")
  if [ "$code" = "000" ] || [ "$code" -ge 500 ]; then echo "FAIL endpoint $url -> HTTP $code"; fail=1
  else echo "ok   endpoint $url -> HTTP $code"; fi
done

# Rule 3: model-count claims match the live catalogue. "N+ models" needs at least N; "N models" needs exactly N.
count=$(curl -s -A "$ua" -m 20 --retry 2 "$models_url" | jq -r '.data | length' 2>/dev/null)
if ! [[ "$count" =~ ^[0-9]+$ ]]; then
  echo "FAIL could not read the live model count from $models_url"; fail=1
else
  while read -r claim; do
    n="${claim%%[+ ]*}"
    if [[ "$claim" == *+* ]]; then [ "$count" -ge "$n" ]; else [ "$count" -eq "$n" ]; fi
    if [ $? -eq 0 ]; then echo "ok   \"$claim\" (live count $count)"
    else echo "FAIL README says \"$claim\" but the live count is $count"; fail=1; fi
  done < <(grep -oE '[0-9]+\+? models' "$readme" | sort -u)
fi

if [ "$fail" -eq 0 ]; then echo "org profile check: passed"; else echo "org profile check: FAILED"; fi
exit "$fail"
