#!/bin/sh
# shell script to prepend i3status with more stuff

# function to check if docker exists
check_docker() {
  if command -v docker >/dev/null 2>&1; then
    echo "🐳 v:$(docker -v | cut -d ' ' -f 3 | cut -c 1-5)"
  fi
}

# function to check node version
check_node() {
  if command -v node >/dev/null 2>&1; then
    echo "🦠 v:$(node -v | cut -c 2-)"
  fi
}

# function to check if the user is root
check_root() {
  if [ "$(id -u)" -eq 0 ]; then
    echo "🔐"
  fi
}

# fynction to get the linux kernel version
check_kernel_status() {
  if [ -f /proc/version ]; then
    echo "🐧 v:$(cat /proc/version | cut -d ' ' -f 3)"
  fi
}

i3status | while :; do
  read line
  docker_status=$(check_docker)
  node_status=$(check_node)
  check_root_status=$(check_root)
  check_kernel=$(check_kernel_status)
  echo "$check_kernel | $check_root$USER@$(hostname) | $node_status | $docker_status | $line" || exit 1
done
