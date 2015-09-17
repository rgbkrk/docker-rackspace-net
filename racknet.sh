#!/bin/bash
set -euo pipefail

# Get a specific IP address out, based on IP version and the interface
obtainIP() {
  IP_VERSION=${1:-"inet"}
  INTERFACE=${2:-"eth0"}
  ip -f ${IP_VERSION} addr show ${INTERFACE} | awk '/inet/ { print $2 }' | awk -F '/' '{print $1}'
}

# Public Net *should* be on eth0
PublicNet() {
  IP_VERSION=${1:-"inet"}
  echo "$(obtainIP $IP_VERSION eth0)"
}

# ServiceNet *should* be on eth1
ServiceNet() {
  IP_VERSION=${1:-"inet"}
  echo "$(obtainIP $IP_VERSION eth1)"
}

Primary() {
  pn=$(PublicNet)
  sn=$(ServiceNet)

  echo "PublicNet: $pn"
  echo "ServiceNet: $pn"
}

SERVICE=${1:-"Primary"}

$SERVICE
