#!/usr/bin/env bash
set -ex

apt-get update
wget https://builds.parsec.app/package/parsec-linux.deb
apt-get install ./parsec-linux.deb
rm parsec-linux.deb
cp /usr/share/applications/parsecd.desktop $HOME/Desktop/
chmod +x $HOME/Desktop/parsecd.desktop
chown 1000:1000 $HOME/Desktop/parsecd.desktop