FROM nginx:alpine

ENV PORT=8080
ENV REDIRECT_TO=https://shred.yerim-inc.com

COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d/ /etc/nginx/templates/
