ERROR="Lib not defined"

PYTHON_VERSION?=3.8.1
PYTHON?=~/.pyenv/versions/${PYTHON_VERSION}/bin/python
DIR?=../proto-${LIB}

all:
	make go LIB=data
	make go LIB=schema
	make python LIB=data
	make python LIB=schema

go:
ifdef LIB
	protoc \
	-I=${DIR}/proto \
	--go_out=plugins=grpc:${DIR}/go \
	${DIR}/proto/*.proto
else
	echo ${ERROR}
endif

python:
ifdef LIB
	${PYTHON} -m grpc_tools.protoc \
	-I=${DIR}/proto \
	--python_out=${DIR}/python/phisuite/${LIB} \
	--grpc_python_out=${DIR}/python/phisuite/${LIB} \
	${DIR}/proto/*.proto
else
	echo ${ERROR}
endif

install:
	go get -u github.com/golang/protobuf/protoc-gen-go
	go get -u google.golang.org/grpc
	${PYTHON} -m pip install grpcio grpcio-tools

clean:
ifdef LIB
	rm ${DIR}/go/*.pb.go & \
	rm ${DIR}/python/phisuite/${LIB}/*_pb2.py ${DIR}/python/phisuite/${LIB}/*_pb2_grpc.py
else
	echo ${ERROR}
endif
