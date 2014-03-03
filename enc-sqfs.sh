#!/bin/bash 

PW=$1
DM="/dev/mapper/cryptsqfs"
SQFS=/img.sqfs


# load from stdin
cat > $SQFS

OUT=${SQFS}.enc
SIZE=$(ls -l --block-size=512 $SQFS | awk '{print $5}')
# 4096 is luks overhead
dd if=/dev/zero of=${OUT} bs=512 count=1 seek=$(($SIZE+4096))
DEV=$(losetup --find --show $OUT)
cryptsetup luksFormat $DEV <<EOF
YES
$PW
$PW
EOF
cryptsetup luksOpen $DEV $(basename $DM) <<EOF
$PW
EOF
dd if=/opt/docker.sqfs of=$DM bs=512
cryptsetup luksClose $(basename $DM)
losetup -d $DEV
echo $(hostname):$OUT
