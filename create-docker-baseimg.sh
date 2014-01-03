#!/bin/bash
set -e

[[ -z $1 ]] && echo "please give a path to build the image" && exit 1
[[ -d "$1" ]] && echo "please create base image in non existing directory" && exit 2

mkdir -p "$1"

pacstrap -d "$1" bash bzip2 coreutils file filesystem findutils gawk gcc-libs gettext glibc grep gzip inetutils iputils iproute2 less pacman perl procps-ng psmisc sed shadow tar texinfo util-linux which

# clear packages cache
rm -f "$1/var/cache/pacman/pkg/"*

# create working dev
mknod -m 666 "$1/dev"/null c 1 3
mknod -m 666 "$1/dev"/zero c 1 5
mknod -m 666 "$1/dev"/random c 1 8
mknod -m 666 "$1/dev"/urandom c 1 9
mkdir -m 755 "$1/dev"/pts
mkdir -m 1777 "$1/dev"/shm
mknod -m 666 "$1/dev"/tty c 5 0
mknod -m 600 "$1/dev"/console c 5 1
mknod -m 666 "$1/dev"/tty0 c 4 0
mknod -m 666 "$1/dev"/full c 1 7
mknod -m 600 "$1/dev"/initctl p
mknod -m 666 "$1/dev"/ptmx c 5 2

# cleanup locale and manpage stuff, not needed to run in container
toClean=('usr/share/locale' 'usr/share/i18n' 'usr/share/man')
noExtract=''
for clean in ${toClean[@]}; do
	rm -rf "$1/$clean"/*
	noExtract="$noExtract $clean/*"
done
sed -e "s,^#NoExtract.*,NoExtract = $noExtract," -i "$1/etc/pacman.conf"

tar -C "$1" -c . | docker import - ike/archbase

rm -rf "$1"
