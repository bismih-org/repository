gpg anahtarı oluşturma için

`sudo apt install gpg`

expert modda daha güvenli bir anahtar oturabiliyoruz
`gpg --expert --full-gen-key`
9. EEC seçiyoruz
1. Curve 25519 seçiyoruz

gpg anahtar listesi
`gpg --list-keys`



dışarı aktarma için (--armor ASCII zırhlı anlamına gelir)
public anahtar

`gpg --armor --export user-id > pubkey.asc`

private anahtar

`gpg --export-secret-keys --armor user-id > privkey.asc`

anahtarımızı key serverına gönderiyoruz (tercihe bağlı)
`gpg --send-key key-id`

---

depo oluşturucu paketi

`sudo apt install reprepro`

depo ayarı için

`mkdir -p repo/conf`

sonrasında conf içinde distributions dosyası oluşturulmalı.

depoya bir .deb dosyası eklemek için
`reprepro -V --basedir  repo/ includedeb  fethan 'path/holy-quran_1.6.1_all.deb'`

gpg anahtarını herkese açık olarak yayınlamak için
`gpg --armor --export 09140FA2E7D7F775 | tee repo/bismih-pubkey.asc`

`wget --quiet -O - https://bismih-org.github.io/repository/repo/bismih-pubkey.asc | sudo tee /etc/apt/keyrings/bismih-pubkey.asc`

`echo "deb [signed-by=/etc/apt/keyrings/bismih-pubkey.asc arch=$( dpkg --print-architecture )] https://bismih-org.github.io/repository/repo fethan main" | sudo tee /etc/apt/sources.list.d/bismih.list`