FROM nginx
COPY src/ /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
