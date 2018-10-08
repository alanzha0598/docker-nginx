FROM nginx
COPY src/ /usr/share/nginx/html
CMD 'nginx'
