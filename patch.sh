#!/usr/bin/bash

#1
mkdir -p /root/patches
mkdir download
cd download
# https://slackware.pkgs.org/15.0/slackware-x86_64/mozilla-firefox-91.5.1esr-x86_64-1.txz.html
wget https://slackware.uk/slackware/slackware64-15.0/slackware64/xap/mozilla-firefox-91.5.1esr-x86_64-1.txz
installpkg mozilla-firefox-91.5.1esr-x86_64-1.txz
wget http://ftp.slackware.pl/pub/slackware/slackware64-15.0/patches/PACKAGES.TXT
for pkg in $(awk -F ': ' '/^PACKAGE NAME:/ {print $2}' PACKAGES.TXT); do [[ ! "$pkg" =~ ^kernel ]] && ls /var/log/packages/"${pkg%-*}"* &> /dev/null && wget "http://ftp.slackware.pl/pub/slackware/slackware64-15.0/patches/packages/$pkg" -P . && installpkg "./$pkg"; done
rm -rf PACKAGES.TXT
cp *.txz /root/patches
cd ..
rm -rf download

#1d
# https://www.slax.org/customize.php
savechanges changes1d.sb
cp changes1d.sb /run/initramfs/memory/data/slax/modules/

#2
# https://docs.slackware.com/slackware:localization?s[]=localization
cp /usr/share/zoneinfo/Europe/Warsaw /etc/localtime

#3a
# http://www.slackware.com/config/users.php
userdel -r guest

#3b
# https://docs.slackware.com/slackbook:users?s[]=useradd
useradd -d /data/home/rafal -s /bin/bash -g users rafal

#3c https://www.linuxquestions.org/questions/slackware-14/how-to-get-the-launch-details-for-slackware-15%27s-applications-menu-4175724756/
sed -i '3d' /root/.blackbox-menu
# Chrome is not installed fully at the start.
rm -rf /usr/share/applications/google-chrome.desktop

#3d
sed -i '4d' /root/.fluxbox/menu

#3e
# https://www.slax.org/customize.php
savechanges changes3e.sb
cp changes3e.sb /run/initramfs/memory/data/slax/modules/

#4
mkdir tools
cd tools
# https://github.com/aviggiano/qcl
# Besides the usual C++ development tools, you will need to have flex, bison and (optionally) GNU readline installed on your system.
# https://slackware.pkgs.org/15.0/slackware-x86_64/flex-2.6.4-x86_64-5.txz.html
wget https://slackware.uk/slackware/slackware64-15.0/slackware64/d/flex-2.6.4-x86_64-5.txz
# https://slackware.pkgs.org/15.0/slackware-x86_64/bison-3.8.2-x86_64-1.txz.html
wget https://slackware.uk/slackware/slackware64-15.0/slackware64/d/bison-3.8.2-x86_64-1.txz
# https://slackware.pkgs.org/15.0/slackware-x86_64/readline-8.1.002-x86_64-1.txz.html
wget https://slackware.uk/slackware/slackware64-15.0/slackware64/l/readline-8.1.002-x86_64-1.txz
wget https://slackware.uk/slackware/slackware64-15.0/slackware64/d/make-4.3-x86_64-3.txz
# https://github.com/gapan/slackware-deps/blob/15.0/make.dep
# https://slackware.pkgs.org/15.0/slackware-x86_64/guile-3.0.7-x86_64-1.txz.html
wget https://slackware.uk/slackware/slackware64-15.0/slackware64/d/guile-3.0.7-x86_64-1.txz
# https://slackware.pkgs.org/15.0/slackware-x86_64/gc-8.0.6-x86_64-1.txz.html
wget https://slackware.uk/slackware/slackware64-15.0/slackware64/l/gc-8.0.6-x86_64-1.txz
# https://slackware.pkgs.org/15.0/slackware-x86_64/gcc-11.2.0-x86_64-2.txz.html
wget https://slackware.uk/slackware/slackware64-15.0/slackware64/d/gcc-11.2.0-x86_64-2.txz
# https://slackware.pkgs.org/15.0/slackware-x86_64/gcc-g++-11.2.0-x86_64-2.txz.html
wget https://slackware.uk/slackware/slackware64-15.0/slackware64/d/gcc-g++-11.2.0-x86_64-2.txz
# https://www.iitk.ac.in/LDP/LDP/lfs/5.0/html/appendixa/flex.html
# https://slackware.pkgs.org/15.0/slackware-x86_64/binutils-2.37-x86_64-1.txz.html
wget https://slackware.uk/slackware/slackware64-15.0/slackware64/d/binutils-2.37-x86_64-1.txz
# kernel-source
# https://slackware.pkgs.org/15.0/slackware-x86_64/kernel-source-5.15.19-noarch-2.txz.html
wget https://slackware.uk/slackware/slackware64-15.0/slackware64/k/kernel-source-5.15.19-noarch-2.txz
# glibc - lab
# https://slackware.pkgs.org/15.0/slackware-x86_64/glibc-2.33-x86_64-5.txz.html
wget https://slackware.uk/slackware/slackware64-15.0/slackware64/l/glibc-2.33-x86_64-5.txz
# https://slackware.pkgs.org/15.0/slackware-x86_64/kernel-headers-5.15.19-x86-2.txz.html
wget https://slackware.uk/slackware/slackware64-15.0/slackware64/d/kernel-headers-5.15.19-x86-2.txz
installpkg *.txz
cd ..
rm -rf tools

#4a
# https://docs.slackware.com/howtos:network_services:postfix_with_cyrus?s[]=wget
wget http://tph.tuwien.ac.at/~oemer/tgz/qcl-0.6.7.tgz

#4b
# https://linux.die.net/man/1/tar
tar -xf qcl-0.6.7.tgz
cd qcl-0.6.7
# https://github.com/aviggiano/qcl/blob/master/src/Makefile + https://linux.die.net/man/1/sed
sed -i 's/^PLOPT/#1/' Makefile
sed -i 's/^PLLIB/#2/' Makefile

#4c
# https://github.com/aviggiano/qcl
make
# Compile, not install, so without make install.
cd ..

#4d
# https://www.slax.org/customize.php
mkdir changes4d.sb
mkdir -p changes4d.sb/qclslax/
cp -r qcl-0.6.7 changes4d.sb/qclslax/
dir2sb changes4d.sb
cp changes4d.sb /run/initramfs/memory/data/slax/modules/

#4e
rm -rf qcl-0.6.7.tgz
rm -rf qcl-0.6.7

removepkg flex
removepkg bison
removepkg readline
removepkg make
removepkg guile
removepkg gc
removepkg gcc
removepkg gcc-g++
removepkg binutils
removepkg kernel-source
removepkg kernel-headers



