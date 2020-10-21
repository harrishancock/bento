#!/bin/sh -eux

apt-get -y install cloud-init
tee /etc/cloud/cloud.cfg.d/00_generic.cfg << EOF
datasource_list: [ DigitalOcean, None ]
datasource:
  DigitalOcean:
    retries: 3
    timeout: 2
growpart:
  mode: auto
  devices:
    - /dev/vda2
    - /dev/vda5
  ignore_growroot_disabled: false
# HACK: Buster's cloud-utils doesn't grow LVM volumes. Fixed in cloud-utils 0.31, but that version
#   only resizes physical volumes, not logical volumes inside them. So, whatever, do it manually.
# From: https://github.com/mmickan/desployer/blob/master/seed-files/cloud-config
runcmd:
  - [ cloud-init-per, once, grow_VG, pvresize, /dev/vda5 ]
  - [ cloud-init-per, once, grow_LV, lvextend, -r, -l, "+100%FREE", /dev/debian-10-vg/root ]
EOF

cloud-init clean
fstrim -a
