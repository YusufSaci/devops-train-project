
# Step 1
GitHub arka planda sıfırdan ubuntu tabanlı sanal makine çalıştırır, projeyi buraya indirir ondan sonra ortamı ayarlar (python'ı , bağımlılıkları vs kurar) en son yazılan testleri çalıştır.

# Step 2 (Eğer step 1 de yapılan tüm testleri geçerse bu adıma gelir)
kodu bir docker image e dönüştürür oluşan bu image dostasını .tar olarak paketler. Oluşan bu paketi Trivy ile tarar. İçinde Kritik veya Yüksek riskli bir güvenlik açığı bulursa sistemi anında durdurur. İmage temiz çıktıysa, bir sonraki aşama  bu image'i kullanabilsin diye o .tar dosyasını geçici hafızaya (Artifact) kaydeder.

# Step 3 (Eğer step 2 de yapılan tüm testleri geçerse bu adıma gelir)
Bu adım, sadece main branch'e gelen onaylı kodları alır, GitHub'ın deposuna giriş yapar, imaja "latest" ve versiyon etiketlerini yapıştırır ve bu paketi canlı sunucuların çekebileceği güvenli bir depoya yerleştirir.

# Step 4
Bu adım, "Tüm testleri geçtik, paketimizi hazırladık, şimdi bu paketi canlı sunuculara yüklüyoruz" dediğimiz noktadır.


