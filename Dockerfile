# Temel imaj
FROM nginx:alpine

# Nginx yapılandırmasını güncelle
RUN echo 'server { listen 81; location / { root /usr/share/nginx/html; index index.html; } }' > /etc/nginx/conf.d/default.conf

# Portu aç
EXPOSE 81

# Flutter web derlemesi
COPY build/web /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Nginx’i başlat
CMD ["nginx", "-g", "daemon off;"]
