!/bin/sh

# Title			:scale-validation.sh
# Description	:SWQC valadation check of parts and system config for TrueNAS TRUENAS-R60 Scale Systems
# Author		:Juan Garcia
# Date			:05-19-2022
# Version		:0.1


# DIRECTIONS:

# STEP 1: Within same directory as scale-validation.sh
# create .txt file with list of TrueNAS SCALE GUI ips file called ip.txt
# one line per ip







# STEP 2

# Collection folder
# Making temp file for swqc check txt
# This is directory where the data we collect will go

cd /tmp
mkdir swqc-tmp

touch swqc-tmp/warning.txt
touch swqc-tmp/swqc-output.txt
touch swqc-tmp/serialnumber-output.txt
touch swqc-tmp/parts-list.txt
touch swqc-tmp/$SERIAL-PorF.txt








# STEP 3

# run script:
# two ways direcly or remotly using run-scale-validation.sh

# method 1:

# a. run
# cat scale-validation.sh | sshpass -vp abcd1234 ssh -tt -oStrictHostKeyChecking=no root@<True Gui ip> -yes
# b. Collect output from data collection folder

# Method 2:

# run via scale-validation.sh
# a. Enter TrueNAS Gui ips of systems you wish to valadate into ip.txt
# b. Run scale-validation.sh
# c. Collect output from data collection folder


cd /tmp

echo "Collecting Serial Number:" >> swqc-tmp/swqc-output.txt





dmidecode -t1 | grep -i serial >> swqc-tmp/swqc-output.txt

dmidecode -t1 | grep -E -o -i "A1.{0,6}" >> swqc-tmp/serialnumber-output.txt


SERIAL=$( cat swqc-tmp/serialnumber-output.txt)


echo "Your systems serial number is $SERIAL"
echo "Your systems serial number is $SERIAL" >> swqc-tmp/swqc-output.txt
touch swqc-tmp/$SERIAL-part-count.txt
touch swqc-tmp/$SERIAL-diffme.txt
touch swqc-tmp/$SERIAL-PorF.txt


psql -h std.ixsystems.com -U std2 -d std2 -c "select c.name, a.model, a.serial, a.rma, a.revision, a.support_number from production_part a, production_system b, production_type c, production_configuration d where a.system_id = b.id and a.type_id = c.id and b.config_name_id = d.id and b.system_serial = 'A1-92009' order by b.system_serial, a.type_id, a.model, a.serial;" | grep -i memory  | cut -d "|"  -f6 | tr -dc [0-9] > std-memcount.txt



echo " Product description " >> swqc-tmp/swqc-output.txt


echo "Verify system is tagged correctly and has the correct version" >> swqc-tmp/swqc-output.txt


# Get Product Name


dmidecode -t1 | grep -i --color "Product Name" >> swqc-tmp/swqc-output.txt

dmidecode -t1 | grep -i --color "Product Name"  > swqc-tmp/product-output.txt


PRODUCT=$( cat swqc-tmp/product-output.txt)



echo "===============================" >> swqc-tmp/$SERIAL-part-count.txt
echo "===============================" >> swqc-tmp/$SERIAL-part-count.txt

echo "Product" >> swqc-tmp/$SERIAL-part-count.txt


echo "$PRODUCT" >> swqc-tmp/$SERIAL-part-count.txt

echo "Product" >> swqc-tmp/$SERIAL-diffme.txt

echo "$PRODUCT" >> swqc-tmp/$SERIAL-diffme.txt

dmidecode -t1 | grep -i version >> swqc-tmp/swqc-output.txt

dmidecode -t1 | grep -i version > swqc-tmp/pversion-output.txt


PVERSION=$( cat swqc-tmp/pversion-output.txt)

echo "Product Version" >> swqc-tmp/$SERIAL-part-count.txt
echo "$PVERSION" >> swqc-tmp/$SERIAL-part-count.txt


echo "Product Version" >> swqc-tmp/$SERIAL-diffme.txt

echo "$PVERSION" >> swqc-tmp/$SERIAL-diffme.txt



echo "===============================" >> swqc-tmp/$SERIAL-part-count.txt
echo "===============================" >> swqc-tmp/swqc-output.txt



# Get TrueNAS SCALE version:

echo  "Retreiving TrueNAS SCALE verson"


cat  /etc/version >> swqc-tmp/swqc-output.txt

cat /etc/version > swqc-tmp/version-output.txt


VERSION=$( cat swqc-tmp/version-output.txt)

echo "TrueNAS Version" >> swqc-tmp/$SERIAL-part-count.txt
echo "$VERSION" >> swqc-tmp/$SERIAL-part-count.txt


echo "TrueNAS Version" >> swqc-tmp/$SERIAL-diffme.txt
echo "$VERSION" >> swqc-tmp/$SERIAL-diffme.txt

echo "===============================" >> swqc-tmp/swqc-output.txt



echo "Checking for TrueNAS License " >> swqc-tmp/swqc-output.txt


cat /data/license >> swqc-tmp/swqc-output.txt
cat /data/license >  swqc-tmp/license.txt

