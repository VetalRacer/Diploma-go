#builder

FROM golang:alpine AS builder
WORKDIR /app
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

#RUN mkdir -p /src/myapp
#COPY . /src/myapp
#WORKDIR /src/myapp/Diploma-go/app/cmd/app/nhl

CMD ["/app/main"]
