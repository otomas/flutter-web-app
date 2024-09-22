# Temel imaj
FROM nginx:alpine

# Flutter web derlemesi
COPY build/web /usr/share/nginx/html

# Nginx’i başlat
CMD ["nginx", "-g", "daemon off;"]
