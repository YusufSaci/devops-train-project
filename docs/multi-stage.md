# Görev: Multi-Stage Docker Build

## Neden Multi-Stage Build?

Şu anki `Dockerfile` tek bir aşamadan oluşuyor. Bu yöntemde Python'ın
tüm geliştirme araçları ve önbellekleri production image'ına giriyor.
Bu da image boyutunu gereksiz yere şişiriyor.

Multi-stage build ile:
- **Build aşaması:** Bağımlılıkları yükle
- **Runtime aşaması:** Sadece çalıştırmak için gereken dosyaları kopyala

Image boyutu genellikle **%50–70** küçülür.

## Başlangıç Noktası

```dockerfile
# Aşama 1: Builder
FROM python:3.11-slim AS builder
WORKDIR /build
COPY app/requirements.txt .
RUN pip install --user -r requirements.txt

# Aşama 2: Runtime
FROM python:3.11-slim AS runtime
WORKDIR /app
# Builder aşamasından sadece yüklü paketleri kopyala
COPY --from=builder /root/.local /root/.local
COPY app/ .
ENV PATH=/root/.local/bin:$PATH
EXPOSE 5000
CMD ["python", "app.py"]
```

## Doğrulama

```bash
# Eski ve yeni image boyutlarını karşılaştır
docker build -t intern-app:old .          # mevcut Dockerfile ile
docker build -t intern-app:new .          # multi-stage ile
docker images | grep intern-app
```

## PR'ında Şunları Açıkla

- Eski ve yeni image boyutları neydi?
- `python:3.11` ile `python:3.11-slim` arasındaki fark ne?
- `COPY --from=builder` satırı ne işe yarıyor?
