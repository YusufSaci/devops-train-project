
# Builder 
FROM python:3.12-alpine3.24 AS builder

WORKDIR /build

COPY app/requirements.txt .

RUN pip install --user --no-cache-dir -r requirements.txt


# Runtime 
FROM python:3.12-alpine3.24 AS runtime

WORKDIR /app

COPY --from=builder /root/.local /root/.local

COPY app/ .

ENV PATH=/root/.local/bin:$PATH

EXPOSE 5000

CMD ["python", "app.py"]