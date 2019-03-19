# Example service using gRPC gateway

## Dependencies

Install the following protobuf depedencies:

```
go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
go get -u github.com/golang/protobuf/protoc-gen-go
```

## Building

Run `make all` to build the application components. This generates two binaries:
`echo` which is the echo service that listens on port 9090 (gRPC only), and the
`gw` which is the gRPC REST gateway that listens on port `8080`.

## Running

- Start echo service: `./echo`
- Start gRPC gateway: `./gw`

## Testing

Now, any message posted to the REST endpoint `http://localhost:8080/v1/echo`
will just be echoed back.

```
$ echo '{"value": "Hello, world!"}' | http :8080/v1/echo
HTTP/1.1 200 OK
Content-Length: 25
Content-Type: application/json
Date: Mon, 18 Mar 2019 23:52:33 GMT
Grpc-Metadata-Content-Type: application/grpc

{
    "value": "Hello, world!"
}
```

**PS:** `http` is the command line HTTP client provided by the Python package
[HTTPie](https://httpie.org/).
