#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function main() {
  # Parse arguments
  if [[ "$#" -ne 1 ]]; then
    usage
    exit 1
  fi
  local -r nat_ip=${1}

  sed -e "s/NAT_IP/${nat_ip}/g" ${ROOT_DIR}/ssh.config.template > ssh.config
}

function usage() {
  echo "Usage: ${0} <nat_ip>"
  echo
  echo "<nat_ip> IP address of the NAT server (bastion)"
}

main "$@"
