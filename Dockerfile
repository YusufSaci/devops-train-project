# Bu Dockerfile kasıtlı olarak geliştirilmeye açık bırakılmıştır.
# Görev (Hafta 2): Bu dosyayı multi-stage build'e çevir.

FROM python:3.11

WORKDIR /app

COPY app/ .

RUN pip install -r requirements.txt

EXPOSE 5000

CMD ["python", "app.py"]
