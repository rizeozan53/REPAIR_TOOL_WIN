# REPAIR_TOOL_WIN
Windows 10/11 için geliştirilmiş hepsi bir arada bakım aracı (V8.0)

# 🛠️ Gelişmiş Sistem Bakım ve Onarım Aracı "REPAIR_V8.0"

**By Ozan** tarafından geliştirilen bu araç, Windows işletim sistemlerinde sık karşılaşılan hataları onarmak, gereksiz dosyaları temizlemek ve sistem performansını optimize etmek için tasarlanmış kapsamlı bir Batch (.bat) betiğidir.

Yönetici yetkisi kontrolü ve kullanıcı dostu menü arayüzü ile karmaşık komutları tek tuşla uygulamanızı sağlar.

## 🌟 Özellikler

Bu araç 4 ana kategoride 20'den fazla işlem sunar:

### 🔧 Sistem Onarım Araçları
* **SFC & DISM:** Bozuk sistem dosyalarını ve Windows imajını onarır (ScanHealth, RestoreHealth).
* **Disk Kontrolü:** `chkdsk` komutu ile disk hatalarını tarar.
* **Bileşen Temizliği:** Windows Update kalıntılarını ve eski bileşenleri temizler.

### 🧹 Temizlik ve Optimizasyon
* **Önbellek (Cache) Temizliği:** Windows Update, Microsoft Store, Temp ve Prefetch klasörlerini temizler.
* **Bloatware Kaldırma:** Gereksiz yüklü gelen uygulamaları (Xbox, Candy Crush vb.) kaldırır.
* **Loglama:** Yapılan işlemlerin kaydını `Logs` klasöründe tutar.

### 🌐 Ağ ve Sistem Araçları
* **Ağ Sıfırlama:** DNS önbelleğini temizler ve Winsock ayarlarını sıfırlar.
* **Sistem Bilgisi:** Boot ayarları (BCD), Sürücü doğrulama ve detaylı sistem bilgisini gösterir.
* **Hosts Dosyası Yönetimi:** Yedekleme, geri yükleme ve reklam engelleyici hosts dosyası indirme.

### 🛡️ Gelişmiş İşlemler
* **RDP & Firewall:** Uzak masaüstü portunu değiştirme ve güvenlik duvarı kuralı ekleme.
* **BSOD Analiz:** Mavi ekran hataları için Minidump dosyalarını otomatik zipler.
* **Defender Geçmişi:** Windows Defender tehdit geçmişini görüntüler.

## 🚀 Kurulum ve Kullanım

1. Bu depodaki `repair_v8.0.bat` dosyasını indirin.
2. Dosyaya sağ tıklayın ve **Yönetici Olarak Çalıştır** seçeneğini seçin.
3. Açılan menüden yapmak istediğiniz işlem numarasını girin ve `Enter`'a basın.

## ⚠️ Uyarı
Bu araç sistem dosyaları üzerinde değişiklik yapar. Kritik işlemlerden önce (özellikle kayıt defteri veya servis değişiklikleri) **Sistem Geri Yükleme Noktası** oluşturmanız önerilir. Araç içerisinde [14] numaralı seçenek ile geri yükleme ekranına ulaşabilirsiniz.
