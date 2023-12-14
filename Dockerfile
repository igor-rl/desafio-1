# Parte 1: Construção
FROM golang:alpine as builder

WORKDIR /app
COPY go.mod .
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o main -a -installsuffix cgo .

FROM scratch

WORKDIR /app

COPY --from=builder /app/main .

CMD ["./main"]
