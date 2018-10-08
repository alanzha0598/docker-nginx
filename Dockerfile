FROM alanzha0598/docker-nginx
COPY src/ /var/www
CMD 'nginx'
