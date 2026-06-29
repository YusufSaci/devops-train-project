
# Builder 

FROM python:3.11-slim AS builder
WORKDIR /build

RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir --upgrade pip setuptools wheel jaraco.context

COPY app/requirements.txt .

RUN pip install --user --no-cache-dir -r requirements.txt


# Runtime 

FROM python:3.11-slim AS runtime
WORKDIR /app

RUN pip uninstall -y wheel jaraco.context setuptools

COPY --from=builder /root/.local /root/.local

COPY app/ .

ENV PATH=/root/.local/bin:$PATH

EXPOSE 5000

CMD ["python", "app.py"]