FROM node:18-alpine as build

WORKDIR /app

RUN apk add --no-cache git \
    && yarn install --frozen-lockfile \
    && yarn cache clean

COPY . .


FROM ubuntu
RUN apt-get update
RUN apt-get install nginx -y
COPY --from=build /app/ /var/www/html/
EXPOSE 80
CMD ["nginx","-g","daemon off;"]