LICENSE=$(cat swqc-tmp/license.txt)

echo "TrueNAS License" >> swqc-tmp/$SERIAL-part-count.txt

echo "$LICENSE" >> swqc-tmp/$SERIAL-part-count.txt

echo "===============================" >> swqc-tmp/$SERIAL-part-count.txt
echo "===============================" >> swqc-tmp/$SERIAL-part-count.txt


echo "===============================" >> swqc-tmp/swqc-output.txt

# Get Start time and date of SWQC Check


date > swqc-tmp/start-time-output.txt
date >> swqc-tmp/swqc-output.txt


echo "===============================" >> swqc-tmp/swqc-output.txt


STARTTIME=$( cat swqc-tmp/start-time-output.txt)


echo " $SWQCPERSON commencing SWQC on $PRODUCT \ $ORDER Number \ Serial Number: $SERIAL \ Start Time: $STARTTIME " >> swqc-tmp/swqc-output.txt
printf "$COLUMNS" |tr " " "" >> swqc-tmp/swqc-output.txt





echo "===============================" >> swqc-tmp/swqc-output.txt





echo "Motherboard, Memory, and CPU information" >> swqc-tmp/swqc-output.txt




# Verify that the motherboard and version are correct:





echo "Verify that the motherboard and version are correct" >> swqc-tmp/swqc-output.txt
echo "Check that the bios is the correct version for this motherboard" >> swqc-tmp/swqc-output.txt




dmidecode -t2 | egrep -iA1 --color 'Product|Version' >> swqc-tmp/swqc-output.txt

dmidecode -t2 | egrep -iA1 --color 'Product|Version' > swqc-tmp/motherboard-output.txt


MOTHERBOARD=$( cat swqc-tmp/motherboard-output.txt)


echo "===============================" >> swqc-tmp/$SERIAL-part-count.txt


echo "The product name and version of your motherboard is $MOTHERBOARD"


echo "Motherboard" >> swqc-tmp/$SERIAL-part-count.txt

echo "$MOTHERBOARD" >> swqc-tmp/$SERIAL-part-count.txt


echo "===============================" >> swqc-tmp/$SERIAL-part-count.txt


# Get BIOS version and verify that it is the correct version for this motherboard


dmidecode -t bios info | grep -i version >> swqc-tmp/swqc-output.txt

dmidecode -t bios info | grep -i version > swqc-tmp/biosversion-output.txt


BIOVER=$( cat swqc-tmp/biosversion-output.txt)


echo "Bios Verison" >> swqc-tmp/$SERIAL-part-count.txt

echo "$BIOVER" >> swqc-tmp/$SERIAL-part-count.txt





if $(echo "$PRODUCT"|fgrep -wqi -e TRUENAS-R60 ) && $(echo "$BIOVER" | grep -oh "\w*V8.103.ROM\w*"| fgrep -wqi -e V8.103.ROM); then

  echo "Bios version for TRUENAS-R60 is correctly showing as V8.103.ROM"  >> swqc-tmp/swqc-output.txt
  echo "Bios version for TRUENAS-R60 is correctly showing as V8.103.ROM"  > swqc-tmp/R60Bbios.txt
  echo "Bios version" >> swqc-tmp/$SERIAL-diffme.txt
  echo "Correctly showing as V8.103.ROM" >> swqc-tmp/$SERIAL-part-count.txt
  echo "Correctly showing as V8.103.ROM" >> swqc-tmp/$SERIAL-diffme.txt

elif $(echo "$PRODUCT"| fgrep -wqi -e TRUENAS-R60) && $(echo "$BIOVER" | grep -oh "\w*V8.103.ROM\w*" != V8.103.ROM); then

  echo "Bios version for TRUENAS-R60 is showing as $BIOVER it should be  V8.103.ROM" >> swqc-tmp/swqc-output.txt
  echo "Bios version for TRUENAS-R60 is showing as $BIOVER it should be  V8.103.ROM" > swqc-tmp/R60Bbios.txt
  echo "Bios version for TRUENAS-R60 is showing as $BIOVER it should be  V8.103.ROM" >> swqc-tmp/warning.txt
  echo "Bios version is showing as $BIOVER it should be V8.103.ROM" >> swqc-tmp/$SERIAL-part-count.txt
  echo "Bios version" >> swqc-tmp/$SERIAL-diffme.txt
  echo "Bios version is showing as $BIOVER it should be V8.103.ROM" >> swqc-tmp/$SERIAL-diffme.txt


  R60BBIOV=$(cat swqc-tmp/R60Bbios.txt)


fi



echo "===============================" >> swqc-tmp/$SERIAL-part-count.txt

# Get BMC info


echo "Make sure that the IPMI has the correct firmware" >> swqc-tmp/swqc-output.txt


ipmitool bmc info | grep -i "firmware revision" >> swqc-tmp/swqc-output.txt

ipmitool bmc info | grep -i "firmware revision" > swqc-tmp/bmc-output.txt


BMCINFO=$( cat swqc-tmp/bmc-output.txt)


