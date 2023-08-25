FROM node:11.15.0 as builder
WORKDIR /usr/src/app
COPY ./app .
RUN npm install
RUN npm run builder

FROM node:10.15.0 as runner
WORKDIR /usr/src/app/build
COPY --from=builder /usr/src/app/build .
EXPOSE 8080
CMD ["npx", "http-server"]

