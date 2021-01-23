#!/bin/bash

INSTALL_ENV_PATH=/home/huwf/compiler/other_env/set_ppcg_install.sh

#get submodule
#cp /raid/huwf_dev/build/c2hipc_v0.11/pet ./ -r

./autogen.sh

source $INSTALL_ENV_PATH

./configure --prefix=$PWD

make

make install

sh my_polybench_test.sh
