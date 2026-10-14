
FROM golang:1.26-alpine AS builder

WORKDIR /app

COPY go.mod ./
COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o app .

FROM alpine:3.22

WORKDIR /app

COPY --from=builder /app/app ./app

EXPOSE 8080

ENV PORT=8080
ENV APP_VERSION=1.0.0

CMD ["./app"]
