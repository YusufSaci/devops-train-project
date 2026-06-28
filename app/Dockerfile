# Bu Dockerfile kasıtlı olarak geliştirilmeye açık bırakılmıştır.
# Görev (Hafta 2): Bu dosyayı multi-stage build'e çevir.

#----------------------------------------------------------

# İçinde python 3.11 sürümü kurulu olan bir linux os ver.
# C için gcc:latest
FROM python:3.11-slim

# container içinde ana dizinde app adlı directory oluştur ve terminalde oraya git.
# mkdir app , cd app ile aynı işi yapar.
WORKDIR /app

RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir --upgrade pip setuptools wheel jaraco.context


# ilk nokta: bilgisayarımızdaki klasör (nokta ise o an bulunduğumuz directory)
# ikinci nokta: container içindeki mevcut klasör (bu örnekte /app ye karşılık gelir).
# ilk konumda bulunan tüm dosyaları hedef konumdaki dosyanın içine kopyalar
COPY app/ .

# txt de bulunan tüm paketleri kur.
# C için gcc -o uygulama main.c
RUN pip install --no-cache-dir -r requirements.txt

# container içindeki uygulamanın çalışacağı port numarası
EXPOSE 5000

# container'ı çalıştırdığında terminale gidip python app.py yazar. (manuel olarak terminale yazdığmız komutu kelimelere bölerek oluştururuz)
# C için ["./uygulama"]
CMD ["python", "app.py"]


#-----------------------------------

# containera erişim 
# docker exec -it <konteyner_adi> /bin/bash