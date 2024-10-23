# repo

`sudo apt-get install -y gcc dpkg-dev gpg`


repo içinde deb paketleri, dists depo indexi depo imzası ve hangi ortama uyumlu çalıştığına dair bilgiler bulnur

mkdir -p pool/main dists/stable/main/binary-amd64

deb paketlerini paketlemek için
`dpkg-scanpackages --arch amd64 pool/ > dists/stable/main/binary-amd64/Packages`


paketlerin dosyasını sıkıştırmak için
`cat dists/stable/main/binary-amd64/Packages | gzip -9 > dists/stable/main/binary-amd64/Packages.gz`


`generate-release.sh > dists/stable/Release`

`export GNUPGHOME="$(mktemp -d pgpkeys-XXXXXX)"`
`gpg --no-tty --batch --gen-key pgp-key.batch`



`gpg --armor --export bismih > pgp-key.public`

`gpg --armor --export-secret-keys bismih > pgp-key.private`

`sudo apt-key add pgp-key.public`
`cat pgp-key.public | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/bismih-repo.gpg`
`echo "deb [signed-by=/etc/apt/trusted.gpg.d/bismih-repo.gpg] http://127.0.0.1:8000/bismih-repo stable main" | sudo tee /etc/apt/sources.list.d/bismih.list`



### tekrar izole bir anahtar üretmek için
`export GNUPGHOME="$(mktemp -d pgpkeys-XXXXXX)"`
`cat pgp-key.private | gpg --import`


`cat bismih-repo/dists/stable/Release | gpg --default-key bismih -abs > bismih-repo/dists/stable/Release.gpg`

`cat bismih-repo/dists/stable/Release | gpg --default-key bismih -abs --clearsign > bismih-repo/dists/stable/InRelease`


`echo "deb [signed-by=/etc/apt/trusted.gpg.d/bismih-repo.gpg] http://127.0.0.1:8000/bismih-repo stable main" | sudo tee /etc/apt/sources.list.d/bismih.list`