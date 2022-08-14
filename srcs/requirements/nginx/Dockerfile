FROM alpine:3.15

# Update package list and upgrade out-dated packages
RUN apk update && apk upgrade && \
    apk add --no-cache nginx openssl

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -out /etc/ssl/certs/heom.crt \
        -keyout /etc/ssl/heom.pem \
        -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=heom/CN=heom.42.fr"

#To store pid file
RUN mkdir -p /run/nginx

COPY ./conf/inception.conf /etc/nginx/http.d/default.conf

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
