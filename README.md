# Phi Suite Compiler  

| **Homepage** | [https://phisuite.com][0]        |
| ------------ | -------------------------------- | 
| **GitHub**   | [https://github.com/phisuite][1] |

## Overview

This project is used to compile [Phi Suite Schema][2] & [Phi Suite Data][3].  

## Arguments  
  
Use `DIR` to define the directory where to find the proto files and to generate the gRPC code.  
Use `LIB` to define which proto library you wish to compile (_schema_ or _data_).  
  
## Go compilation  
  
Use `make go` to generate the Go code.  
  
> For example, to compile the _schema_ library from the directory at path _../schema_folder_:  
```bash  
make go DIR=../schema_folder LIB=schema
```  
  
## Python compilation  
  
Use `make python` to generate the Python code.  
  
> For example, to compiles the _data_ library from the directory at path _~/a_folder/data_:  
```bash  
make python DIR=~/a_folder/data LIB=data
```  
  
## Install dependencies  
  
To compile go code, we use the [protobuf][10] and [grpc][11] libraries. ([see gRPC Go Quick Start][12])  
To compile python code, we use the [grpc][20] and [grpc tools][21] libraries. ([see gRPC Python Quick Start][22])  
  
> You can install all the dependencies at once:  
```bash  
make install
```   
## Clean code  
  
use `make clean` to remove all the generated code.
  
```bash  
make clean LIB=schema
# or
make clean LIB=data
```  
[0]: https://phisuite.com
[1]: https://github.com/phisuite
[2]: https://github.com/phisuite/schema
[3]: https://github.com/phisuite/data
[10]: https://github.com/golang/protobuf  
[11]: https://github.com/grpc/grpc  
[12]: https://www.grpc.io/docs/quickstart/go/  
[20]: https://pypi.org/project/grpcio/  
[21]: https://pypi.org/project/grpcio-tools/  
[22]: https://www.grpc.io/docs/quickstart/python/