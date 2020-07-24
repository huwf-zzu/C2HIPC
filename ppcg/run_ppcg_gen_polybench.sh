#!/bin/bash

EXE_OUTPUT=result_exe
GPUCC=nvcc
GPUCC_OPTIONS=
POLYBENCH_DIR=@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
POLYBENCH_OPTIONS= "-DPOLYBENCH_TIME -DLARGE_DATASET"
H_TAIL=_host.cu
K_TAIL=_kernel.cu


mkdir -p $EXE_OUTPUT 

cp $POLYBENCH_DIR/utilities/polybench.c ./polybench.cu

for i in `cat $POLYBENCH_DIR/utilities/benchmark_list`;do
	echo $i
	name=`basename $i`
	name=${name%.c}
	dir=`dirname $i`
	
	echo $GPUCC polybench.cu $name/$name$H_TAIL $name/$name$K_TAIL \
	-I$POLYBENCH_DIR/$dir -I$POLYBENCH_DIR/utilities $POLYBENCH_OPTIONS \
	$GPUCC_OPTIONS -o $EXE_OUTPUT/$name

	$GPUCC polybench.cu $name/$name$H_TAIL $name/$name$K_TAIL \
	-I$POLYBENCH_DIR/$dir -I$POLYBENCH_DIR/utilities $POLYBENCH_OPTIONS \
	$GPUCC_OPTIONS -o $EXE_OUTPUT/$name

done
