%.pb.go: %.proto
	@protoc -I/usr/local/include -I. \
  -I$(GOPATH)/src \
  -I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  --go_out=plugins=grpc:. \
  $<
	@echo "PROTOC $< $@"

%.pb.gw.go: %.proto
	@protoc -I/usr/local/include -I. \
  -I$(GOPATH)/src \
  -I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  --grpc-gateway_out=logtostderr=true:. \
	$<
	@echo "PROTOC [GW] $< $@"

%.swagger.json: %.proto
	@protoc -I/usr/local/include -I. \
  -I$(GOPATH)/src \
  -I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  --swagger_out=logtostderr=true:. \
  $<
	@echo "PROTOC [SWAGGER] $< $@"

.PHONY: all echo gw clean

all: echo gw

echo: echo.pb.go echo.swagger.json
	@go build ./cmd/echo
	@echo "APP $@"

gw: echo.pb.go echo.pb.gw.go echo.swagger.json
	@go build ./cmd/gw
	@echo "APP $@"

clean:
	rm -f *.pb*go *.swagger.json echo gw
