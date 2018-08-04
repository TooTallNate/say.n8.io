#!/bin/bash
set -euo pipefail

text="$(decode_url "${REQUEST_PATH:1}")"
content_type="audio/mpeg"

# TODO: parse query string for ?lang=de
set_response_header "Content-Type" "$content_type"
gtts-cli "$text" --output /dev/stdout
