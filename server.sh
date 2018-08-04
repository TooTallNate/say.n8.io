#!/bin/bash
set -euo pipefail

lang="en"
content_type="audio/mpeg"
text="$(decode_url "${REQUEST_PATH:1}")"

# TODO: parse query string for ?lang=de
saveIFS="$IFS"
IFS='=&'
query=($QUERY_STRING)
IFS=$saveIFS

for ((i=0; i<${#query[@]}; i+=2)); do
  query_name="$(decode_url "${query[i]}")"
  query_value="$(decode_url "${query[i+1]}")"
  if [ "${query_name}" = "lang" ]; then
    lang="${query_value}"
  fi
done

set_response_header "Content-Type" "$content_type"
gtts-cli "$text" --lang "$lang" --output /dev/stdout
