#!/bin/sh -eux

if [ "$1" = "-version" ]; then
  qemu-system-aarch64 "$@"
  exit 0
fi

qemu-img convert -f raw -O raw /usr/share/AAVMF/AAVMF_VARS.fd AAVMF_VARS.fd
trap "rm -f AAVMF_VARS.fd" EXIT
qemu-system-aarch64 "$@"
exit 0
