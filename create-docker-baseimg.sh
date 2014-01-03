#!/bin/bash
set -e

[[ -z $1 ]] && echo "please give a path to build the image" && exit 1
[[ -d "$1" ]] && echo "please create base image in non existing directory" && exit 2

mkdir -p "$1"

pacstrap -d "$1" bash bzip2 coreutils file filesystem findutils gawk gcc-libs gettext glibc grep gzip inetutils iputils iproute2 less pacman perl procps-ng psmisc sed shadow tar texinfo util-linux which

# clear packages cache
rm -f "$1/var/cache/pacman/pkg/"*

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