echo " IMPI BMC Firmware" >> swqc-tmp/$SERIAL-part-count.txt
echo " IMPI BMC Firmware" >> swqc-tmp/$SERIAL-diffme.txt


echo "$BMCINFO" >> swqc-tmp/$SERIAL-part-count.txt





if $(echo "$PRODUCT"|fgrep -wqi -e TRUENAS-R60 ) && $(echo "$BMCINFO" | grep -oh "\w*1.71\w*"| fgrep -wqi -e 1.71); then
  echo "BMC firmware for TRUENAS-R60 is correctly showing as $BMCINFO it should be  1.71" >> swqc-tmp/swqc-output.txt
  echo "BMC firmware for TRUENAS-R60 is correctly showing as $BMCINFO it should be  1.71" > swqc-tmp/R50-bmc.txt
  echo "Correctly showing as $BMCINFO it should be  1.71" >> swqc-tmp/$SERIAL-part-count.txt
  echo "BMC firmware" >> swqc-tmp/$SERIAL-diffme.txt
  echo "Correctly showing as $BMCINFO it should be  1.71"


elif $(echo "$PRODUCT"| fgrep -wqi -e TRUENAS-R60) && $(echo "$BMCINFO" | grep -oh "\w*1.71\w*" != 1.71); then

  echo "BMC firmware for TRUENAS-R60 is showing as $BMCINFO it should be 1.71" >> swqc-tmp/swqc-output.txt
  echo "BMC firmware for TRUENAS-R60 is showing as $BMCINFO it should be  1.71" > swqc-tmp/R50-bmc.txt
  echo "BMC firmware for TRUENAS-R60 is showing as $BMCINFO it should be  1.71" >> swqc-tmp/warning.txt
  echo "Bios version for TRUENAS-R60 is showing as $BMCINFO it should be  1.71" >> swqc-tmp/$SERIAL-part-count.txt
  echo "BMC firmware" >> swqc-tmp/$SERIAL-diffme.txt
  echo "BMC firmware is showing as $BMCINFO it should be  1.71" >> swqc-tmp/$SERIAL-diffme.txt


  R60MC=$(cat swqc-tmp/R50-bmc.txt)

fi





echo "===============================" >> swqc-tmp/$SERIAL-part-count.txt


echo "===============================" >> swqc-tmp/swqc-output.txt

# Enclosure Information

sesutil map| more| egrep -i "Enclosure Name" >> swqc-tmp/swqc-output.txt
sesutil map| more| egrep -i "Enclosure Name" > swqc-tmp/enclosure-info.txt

ENCLOSUREINFO=$(cat swqc-tmp/enclosure-info.txt)

echo " Ecnlosure Name" >> swqc-tmp/$SERIAL-part-count.txt
echo "$ENCLOSUREINFO" >> swqc-tmp/$SERIAL-part-count.txt

echo "===============================" >> swqc-tmp/swqc-output.txt


echo " HBA information " >> swqc-tmp/swqc-output.txt

sas3flash -listall >> swqc-tmp/swqc-output.txt
sas3flash -listall > swqc-tmp/sas3flashall-output.txt

SAS3FLASHAINFO=$(cat swqc-tmp/sas3flashall-output.txt)


echo "HBA Information" >> swqc-tmp/$SERIAL-part-count.txt

sas3flash -list >> swqc-tmp/swqc-output.txt
sas3flash -list > swqc-tmp/sas3flash-list-ouput.txt

SAS3FLASHLINFO=$(cat swqc-tmp/sas3flash-list-ouput.txt)


echo "$SAS3FLASHLINFO" >> swqc-tmp/$SERIAL-part-count.txt

echo "===============================" >> swqc-tmp/$SERIAL-part-count.txt
echo "===============================" >> swqc-tmp/swqc-output.txt

# Verify Correct CPU and Number


echo "Retrieving list of installed CPU’s"


echo "Check for the correct CPU quanity " >> swqc-tmp/swqc-output.txt


dmidecode -t processor | egrep -i 'cpu|core|version|serial|speed|manufacturer' >> swqc-tmp/swqc-output.txt

dmidecode -t processor | egrep -i 'cpu|core|version|serial|speed|manufacturer' > swqc-tmp/cpu-output.txt


CPU=$( cat swqc-tmp/cpu-output.txt)


echo "CPU Information" >> swqc-tmp/$SERIAL-part-count.txt


echo "$CPU" >> swqc-tmp/$SERIAL-part-count.txt

echo "===============================" >> swqc-tmp/$SERIAL-part-count.txt
echo "===============================" >> swqc-tmp/$SERIAL-part-count.txt



# Verify that Memory is correct




echo "Check the Memory model speed and count against the work order" >> swqc-tmp/swqc-output.txt




dmidecode -t memory | egrep -i 'manufacturer|serial|size|speed|locator' >> swqc-tmp/swqc-output.txt
dmidecode -t memory | egrep -i 'manufacturer|serial|size|speed|locator' > swqc-tmp/meminfo-output.txt


MEMINFO=$( cat swqc-tmp/meminfo-output.txt)


