
mydev_proc_ps() {
  local ports

  ports=$(ss -tuln | awk 'NR>1 {print $5}' | awk -F':' '{print $NF}' | sort -n | uniq)


  #echo $ports
  #exit

  # Usa ss per ottenere informazioni sui processi
  echo "$ports" | while read -r port; do
    pid=$(lsof -i ":$port" -t 2>/dev/null | head -1)
    if [ -n "$pid" ]; then
      command=$(ps -p "$pid" -o cmd --no-headers 2>/dev/null && true)
      echo ":$port ($pid) ${command:0:80}"
    fi
  done && true
}

