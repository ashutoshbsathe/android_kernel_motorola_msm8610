#!/bin/bash

KERNEL_DIR=$PWD
KERNEL_DEFCONFIG=lineage_condor_defconfig
DTBTOOL=$KERNEL_DIR/Dtbtool/
ANY_KERNEL2_DIR=/home/ashutosh/AnyKernel2-master
FINAL_KERNEL_ZIP=NoobKernel.zip
export ARCH="arm"
export CROSS_COMPILE="arm-linaro-linux-androideabi-"
export TOOL_CHAIN_PATH="/home/ashutosh/condorKernel/arm-linaro-linux-androideabi/bin"
export CLANG_TCHAIN="/home/ashutosh/Downloads/clang+llvm-5.0.0-armv7a-linux-gnueabihf/bin/clang"
export LD_LIBRARY_PATH="${TOOL_CHAIN_PATH}/../lib"
export PATH=$PATH:${TOOL_CHAIN_PATH}

kmake() {
        make CC="${CCACHE} ${CLANG_TCHAIN}" \
             CLANG_TRIPLE=armv7a-linux-gnueabihf \
             CROSS_COMPILE=${TOOL_CHAIN_PATH}/${CROSS_COMPILE} \
             HOSTCC="${CLANG_TCHAIN}" \
             $@
}

clean () {
        kmake clean && kmake mrproper
}

compile() {
        kmake $KERNEL_DEFCONFIG
        kmake -j16
}

DTB () {
        $DTBTOOL/dtbToolCM -2 -o $KERNEL_DIR/arch/arm/boot/dtb -s 2048 -p $KERNEL_DIR/scripts/dtc/ $KERNEL_DIR/arch/arm/boot/dts/qcom/
}

AnyKernel () {
        ls $ANY_KERNEL2_DIR
        rm -rf $ANY_KERNEL2_DIR/dtb
        rm -rf $ANY_KERNEL2_DIR/Image.gz
        rm -rf $ANY_KERNEL2_DIR/$FINAL_KERNEL_ZIP
        cp $KERNEL_DIR/arch/arm64/boot/Image.gz $ANY_KERNEL2_DIR/
        cp $KERNEL_DIR/arch/arm/boot/dtb $ANY_KERNEL2_DIR/
        cd $ANY_KERNEL2_DIR/
        zip -r9 $FINAL_KERNEL_ZIP * -x README $FINAL_KERNEL_ZIP
        rm -rf /home/shethfaiyaz4/lol/noob/$FINAL_KERNEL_ZIP
        cp /home/shethfaiyaz4/lol/noob/AnyKernel2-master/$FINAL_KERNEL_ZIP /home/shethfaiyaz4/lol/noob/$FINAL_KERNEL_ZIP
}

GoodBye () {
        cd $KERNEL_DIR
        rm -rf arch/arm/boot/dtb
        rm -rf $ANY_KERNEL2_DIR/$FINAL_KERNEL_ZIP
        rm -rf AnyKernel2/Image.gz
        rm -rf AnyKernel2/dtb
}
clean
compile
#DTB
#AnyKernel
#GoodBye
