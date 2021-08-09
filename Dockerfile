FROM golang:latest

WORKDIR /app

COPY . /app

RUN go mod download

EXPOSE 8080

#RUN mkdir -p /src/myapp
#COPY . /src/myapp
#WORKDIR /src/myapp/Diploma-go/app/cmd/app/nhl

RUN go build -o main ./cmd/app/nhl/main.go
CMD ["/app/main"]
