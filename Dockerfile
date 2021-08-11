#builder
FROM golang:alpine AS builder
WORKDIR /app

# install psql
RUN apt-get update
RUN apt-get -y install postgresql-client

# make wait-for-postgres.sh executable
RUN chmod +x wait-for-postgres.sh

COPY go.mod /app
RUN go mod download
COPY . /app
RUN go build -o main ./cmd/app/nhl/main.go

#runner
FROM alpine
WORKDIR /app
COPY migrations /app/migrations/
COPY templates /app/templates/
COPY --from=builder /app/main /app/

EXPOSE 80


CMD ["/app/main"]
