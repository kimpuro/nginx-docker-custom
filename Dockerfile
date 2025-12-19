FROM nginx:alpine

ENV PORT=8080
ENV REDIRECT_TO=https://example.com

COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d/ /etc/nginx/templates/
