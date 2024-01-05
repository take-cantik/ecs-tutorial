FROM nginx:1.24.0-alpine

ENV TZ=Asia/Tokyo

# nginx config file
COPY ./docker/nginx/*.conf /etc/nginx/conf.d/

WORKDIR /work/src

