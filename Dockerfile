FROM node:11.15.0 as builder

WORKDIR /app

COPY app/package.json app/package-lock.json .
# use package.json as it is
RUN npm ci 

COPY app/ . 
RUN npm run build

######

FROM docker.io/caddy:2.7.4-alpine as caddy
COPY ./Caddyfile /etc/caddy/Caddyfile
COPY --from=builder /app/build /srv
