
function mydev_login_host() {
  local hosts
  local search
  local variables
  local host
  local user
  local password

  hosts=$1
  search=$2

  variables=$(grep "name=${search}" "${hosts}" | head -1)

  if [ -z "$variables" ]; then
    echo "No such host by: ${search}" >&2
    exit 1
  fi

  for variable in $variables; do
    declare "$variable"
  done

  echo "${host}"

  rm -fr "/tmp/mydev-${user}" >/dev/null 2>&1 || true
  echo -n "${password}" | xclip -selection clipboard
  git clone "https://${host}/${user}/${user}.git" "/tmp/mydev-${user}"
}
