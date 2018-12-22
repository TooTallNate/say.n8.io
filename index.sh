import "querystring"
import "static-binaries"
static_binaries tree
export PYTHONUSERBASE="$IMPORT_CACHE"

build() {
  curl -sfLSO "https://bootstrap.pypa.io/get-pip.py"
  python3 get-pip.py --user
  pip install --user --upgrade pip setuptools
  pip install --user gTTS
  #pip uninstall --user pip
}

handler() {
  local text
  local path
  local lang="en"
  local content_type="audio/mpeg"
  path="$(jq -er '.path' < "$REQUEST")"
  text="$(querystring_unescape "${path:1}")"

  # TODO: parse query string for ?lang=de
  #saveIFS="$IFS"
  #IFS='=&'
  #query=($QUERY_STRING)
  #IFS=$saveIFS
  #echo "query: ${query[@]+"${query[@]}"}" >&2

  #for ((i=0; i<${#query[@]}; i+=2)); do
  #  query_name="$(querystring_unescape "${query[i]}")"
  #  if [ "${query_name}" = "lang" ]; then
  #    query_value="$(querystring_unescape "${query[i+1]}")"
  #    lang="${query_value}"
  #  fi
  #done

  http_response_header "Content-Type" "$content_type"
  gtts-cli "$text" --lang "$lang" --output /dev/stdout
}
