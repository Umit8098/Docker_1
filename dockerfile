# Altyapı:
FROM python:alpine3.18

# Çalışma Alanı:
WORKDIR /app

# Dosyaları aktar:
# COPY app.py /app
# COPY app.py .
COPY . .

# Commands (docker run imagename):
CMD python app.py