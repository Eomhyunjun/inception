FROM alpine:3.15

# Update package list and upgrade out-dated packages
RUN apk update && apk upgrade && \
    apk add --no-cache mariadb mariadb-client

# Move runner
RUN mkdir -p /scripts
COPY tools/run.sh /scripts/run.sh
RUN chmod +x /scripts/run.sh

EXPOSE 3306
ENTRYPOINT ["sh", "/scripts/run.sh"]
