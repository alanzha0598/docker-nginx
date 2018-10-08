FROM alanzha0598/docker-nginx
COPY src/ /usr/share/nginx/html
CMD 'nginx'
