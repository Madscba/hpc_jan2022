TARGET= poisson_gpu
OBJS	= main.o jacobi.o frobenius.o matrix_init.o matrix_overwrite.o alloc3d.o alloc3d_gpu.o transfer3d_gpu.o

OPT	= -O3
ISA	= 
PARA	= -fopenmp

XOPTS = -Xptxas=-v -arch=sm_80 -lineinfo

CC	= gcc

CCC	= g++
CXX	= nvcc
CXXFLAGS= --compiler-options "$(OPT) $(PARA)" $(XOPTS)

CFLAGS	= $(OPT) $(ISA) $(PARA) $(XOPT)

CUDA_PATH ?= /appl/cuda/11.5.1
INCLUDES = -I$(CUDA_PATH)/include -I$(CUDA_PATH)/samples/common/inc

all: $(TARGET)

$(TARGET): $(OBJS) 
	$(CXX) $(CXXFLAGS) -o $@ $(OBJS) $(INCLUDES)

.SUFFIXES: .cu
.cu.o:
	$(CXX) -o $*.o -c $*.cu $(CXXFLAGS) $(SOFLAGS) $(INCLUDES)

clean:
	@/bin/rm -f *.o $(TARGET)
