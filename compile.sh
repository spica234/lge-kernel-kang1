#!/bin/sh
# ANYKERNEL compiler script by vadonka v1.0.7
# Date: 2012.01.16
#
# You need to define this below:
######################################################
# KERNEL home directory
export krnlhome=`pwd`
# Compiled files home directory
export comphome=/home/android/android/compiled
# CM7 original lge kernel boot.img location
export cm7bootimg=/home/android/android/cm7orig_kernel
######################################################

if [ -z $1 ]; then
    export RAMHACK=`grep "^CONFIG_RAMHACK" $krnlhome/.config | awk 'BEGIN { FS = "=" } ; { print $2}'`
    echo "RAMHACK: using kernel setting"
else
    if [[ $1 = [0-9]* ]]; then
	export RAMHACK=$1
	echo "RAMHACK: override kernel setting, using specified size: $(($1)) MB"
    else
	echo "Invalid RAMHACK size, revert to the kernel default: $(($RAMHACK))"
	export RAMHACK=`grep "^CONFIG_RAMHACK" $krnlhome/.config | awk 'BEGIN { FS = "=" } ; { print $2}'`    
    fi
fi

if [ "$2" == "shared" ]; then
    CVOUTSIZE="128"
    echo "Using shared memory mode"
else
    CVOUTSIZE=$((128-$RAMHACK))
    echo "Using traditional ramhack mode"
fi

# Carveout size tweak
export CVOUT=`grep "^CONFIG_GPU_MEM_CARVEOUT" $krnlhome/.config`
export CVOUTNEW=`echo 'CONFIG_GPU_MEM_CARVEOUT_SZ='$(($CVOUTSIZE))`
sed -i "s/$CVOUT/$CVOUTNEW/g" $krnlhome/.config

# Auto kernel version
export CBOOST=`grep -c "^CONFIG_NVRM_CPU1_CORE_BOOST" $krnlhome/.config`
export AVPOC=`grep -c "^CONFIG_MAX_AVP_OC_FREQ_BOOST" $krnlhome/.config`
export GPUOC=`grep -c "^CONFIG_MAX_3D_OC_FREQ_BOOST" $krnlhome/.config`
export CVER=`grep "^CONFIG_LOCALVERSION" $krnlhome/.config`

if [ "$2" == "shared" ]; then
    if [ "$CBOOST" == "1" -a "$AVPOC" == "1" -a "$GPUOC" == "1" ]; then
	export NVER=`echo 'CONFIG_LOCALVERSION="-LGEK-AGOCCBS-'$(($RAMHACK))'M"'`
	sed -i "s/$CVER/$NVER/g" $krnlhome/.config
    elif [ "$CBOOST" == "1" -a "$AVPOC" == "1" -a "$GPUOC" == "0" ]; then
	export NVER=`echo 'CONFIG_LOCALVERSION="-LGEK-AOCCBS-'$(($RAMHACK))'M"'`
	sed -i "s/$CVER/$NVER/g" $krnlhome/.config
    elif [ "$CBOOST" == "1" -a "$AVPOC" == "0" -a "$GPUOC" == "1" ]; then
	export NVER=`echo 'CONFIG_LOCALVERSION="-LGEK-GOCCBS-'$(($RAMHACK))'M"'`
	sed -i "s/$CVER/$NVER/g" $krnlhome/.config
    elif [ "$CBOOST" == "1" -a "$AVPOC" == "0" -a "$GPUOC" == "0" ]; then
	export NVER=`echo 'CONFIG_LOCALVERSION="-LGEK-CBS-'$(($RAMHACK))'M"'`
	sed -i "s/$CVER/$NVER/g" $krnlhome/.config
    elif [ "$CBOOST" == "0" -a "$AVPOC" == "1" -a "$GPUOC" == "1" ]; then
	export NVER=`echo 'CONFIG_LOCALVERSION="-LGEK-AGOCS-'$(($RAMHACK))'M"'`
	sed -i "s/$CVER/$NVER/g" $krnlhome/.config
    elif [ "$CBOOST" == "0" -a "$AVPOC" == "1" -a "$GPUOC" == "0" ]; then
	export NVER=`echo 'CONFIG_LOCALVERSION="-LGEK-AOCS-'$(($RAMHACK))'M"'`
	sed -i "s/$CVER/$NVER/g" $krnlhome/.config
    elif [ "$CBOOST" == "0" -a "$AVPOC" == "0" -a "$GPUOC" == "1" ]; then
	export NVER=`echo 'CONFIG_LOCALVERSION="-LGEK-GOCS-'$(($RAMHACK))'M"'`
	sed -i "s/$CVER/$NVER/g" $krnlhome/.config
    else
	export NVER=`echo 'CONFIG_LOCALVERSION="-LGEK-PwrSS-'$(($RAMHACK))'M"'`
	sed -i "s/$CVER/$NVER/g" $krnlhome/.config
    fi