echo "Memory information" >> swqc-tmp/$SERIAL-part-count.txt
echo "Memory information" >> swqc-tmp/$SERIAL-diffme.txt

echo "$MEMINFO" >> swqc-tmp/$SERIAL-part-count.txt

# check total physical memory for each node / system ensure that they match each other and the work order

sysctl -n hw.physmem | awk '{ byte =$1 /1024/1024/1024; print byte " GB" }' >> swqc-tmp/swqc-output.txt
sysctl -n hw.physmem | awk '{ byte =$1 /1024/1024/1024; print byte " GB" }' > swqc-tmp/total-physical-memory.txt

TPM=$(cat swqc-tmp/total-physical-memory.txt)



echo "Total Physical Memory" >> swqc-tmp/$SERIAL-part-count.txt

echo "$TPM" >> swqc-tmp/$SERIAL-part-count.txt


echo "Total Physical Memory" >> swqc-tmp/$SERIAL-diffme.txt

echo "$TPM" >> swqc-tmp/$SERIAL-diffme.txt


# Grabbing total memory count from STD

touch swqc-tmp/std-memcount.txt
touch swqc-tmp/test2.txt

STDMEMCOUNT=$(cat swqc-tmp/std-memcount.txt)


dmidecode -t memory | grep -i hynix | wc -l > swqc-tmp/dmi-memcount.txt

DMIMEMCOUNT=$(cat swqc-tmp/dmi-memcount.txt)


touch swqc-tmp/test1


if $(echo "$STDMEMCOUNT" | fgrep -wqi -e DMIMEMCOUNT); then

  echo "This works" > swqc-tmp/test1.txt
  echo "This works"


elif $(echo "$STDMEMCOUNT" != DMIMEMCOUNT); then
  echo "This does not work" > swqc-tmp/test1.txt
  echo "This does not work"


fi






echo "Memory Size (OS)" >> swqc-tmp/swqc-output.txt
echo "Memory Size (OS)" >> swqc-tmp/$SERIAL-diffme.txt
echo "Memory Size (OS)" >> swqc-tmp/$SERIAL-PorF.txt


psql -h std.ixsystems.com -U std2 -d std2 -c "select c.name, a.model, a.serial, a.rma, a.revision, a.support_number from production_part a, production_system b, production_type c, production_configuration d where a.system_id = b.id and a.type_id = c.id and b.config_name_id = d.id and b.system_serial = 'A1-92017' order by b.system_serial, a.type_id, a.model, a.serial;" | grep -i memory  | cut -d "|"  -f6 | tr -dc [0-9] > swqc-tmp/std-memcount.txt
STDMEM=$(cat swqc-tmp/std-memcount.txt)

dmidecode -t memory | grep  GB | grep Size: | grep -v  -e Volatile | cut -d ":"  -f2 | tr -d GB > swqc-tmp/sys-mem-size.txt

awk '{ sum += $1 } END { print sum }' swqc-tmp/sys-mem-size.txt > swqc-tmp/gig-size.txt
GIGSIZE=$(cat swqc-tmp/gig-size.txt)

echo $(( $GIGSIZE * 1023631.125 )) | tr -d . > swqc-tmp/sys-mem-size.txt
SYSMEMSIZE=$(cat swqc-tmp/sys-mem-size.txt)


free | grep Mem | awk '{print $2}' >> swqc-tmp/swqc-output.txt
free | grep Mem | awk '{print $2}' > swqc-tmp/os-mem-size.txt

OSMEMSIZE=$(cat swqc-tmp/os-mem-size.txt)



if [[ $SYSMEMSIZE == $OSMEMSIZE ]]; then

  echo "Memory Size OS for TrueNAS-R60 is correctly showing as $OSMEMSIZE"  >> swqc-tmp/swqc-output.txt
  echo "Memory Size OS for TrueNAS-R60 is correctly showing as $OSMEMSIZE" > swqc-tmp/memsize-os.txt.txt
  echo "Memory Size OS for TrueNAS-R60 is correctly showing as $OSMEMSIZE" >> swqc-tmp/$SERIAL-part-count.txt
  echo "Memory Size OS for TrueNAS-R60 is correctly showing as $OSMEMSIZE" >> swqc-tmp/$SERIAL-diffme.txt
  echo "Pass" >> swqc-tmp/$SERIAL-PorF.txt

else

  echo "Memory Size OS is showing as $OSMEMSIZE it should read $SYSMEMSIZE" >> swqc-tmp/swqc-output.txt
  echo "Memory Size OS is showing as $OSMEMSIZE it should read $SYSMEMSIZE" > swqc-tmp/.txt
  echo "Memory Size OS is showing as $OSMEMSIZE it should read $SYSMEMSIZE" >> swqc-tmp/warning.txt
  echo "Memory Size OS is showing as $OSMEMSIZE it should read $SYSMEMSIZE" > swqc-tmp/memsize-os.txt.txt
  echo "Memory Size OS is showing as $OSMEMSIZE it should read $SYSMEMSIZE" >> swqc-tmp/$SERIAL-part-count.txt
  echo "Memory Size OS" >> swqc-tmp/$SERIAL-diffme.txt
  echo "Memory Size OS is showing as $OSMEMSIZE it should read $SYSMEMSIZE" >> swqc-tmp/$SERIAL-diffme.txt
  echo "FAILMemory Size OS is showing as $OSMEMSIZE it should read $SYSMEMSIZE" >> swqc-tmp/$SERIAL-PorF.txt



  MEMSIZEOS=$(cat swqc-tmp/memsize-os.txt)


