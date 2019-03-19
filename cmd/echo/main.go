//go:generate protoc -I ../routeguide --go_out=plugins=grpc:../routeguide ../routeguide/route_guide.proto

package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"net"

	"google.golang.org/grpc"

	pb "github.com/kprav33n/grpcecho"
)

var (
	port = flag.Int("port", 9090, "The server port")
)

type echoServer struct {
}

// GetFeature returns the feature at the given point.
func (s *echoServer) Echo(ctx context.Context, msg *pb.Message) (*pb.Message, error) {
	return msg, nil
}
func newServer() *echoServer {
	s := &echoServer{}
	return s
}

func main() {
	flag.Parse()
	lis, err := net.Listen("tcp", fmt.Sprintf("localhost:%d", *port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	var opts []grpc.ServerOption
	grpcServer := grpc.NewServer(opts...)
	pb.RegisterEchoServer(grpcServer, newServer())
	grpcServer.Serve(lis)
}
