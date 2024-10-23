#!/bin/bash

# Repository dizinine git
cd bismih-repo

# Paket indekslerini güncelle (pool dizininde çalıştır)
dpkg-scanpackages --arch amd64 pool/ > dists/stable/main/binary-amd64/Packages
cat dists/stable/main/binary-amd64/Packages | gzip -9 > dists/stable/main/binary-amd64/Packages.gz

# Release dosyasını güncelle (generate-release.sh'ı üst dizinden çağır)
../generate-release.sh > dists/stable/Release

# Ana dizine geri dön
cd ..

# GPG ortamını ayarla
export GNUPGHOME="$(mktemp -d pgpkeys-XXXXXX)"
cat pgp-key.private | gpg --import

# Release dosyalarını imzala
cat bismih-repo/dists/stable/Release | gpg --default-key bismih -abs > bismih-repo/dists/stable/Release.gpg
cat bismih-repo/dists/stable/Release | gpg --default-key bismih -abs --clearsign > bismih-repo/dists/stable/InRelease

echo "Repository güncellendi!"