fi



echo "===============================" >> swqc-tmp/swqc-output.txt
echo "===============================" >> swqc-tmp/$SERIAL-part-count.txt
echo "===============================" >> swqc-tmp/$SERIAL-part-count.txt


echo "Network Card information" >> swqc-tmp/swqc-output.txt


echo "Network Card Information" >> swqc-tmp/$SERIAL-part-count.txt

echo "Verify the correct NIC cards are installed" >> swqc-tmp/swqc-output.txt


dmesg | egrep -i --color "Ethernet|Network" >> swqc-tmp/swqc-output.txt
dmesg | egrep -i --color "Ethernet|Network" > swqc-tmp/nic-output.txt


NICS=$( cat swqc-tmp/nic-output.txt)


echo "$NICS" >> swqc-tmp/$SERIAL-part-count.txt



# verify that the nic ports match their interface names


# list of ports

ifconfig -a | sed 's/[ \t].*//;/^$/d'>> swqc-tmp/swqc-output.txt
ifconfig -a | sed 's/[ \t].*//;/^$/d'> swqc-tmp/ports.txt

PORTS=$(cat swqc-tmp/ports.txt)


echo "Ports" >> swqc-tmp/$SERIAL-part-count.txt

cat "$PORTS" >> swqc-tmp/$SERIAL-part-count.txt


ifconfig -a >> swqc-tmp/swqc-output.txt
ifconfig -a > swqc-tmp/ifconfig-output.txt

PORTINFO=$( cat swqc-tmp/ifconfig-output.txt)



echo "$PORTINFO" >> swqc-tmp/$SERIAL-part-count.txt




# Ensure the network port count matches the order:


echo "Port Count " >> swqc-tmp/swqc-output.txt

ifconfig -a |sed 's/[ \t].*//;/^$/d'|egrep -iv "lo0|pflog0"| wc -l >> swqc-tmp/swqc-output.txt
ifconfig -a |sed 's/[ \t].*//;/^$/d'|egrep -iv "lo0|pflog0"| wc -l > swqc-tmp/portcount-output.txt


PORTCOUNT=$( cat swqc-tmp/portcount-output.txt)

echo "Port Count" >> swqc-tmp/$SERIAL-part-count.txt
echo "$PORTCOUNT" >> swqc-tmp/$SERIAL-part-count.txt
echo "Port Count" >> swqc-tmp/$SERIAL-diffme.txt
echo "$PORTCOUNT" >> swqc-tmp/$SERIAL-diffme.txt


echo "===============================" >> swqc-tmp/swqc-output.txt
echo "===============================" >> swqc-tmp/$SERIAL-part-count.txt


echo " Network Settings " >> swqc-tmp/swqc-output.txt


echo " hostname " >> swqc-tmp/swqc-output.txt
hostname >> swqc-tmp/swqc-output.txt
hostname > swqc-tmp/hostname-out.txt


SYSHOSTNAME=$(cat swqc-tmp/hostname-out.txt)


echo " gateway / default route " >> swqc-tmp/swqc-output.txt
netstat -rn | grep -i default >> swqc-tmp/swqc-output.txt
netstat -rn | grep -i default > swqc-tmp/default-route.txt

defaultroute=$(cat swqc-tmp/default-route.txt)


echo " Domain name servers " >> swqc-tmp/swqc-output.txt
cat /etc/resolv.conf >> swqc-tmp/swqc-output.txt
cat /etc/resolv.conf > swqc-tmp/dns-out.txt

DNSSERVERS=$(cat swqc-tmp/dns-out.txt)


echo " ip settings " >> swqc-tmp/swqc-output.txt
ifconfig -a >> swqc-tmp/swqc-output.txt


echo "ipmi network settings " >> swqc-tmp/swqc-output.txt
ipmitool lan print >> swqc-tmp/swqc-output.txt
ipmitool lan print > swqc-tmp/ipmi-out.txt

IPMI=$(cat swqc-tmp/ipmi-out.txt)

echo "===============================" >> swqc-tmp/swqc-output.txt



echo "===============================" >> swqc-tmp/$SERIAL-part-count.txt

echo "Hard Drive and SSD information " >> swqc-tmp/swqc-output.txt

echo "check the model, drive count, and firmware version " >> swqc-tmp/swqc-output.txt

echo "Hard Drive and SSD Information" >> swqc-tmp/$SERIAL-part-count.txt

camcontrol devlist >> swqc-tmp/swqc-output.txt
camcontrol devlist > swqc-tmp/cam-output.txt


CAM=$( cat swqc-tmp/cam-output.txt)


echo "$CAM" >> swqc-tmp/$SERIAL-part-count.txt


