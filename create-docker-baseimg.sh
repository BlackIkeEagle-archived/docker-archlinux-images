#!/bin/bash
(( EUID != 0 )) && die 'This script must be run as root.'
set -e

buildfolder=$(basename $0)-$RANDOM

mkdir -p "$buildfolder"

pacstrap -C ./mkimage-arch-pacman.conf -c -G -M -d "$buildfolder" bash bzip2 coreutils file filesystem findutils gawk gcc-libs gettext glibc grep gzip inetutils iputils iproute2 less pacman perl procps-ng psmisc sed shadow tar texinfo util-linux which

# clear packages cache
rm -f "$buildfolder/var/cache/pacman/pkg/"*
rm -f "$buildfolder/var/log/pacman.log"

# create working dev
mknod -m 666 "$buildfolder/dev"/null c 1 3
mknod -m 666 "$buildfolder/dev"/zero c 1 5
mknod -m 666 "$buildfolder/dev"/random c 1 8
mknod -m 666 "$buildfolder/dev"/urandom c 1 9
mkdir -m 755 "$buildfolder/dev"/pts
mkdir -m 1777 "$buildfolder/dev"/shm
mknod -m 666 "$buildfolder/dev"/tty c 5 0
mknod -m 600 "$buildfolder/dev"/console c 5 1
mknod -m 666 "$buildfolder/dev"/tty0 c 4 0
mknod -m 666 "$buildfolder/dev"/full c 1 7
mknod -m 600 "$buildfolder/dev"/initctl p
mknod -m 666 "$buildfolder/dev"/ptmx c 5 2

# link pacman log to /dev/null
arch-chroot "$buildfolder" ln -s /dev/null /var/log/pacman.log

# cleanup locale and manpage stuff, not needed to run in container
toClean=('usr/share/locale' 'usr/share/i18n' 'usr/share/man')
noExtract=''
for clean in ${toClean[@]}; do
	rm -rf "$buildfolder/$clean"/*
	noExtract="$noExtract $clean/*"
done
sed -e "s,^#NoExtract.*,NoExtract = $noExtract," -i "$buildfolder/etc/pacman.conf"

tar --numeric-owner -C "buildfolder" -c . | docker import - archlinux

rm -rf "$buildfolder"
