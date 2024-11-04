# Stage 1: Build the Go application
FROM golang:1.22.5 as base

WORKDIR /app

COPY go.mod . 
RUN go mod download 

COPY . . 
RUN go build -o main . 

# Stage 2: Create a smaller, more secure distroless image
FROM gcr.io/distroless/base

COPY --from=base /app/main . 
COPY --from=base /app/static ./static 

EXPOSE 8080 
CMD ["./main"] 
