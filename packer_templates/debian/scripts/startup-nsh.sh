#!/bin/sh -eux

# When Vagrant brings up this machine for the first time, it won't have access to the variable store
# which grub-install wrote to. We can add a startup.nsh as a little hack to get the machine booted.
# TODO(soon): Make an on-first-boot script which removes this and grub-installs again, resizes disk,
#   etc. Need to figure out how to organize between QEMU environments and metals.
echo -n 'FS0:\EFI\debian\grubaa64.efi' > /boot/efi/startup.nsh
