#!/bin/sh

curDir=`pwd`
version=`date +'%Y.%m.%d'`

mkdir out
mkdir temp

mkdir hp-flash
tar -xvf ./pkg/hp-flash*.tgz --strip-component=2 -C ./hp-flash

mkdir temp/hp-flash

INSTALLTARGET=rh90
cp -p ${curDir}/hp-flash/builds/hp-flash.${INSTALLTARGET} ${curDir}/hp-flash/bin/hp-flash
cp -p ${curDir}/hp-flash/builds/hp-repsetup.${INSTALLTARGET} ${curDir}/hp-flash/bin/hp-repsetup

sed -i 's/\bstrings\b/strings-BSD/g' ${curDir}/hp-flash/hp-flash
sed -i 's/\bstrings\b/strings-BSD/g' ${curDir}/hp-flash/hp-repsetup

install -D -m 0744 ${curDir}/hp-flash/bin/hp-flash              ${curDir}/temp/hp-flash/opt/hp/hp-flash/bin/hp-flash
install -D -m 0744 ${curDir}/hp-flash/hp-flash                  ${curDir}/temp/hp-flash/opt/hp/hp-flash/hp-flash
install -D -m 0644 ${curDir}/hp-flash/docs/hp-flash-README      ${curDir}/temp/hp-flash/opt/hp/hp-flash/docs/hp-flash-README
install -D -m 0744 ${curDir}/hp-flash/bin/hp-repsetup           ${curDir}/temp/hp-flash/opt/hp/hp-flash/bin/hp-repsetup
install -D -m 0744 ${curDir}/hp-flash/hp-repsetup               ${curDir}/temp/hp-flash/opt/hp/hp-flash/hp-repsetup
install -D -m 0644 ${curDir}/hp-flash/docs/hp-repsetup-README   ${curDir}/temp/hp-flash/opt/hp/hp-flash/docs/hp-repsetup-README

cd ${curDir}/temp/hp-flash/ && mkdir -p usr/bin/
ln -fs /opt/hp/hp-flash/hp-flash usr/bin/hp-flash
ln -fs /opt/hp/hp-flash/hp-repsetup usr/bin/hp-repsetup
cd ${curDir}

cd ${curDir}/temp/hp-flash/ && makepkg -l y -c y ${curDir}/out/hp-flash-${version}.tgz && cd ${curDir}
md5sum ${curDir}/out/hp-flash-${version}.tgz | awk '{print $1}' > ${curDir}/out/hp-flash-${version}.tgz.md5

KVERS=`uname -r`

mkdir hpuefi-mod
tar -xvf ./pkg/hpuefi-mod*.tgz --strip-component=2 -C ./hpuefi-mod
cd hpuefi-mod && make && cd ..

mkdir temp/hpuefi-mod
install -D -m 0744 ${curDir}/hpuefi-mod/mkdevhpuefi     ${curDir}/temp/hpuefi-mod/lib/modules/${KVERS}/kernel/drivers/hpuefi/mkdevhpuefi
install -D -m 0744 ${curDir}/hpuefi-mod/hpuefi.ko       ${curDir}/temp/hpuefi-mod/lib/modules/${KVERS}/kernel/drivers/hpuefi/hpuefi.ko

cd ${curDir}/temp/hpuefi-mod/ && makepkg -l y -c y ${curDir}/out/hpuefi-mod-${KVERS}-${version}.tgz && cd ${curDir}
md5sum ${curDir}/out/hpuefi-mod-${KVERS}-${version}.tgz | awk '{print $1}' > ${curDir}/out/hpuefi-mod-${KVERS}-${version}.tgz.md5

# cleanup
rm -r ./temp
rm -r ./hp-flash
rm -r ./hpuefi-mod