else
    if [ "$CBOOST" == "1" -a "$AVPOC" == "1" -a "$GPUOC" == "1" ]; then
	export NVER=`echo 'CONFIG_LOCALVERSION="-LGEK-AGOCCB-'$(($RAMHACK))'M"'`
	sed -i "s/$CVER/$NVER/g" $krnlhome/.config
    elif [ "$CBOOST" == "1" -a "$AVPOC" == "1" -a "$GPUOC" == "0" ]; then
	export NVER=`echo 'CONFIG_LOCALVERSION="-LGEK-AOCCB-'$(($RAMHACK))'M"'`
	sed -i "s/$CVER/$NVER/g" $krnlhome/.config
    elif [ "$CBOOST" == "1" -a "$AVPOC" == "0" -a "$GPUOC" == "1" ]; then
	export NVER=`echo 'CONFIG_LOCALVERSION="-LGEK-GOCCB-'$(($RAMHACK))'M"'`
	sed -i "s/$CVER/$NVER/g" $krnlhome/.config
    elif [ "$CBOOST" == "1" -a "$AVPOC" == "0" -a "$GPUOC" == "0" ]; then
	export NVER=`echo 'CONFIG_LOCALVERSION="-LGEK-CB-'$(($RAMHACK))'M"'`
	sed -i "s/$CVER/$NVER/g" $krnlhome/.config
    elif [ "$CBOOST" == "0" -a "$AVPOC" == "1" -a "$GPUOC" == "1" ]; then
	export NVER=`echo 'CONFIG_LOCALVERSION="-LGEK-AGOC-'$(($RAMHACK))'M"'`
	sed -i "s/$CVER/$NVER/g" $krnlhome/.config
    elif [ "$CBOOST" == "0" -a "$AVPOC" == "1" -a "$GPUOC" == "0" ]; then
	export NVER=`echo 'CONFIG_LOCALVERSION="-LGEK-AOC-'$(($RAMHACK))'M"'`
	sed -i "s/$CVER/$NVER/g" $krnlhome/.config
    elif [ "$CBOOST" == "0" -a "$AVPOC" == "0" -a "$GPUOC" == "1" ]; then
	export NVER=`echo 'CONFIG_LOCALVERSION="-LGEK-GOC-'$(($RAMHACK))'M"'`
	sed -i "s/$CVER/$NVER/g" $krnlhome/.config
    else
	export NVER=`echo 'CONFIG_LOCALVERSION="-LGEK-PwrS-'$(($RAMHACK))'M"'`
	sed -i "s/$CVER/$NVER/g" $krnlhome/.config
    fi
fi

export CCOMPILER=arm-linux-gnueabi-
export USE_CCACHE=1
make clean
make ARCH=arm CROSS_COMPILE=$CCOMPILER clean
make ARCH=arm CROSS_COMPILE=$CCOMPILER

if [ -e $krnlhome/arch/arm/boot/zImage ]; then
mem=383
nvmem1=128
nvmem2=384

let mem=$mem+$RAMHACK
let nvmem1=$nvmem1-$RAMHACK
let nvmem2=$nvmem2+$RAMHACK
hmem="$mem""M@0M"
hnvmem="$nvmem1""M@""$nvmem2""M"

kver=`grep "^CONFIG_LOCALVERSION" $krnlhome/.config | awk 'BEGIN { FS = "=" } ; { print $2 }' | sed 's/"//g'`
export COMPDIR=$comphome/`date +%Y%m%d-%H%M`$kver
mkdir -p $COMPDIR/modules
cp $krnlhome/arch/arm/boot/zImage $COMPDIR

for m in `find $krnlhome -name '*.ko'`; do
    cp $m $COMPDIR/modules
done

cp $cm7bootimg/boot.img $COMPDIR
abootimg -u $COMPDIR/boot.img -k $COMPDIR/zImage
abootimg -u $COMPDIR/boot.img -c "cmdline = mem=$hmem nvmem=$hnvmem loglevel=0 muic_state=1 \
lpj=9994240 CRC=3010002a8e458d7 vmalloc=256M brdrev=1.0 video=tegrafb console=ttyS0,115200n8 \
usbcore.old_scheme_first=1 tegraboot=sdmmc tegrapart=recovery:35e00:2800:800,linux:34700:1000:800,\
mbr:400:200:800,system:600:2bc00:800,cache:2c200:8000:800,misc:34200:400:800,\
userdata:38700:c0000:800 androidboot.hardware=p990"
abootimg -i $COMPDIR/boot.img > $COMPDIR/boot.img.info
fi
