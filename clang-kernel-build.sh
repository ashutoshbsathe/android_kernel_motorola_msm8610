#!/bin/sh
export ARCH=arm
export SUBARCH=arm
export CLANG_TRIPLE="armv7a-linux-gnueabif-"
export CROSS_COMPILE="/home/ashutosh/condorKernel/arm-linaro-linux-androideabi/bin/arm-linaro-linux-androideabi-"
CLANG_TCHAIN="/home/ashutosh/Downloads/clang+llvm-5.0.0-armv7a-linux-gnueabihf/bin"
export LD_LIBRARY_PATH="/home/ashutosh/condorKernel/arm-linaro-linux-androideabi/lib"
export PATH=$PATH:"/home/ashutosh/Downloads/clang+llvm-5.0.0-armv7a-linux-gnueabihf/bin"
make CC="$CLANG_TCHAIN/clang" CPP="$CLANG_TCHAIN/clang++" HOSTCC="$CC" HOSTCXX="$CPP" O=out lineage_condor_defconfig
make CC="$CLANG_TCHAIN/clang" CPP="$CLANG_TCHAIN/clang++" HOSTCC="$CC" HOSTCXX="$CPP" O=out -j8