echo "drive count" >> swqc-tmp/swqc-output.txt

camcontrol devlist |grep -iv AHCI|grep -iv virtual|grep -E -o -i "pass.{0,6}" | cut -f2 -d, |wc -l >> swqc-tmp/swqc-output.txt
camcontrol devlist |grep -iv AHCI|grep -iv virtual|grep -E -o -i "pass.{0,6}" | cut -f2 -d, |wc -l > swqc-tmp/drivecount-output.txt


DRIVECOUNT=$(cat swqc-tmp/drivecount-output.txt)


echo "Drive Count" >> swqc-tmp/$SERIAL-part-count.txt
echo "Drive Count" >> swqc-tmp/$SERIAL-diffme.txt

echo "$DRIVECOUNT" >> swqc-tmp/$SERIAL-part-count.txt
echo "$DRIVECOUNT" >> swqc-tmp/$SERIAL-diffme.txt


echo "===============================" >> swqc-tmp/swqc-output.txt

echo "NVME Drives" >> swqc-tmp/swqc-output.txt
echo "NVME Drives" >> swqc-tmp/$SERIAL-part-count.txt


smartctl -x /dev/nvme* | grep -i /dev | cut -d/ -f3 | grep -iv ns1 >> swqc-tmp/swqc-output.txt
smartctl -x /dev/nvme* | grep -i /dev | cut -d/ -f3 | grep -iv ns1 >> swqc-tmp/$SERIAL-part-count.txt
smartctl -x /dev/nvme* | grep -i /dev | cut -d/ -f3 | grep -iv ns1 > swqc-tmp/nvmedrives.txt

NVMEDRIVES=$(cat swqc-tmp/nvmedrives.txt)


cat swqc-tmp/nvmedrives.txt | wc -l > swqc-tmp/nvmedrive-count.txt


NVMEDRIVECOUNT=$(cat swqc-tmp/nvmedrive-count.txt)


echo "NVME Drive Count" >> swqc-tmp/$SERIAL-part-count.txt
echo "$NVMEDRIVECOUNT"  >> swqc-tmp/$SERIAL-part-count.txt
echo "NVME Drive Count" >> swqc-tmp/$SERIAL-diffme.txt
echo "$NVMEDRIVECOUNT"  >> swqc-tmp/$SERIAL-diffme.txt


echo "===============================" >> swqc-tmp/swqc-output.txt


echo "device names" >> swqc-tmp/swqc-output.txt


camcontrol devlist |grep -v AHCI|grep -iv virtual|grep -E -o -i "pass.{0,6}" | cut -f2 -d, >> swqc-tmp/swqc-output.txt
camcontrol devlist |grep -v AHCI|grep -iv virtual|grep -E -o -i "pass.{0,6}" | cut -f2 -d, > swqc-tmp/devnames.txt


DEVNAMES=$(cat swqc-tmp/devnames.txt)


echo " Device Names" >> swqc-tmp/$SERIAL-part-count.txt

echo "$DEVNAMES" >> swqc-tmp/$SERIAL-part-count.txt

 camcontrol devlist | grep -i < enter firmware number> | wc -l

# example - camcontrol devlist | grep -i b450 | wc -l

echo "===============================" >> swqc-tmp/$SERIAL-part-count.txt
echo "===============================" >> swqc-tmp/$SERIAL-part-count.txt

echo " Smart Info " >> swqc-tmp/swqc-output.txt


camcontrol devlist | cut -d, -f2 | tr -d \) | grep -v ses | xargs -I DRIVE smartctl -x /dev/DRIVE >> swqc-tmp/swqc-output.txt
camcontrol devlist | cut -d, -f2 | tr -d \) | grep -v ses | xargs -I DRIVE smartctl -x /dev/DRIVE > swqc-tmp/smartout.txt


SMARTOUT=$(cat swqc-tmp/smartout.txt)

echo "Capacity of each Drive" >> swqc-tmp/swqc-output.txt

 for drive in $(camcontrol devlist| grep -iv virtual | cut -f2 -d\( | tr -d ')')
 do
  prefix=$(echo $drive | cut -f1 -d, | cut -c1-2)
 field1=$(echo $drive | cut -f2 -d,)
 field2=$(echo $drive | cut -f2 -d,)
 echo "$field1  - $field2"
 echo -n "$drive - "
 smartctl -x /dev/$drive | grep -i capacity >> swqc-tmp/swqc-output.txt
 smartctl -x /dev/$drive | grep -i capacity > swqc-tmp/drivecap-output.txt
 smartctl -x /dev/$drive >> swqc-tmp/mysmart-out.txt

 DRIVECAP=$(cat swqc-tmp/drivecap-output.txt)
 done

camcontrol devlist | cut -d, -f2 | tr -d \) | grep -v ses | xargs -I DRIVE smartctl -x /dev/DRIVE | egrep -i "device model|serial number|user capacity"  >> swqc-tmp/swqc-output.txt
camcontrol devlist | cut -d, -f2 | tr -d \) | grep -v ses | xargs -I DRIVE smartctl -x /dev/DRIVE | egrep -i "device model|serial number|user capacity"  > swqc-tmp/drivecap-output.txt


