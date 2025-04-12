# Этап сборки
FROM golang:1.21 AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .

RUN go build -o main .

# Финальный образ
FROM debian:bookworm-slim

WORKDIR /app

# Копируем всё из builder
COPY --from=builder /app .

EXPOSE 8080

CMD ["./main"]
