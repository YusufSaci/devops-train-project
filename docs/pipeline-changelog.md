# CI/CD Pipeline Değişiklikleri

Bu doküman, projenin GitHub Actions CI/CD pipeline'ı (`ci.yml`) üzerinde yapılan güncellemeleri, düzeltmeleri ve yeni eklenen özellikleri listeler. 

## 1. Tetikleyici ve Branch Güncellemeleri
* Pipeline tetikleyicilerindeki (`on: push` ve `on: pull_request`) ana dal referansı `main` yerine **`master`** olarak güncellendi.
* *Push to Registry* ve *Deploy to Kubernetes* adımlarının (job) sadece ana dalda çalışmasını sağlayan `if` koşulları (`github.ref == 'refs/heads/master'`) yeni dal yapısına göre uyarlandı.

## 2. Environment Variables
* `IMAGE_NAME` değişkeni, dinamik depo adından (`${{ github.repository }}`) bağımsızlaştırılarak, statik ve spesifik bir isme (`yusufsaci/devops-train-project/intern-app`) sabitlendi.

## 3. Docker Build & Push İşlemlerindeki İyileştirmeler
* **Dockerfile Konumu:** Hem `build` hem de `push` adımlarındaki `docker/build-push-action` adımlarına `file: app/Dockerfile` parametresi eklenerek Dockerfile'ın dizini netleştirildi.
* **İmaj Boyutu Analizi:** `build` adımına, oluşturulan Docker imajının boyutunu bayt ve megabayt cinsinden hesaplayıp, GitHub Actions Step Summary ekranına Markdown formatında yazdıran yeni bir script eklendi (`Image boyutunu logla`).
* **Eksik Adım Giderilmesi:** `push` job'ına, imajı derleyip GHCR'ye göndermeden önce çalışması zorunlu olan **Docker Buildx kur** (`docker/setup-buildx-action@v3`) adımı eklendi.

## 4. Güvenlik Taraması (Trivy) ve Otomatik PR Geri Bildirimi
Güvenlik açıklarını görünür kılmak için pipeline'ın otomasyon yetenekleri artırıldı:
* **Erişim İzinleri:** `build` job'ına, botun Pull Request'lere yorum atabilmesi için gerekli olan `permissions: pull-requests: write` yetkisi tanımlandı.
* **Trivy Raporu Çıktısı:** `aquasecurity/trivy-action` adımına `output: trivy-results.txt` parametresi eklendi. Böylece sadece konsolda görünen hata logları, okunabilir fiziksel bir metin dosyasına aktarıldı.
* **Akıllı Yorum Botu:** `actions/github-script@v7` kullanılarak özel bir JavaScript entegrasyonu yazıldı. Bu entegrasyon sayesinde:
  * Trivy güvenlik taraması sonuçları, ilgili Pull Request sayfasına otomatik olarak yorum şeklinde eklenmektedir.
  * Hata durumunda dahi çalışması için koşul (`if: always() && github.event_name == 'pull_request'`) eklendi.
  * Kirliliği önlemek adına bot, sayfadaki önceki yorumları okuyarak kendi gizli damgasını (`<!-- trivy-scan-comment -->`) aramaktadır. Eski bir tarama yorumu bulursa, yeni mesaj atmak yerine mevcut yorumu güncelleyerek (update) temiz bir görünüm sağlamaktadır.