DRIVECAP=$(cat swqc-tmp/drivecap-output.txt)


echo "Drive Capacity" >> swqc-tmp/$SERIAL-part-count.txt


echo "$DRIVECAP" >> swqc-tmp/$SERIAL-part-count.txt

echo "===============================" >> swqc-tmp/swqc-output.txt




# Logging Information

echo "Logging Information" >> swqc-tmp/swqc-output.txt
echo "logging Information" >> swqc-tmp/$SERIAL-part-count.txt



echo "MCA errors" >> swqc-tmp/$SERIAL-diffme.txt


touch swqc-tmp/mca-errors.txt

cat /var/log/messages | grep -iC6 MCA | grep -i error >> swqc-tmp/mca-errors.txt
cat /var/log/messages | grep -iC6 MCA | grep -i error >> swqc-tmp/$SERIAL-diffme.txt


MCARRORS=$(cat swqc-tmp/mca-errors.txt)


cat $MCARRORS >> swqc-tmp/$SERIAL-diffme.txt



touch swqc-tmp/mcelog.txt

mcelog >> swqc-tmp/mcelog.txt


echo "===============================" >> swqc-tmp/swqc-output.txt





echo "===============================" >> swqc-tmp/swqc-output.txt


echo "No 3.3V SEL Entries" >> swqc-tmp/swqc-output.txt
echo "No 3.3V SEL Entries" >> swqc-tmp/$SERIAL-diffme.txt
echo "No 3.3V SEL Entries" >> swqc-tmp/$SERIAL-PorF.txt


ipmitool sel list | egrep -c "Voltage 0x54" >> swqc-tmp/p3V-sel-entries.txt
ipmitool sel list | egrep -c "Voltage 0x54" >> swqc-tmp/$SERIAL-diffme.txt



PVSELENTRIES=$(cat swqc-tmp/p3V-sel-entries.txt)




if $(echo "$PVSELENTRIES" | grep -oh "\w*0\w*"| fgrep -wqi -e 0); then

  echo "No 3.3V SEL Entries for TrueNAS-R60 is correctly showing as $3PVSELENTRIES"  >> swqc-tmp/swqc-output.txt
  echo "No 3.3V SEL Entries for TrueNAS-R60 is correctly showing as $3PVSELENTRIES" > swqc-tmp/PVSELENTRIES.txt
  echo "No 3.3V SEL Entries for TrueNAS-R60 is correctly showing as $3PVSELENTRIES" >> swqc-tmp/$SERIAL-part-count.txt
  echo "No 3.3V SEL Entries" >> swqc-tmp/$SERIAL-diffme.txt
  echo "No 3.3V SEL Entries for TrueNAS-R60 is correctly showing as $3PVSELENTRIES" >> swqc-tmp/$SERIAL-diffme.txt
  echo "Pass" >> swqc-tmp/$SERIAL-PorF.txt

elif $(echo "$PRODUCT"| fgrep -wqi -e TrueNAS-R60) && $(echo "$BIOVER" | grep -oh "\w*0\w*" != 0); then

  echo "No 3.3V SEL Entriesis showing as $3PVSELENTRIES it should No 3.3V SEL Entries 0" >> swqc-tmp/swqc-output.txt
  echo "No 3.3V SEL Entriesis showing as $3PVSELENTRIES it should No 3.3V SEL Entries 0" > swqc-tmp/.txt
  echo "No 3.3V SEL Entriesis showing as $3PVSELENTRIES it should No 3.3V SEL Entries 0" >> swqc-tmp/warning.txt
  echo "No 3.3V SEL Entriesis showing as $3PVSELENTRIES it should No 3.3V SEL Entries 0" > swqc-tmp/PVSELENTRIES.txt
  echo "No 3.3V SEL Entriesis showing as $3PVSELENTRIES it should No 3.3V SEL Entries 0" >> swqc-tmp/$SERIAL-part-count.txt
  echo "No 3.3V SEL Entries" >> swqc-tmp/$SERIAL-diffme.txt
  echo "No 3.3V SEL Entriesis showing as $3PVSELENTRIES it should No 3.3V SEL Entries 0" >> swqc-tmp/$SERIAL-diffme.txt
  echo "FAILNo 3.3V SEL Entriesis showing as $3PVSELENTRIES it should No 3.3V SEL Entries 0" >> swqc-tmp/$SERIAL-PorF.txt



  PVSEL=$(cat swqc-tmp/PVSELENTRIES.txt)


fi


echo "===============================" >> swqc-tmp/swqc-output.txt



echo "PCIe Errors in SEL" >> swqc-tmp/swqc-output.txt
echo "PCIe Errors in SEL" >> swqc-tmp/$SERIAL-diffme.txt
echo "PCIe Errors in SEL" >> swqc-tmp/$SERIAL-PorF.txt

ipmitool sel list | grep -c "PCI PERR | Asserted" > swqc-tmp/pcie-error.txt

PCIEERROR=$(cat swqc-tmp/pcie-error.txt)

