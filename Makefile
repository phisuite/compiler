ERROR="LIB not defined"

GOSRC?=${HOME}/go/src
PYTHON_VERSION?=3.8.1
SYS_PY?=${HOME}/.pyenv/versions/${PYTHON_VERSION}/bin/python
PYTHON?=.venv/bin/python
2TO3?=.venv/bin/2to3
DIR?=../${LIB}

all:
	make go LIB=data
	make go LIB=schema
	make gateway LIB=data
	make gateway LIB=schema
	make python LIB=data
	make python LIB=schema

go:
ifdef LIB
	protoc \
	-I=${HOME}/.protoc/include \
	-I=${DIR} \
	-I=${GOSRC} \
	-I=${GOSRC}/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	--go_out=plugins=grpc:${DIR}.go \
	--go_opt=paths=source_relative \
	${DIR}/*.proto
else
	echo ${ERROR}
endif

gateway:
ifdef LIB
	protoc \
	-I=${HOME}/.protoc/include \
	-I=${DIR} \
	-I=${GOSRC} \
	-I=${GOSRC}/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	--go_out=plugins=grpc:${DIR}.gw \
	--grpc-gateway_out=logtostderr=true:${DIR}.gw \
	--go_opt=paths=source_relative \
	--grpc-gateway_opt=paths=source_relative \
	${DIR}/*.proto
else
	echo ${ERROR}
endif

python:
ifdef LIB
	${PYTHON} -m grpc_tools.protoc \
	-I=${HOME}/.protoc/include \
	-I=${DIR} \
	-I=${GOSRC} \
	-I=${GOSRC}/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	--python_out=${DIR}.py/phisuite/${LIB} \
	--grpc_python_out=${DIR}.py/phisuite/${LIB} \
	${DIR}/*.proto && \
	${2TO3} ${DIR}.py/phisuite/${LIB} -w -n
else
	echo ${ERROR}
endif

install:
	go mod download
	${SYS_PY} -m venv .venv && \
	${PYTHON} -m pip install -r requirements.txt

clean:
ifdef LIB
	rm ${DIR}.go/*.pb.go & \
	rm ${DIR}.gw/*.pb.go ${DIR}.gw/*.gw.go & \
	rm ${DIR}.py/phisuite/${LIB}/*pb2*.py
else
	echo ${ERROR}
endif

reset:
	make clean LIB=data
	make clean LIB=schema
