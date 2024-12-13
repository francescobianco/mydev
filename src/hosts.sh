
function mydev_hosts() {
  local hosts
  local search
  local variables

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
}

function mydev_print_list() {
  local hosts
  local variables

  hosts=$1
  #echo "Hosts:${hosts}"
  while read -r variables; do
    [ -z "${variables}" ] && continue
    [ "${variables:0:2}" == "##" ] && echo "====[ ${variables:3} ]===="
    [ "${variables:0:5}" != "host=" ] && continue
    my_print_list_item "${variables}"
  done < "${hosts}"
}

function mydev_print_list_item() {
  local variables
  local name
  local host

  variables=$1

  for variable in $variables; do
    declare "$variable"
  done

  echo "- ${name} (${host})"
}