if $(echo "$PCIEERROR" | grep -oh "\w*0\w*"| fgrep -wqi -e 0); then

  echo "PCIe Errors in SEL for TrueNAS-R60 is correctly showing as $PCIEERROR"  >> swqc-tmp/swqc-output.txt
  echo "PCIe Errors in SEL for TrueNAS-R60 is correctly showing as $PCIEERROR" > swqc-tmp/PVSELENTRIES.txt
  echo "PCIe Errors in SEL for TrueNAS-R60 is correctly showing as $PCIEERROR" >> swqc-tmp/$SERIAL-part-count.txt
  echo "PCIe Errors in SEL for TrueNAS-R60 is correctly showing as $PCIEERROR" >> swqc-tmp/$SERIAL-diffme.txt
  echo "Pass" >> swqc-tmp/$SERIAL-PorF.txt

elif $(echo "$PRODUCT"| fgrep -wqi -e TrueNAS-R60) && $(echo "$BIOVER" | grep -oh "\w*0\w*" != 0); then

  echo "PCIe Errors in SEL is showing as $PCIEERROR it should read 0" >> swqc-tmp/swqc-output.txt
  echo "PCIe Errors in SEL is showing as $PCIEERROR it should read 0" > swqc-tmp/.txt
  echo "PCIe Errors in SEL is showing as $PCIEERROR it should read 0" >> swqc-tmp/warning.txt
  echo "PCIe Errors in SEL is showing as $PCIEERROR it should read 0" > swqc-tmp/PVSELENTRIES.txt
  echo "PCIe Errors in SEL is showing as $PCIEERROR it should read 0" >> swqc-tmp/$SERIAL-part-count.txt
  echo "PCIe Errors in SEL" >> swqc-tmp/$SERIAL-diffme.txt
  echo "PCIe Errors in SEL is showing as $PCIEERROR it should read 0" >> swqc-tmp/$SERIAL-diffme.txt
  echo "FAILPCIe Errors in SEL is showing as $PCIEERROR it should read 0" >> swqc-tmp/$SERIAL-PorF.txt



  PVSEL=$(cat swqc-tmp/3PVSELENTRIES.txt)


fi



echo "===============================" >> swqc-tmp/swqc-output.txt
echo "Sel List"  >> swqc-tmp/$SERIAL-diffme.txt
echo "Sel List" >> swqc-tmp/swqc-output.txt



ipmitool sel list  >> swqc-tmp/swqc-output.txt
ipmitool sel list > swqc-tmp/selinfo-output.txt
ipmitool sel list >> swqc-tmp/$SERIAL-part-count.txt
ipmitool sel list  >> swqc-tmp/$SERIAL-diffme.txt


SELINFO=$( cat swqc-tmp/selinfo-output.txt)


touch swqc-tmp/alert-list.txt
midclt call alert.list > swqc-tmp/alert-list.txt


echo "===============================" >> swqc-tmp/swqc-output.txt




echo "===============================" >> swqc-tmp/swqc-output.txt

# clearning chassis intrusion

ipmitool raw 0x30 0x03


# clearing sel info

ipmitool sel clear


echo "===============================" >> swqc-tmp/swqc-output.txt

echo "point check M" >> swqc-tmp/swqc-output.txt
echo "point check M" > swqc-tmp/pointcheck-M.txt

cd /tmp

# Collect a debug and move it into swq-tmp


freenas-debug -A

 echo " Smart Info " >> swqc-tmp/swqc-output.txt
 cat smart.out | grep -i result >> swqc-tmp/swqc-output.txt
 cat smart.out >> swqc-tmp/swqc-output.txt
mv fndebug swqc-tmp
mv smart.out swqc-tmp

echo " End of Report" >> swqc-tmp/$SERIAL-part-count.txt

# compress output file swqc-tmp

tar cfz "$SERIAL.tar.gz" swqc-tmp/





echo "===============================" >> swqc-tmp/swqc-output.txt



echo "setting up for mounting sj storage"


echo "[ECHONAS.IXSYSTEMS.COM:ROOT]" > ~/.nsmbrc
echo "password=abcd1234" >> ~/.nsmbrc
cat ~/.nsmbrc
mkdir /mnt/sj-storage
mount -t cifs -o username=root,password=abcd1234 //10.246.0.110/sj-storage/ /mnt/sj-storage/
cat /mnt/sj-storage/swqc-output/smbconnection-verified.txt >> swqc-tmp/swqc-output.txt
cat /mnt/sj-storage/swqc-output/smbconnection-verified.txt > swqc-tmp/smb-verified.txt
echo "SJ Storage mounted"



echo "===============================" >> swqc-tmp/swqc-output.txt


echo "Copying tar.gz file to swqc-output on sj-storage"

cd /tmp


cp *.tar.gz /mnt/sj-storage/swqc-output/



echo "Finished copying tar.gz file to swqc-output on sj-storage"



echo "===============================" >> swqc-tmp/swqc-output.txt




echo "Cleanup"









rm -rf swqc-tmp
rm -rf $SERIAL.tar.gz
unset HISTFILE
rm /root/.zsh-histfile

exit
