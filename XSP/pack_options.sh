cd $KERNEL_PATH;
clear
echo "----------------------------------------"
echo "|           Packing options            |"
echo "----------------------------------------"
echo
echo "1 : Reboot via adb, pack and fastboot flash"
echo "2 : Pack and fastboot flash"
echo "3 : Custom"
echo "m : return to main menu"
echo
echo "Choose your function :"
read option
case $option in
	1) 	sudo adb reboot-bootloader;
		python $PACKING_PATH/mkelf.py -o elf/kernel.elf elf/zImage@0x80208000 elf/ramdisk.img@0x81900000,ramdisk $PACKING_PATH/RPM.bin@0x00020000,rpm $PACKING_PATH/bootcmd@0x00000000,cmdline;
		sudo fastboot flash boot elf/kernel.elf;;
	2) 	python $PACKING_PATH/mkelf.py -o elf/kernel.elf elf/zImage@0x80208000 elf/ramdisk.img@0x81900000,ramdisk $PACKING_PATH/RPM.bin@0x00020000,rpm $PACKING_PATH/bootcmd@0x00000000,cmdline;
		sudo fastboot flash boot elf/kernel.elf;;
	3) 	echo "Do you want to reboot to bootloader via adb ? (y/n, default n)";
		read rebootQ ;
		if [ "$rebootQ" == "y" ]; then
			sudo adb reboot-bootloader;
		fi;
		echo "Do you want to pack the zImage to elf ? (y/n, default n)";
		read elfQ ;
		if [ "$elfQ" == "y" ]; then
			python $PACKING_PATH/mkelf.py -o elf/kernel.elf elf/zImage@0x80208000 elf/ramdisk.img@0x81900000,ramdisk $PACKING_PATH/RPM.bin@0x00020000,rpm $PACKING_PATH/bootcmd@0x00000000,cmdline;
		fi;
		echo "Do you want to fastboot flash the elf ? (y/n, default n)";
		read flashQ ;
		if [ "$flashQ" == "y" ]; then
			sudo fastboot flash boot elf/kernel.elf;
		fi;;
	m) exit;;
esac

echo "Do you want to reboot from fastboot ? (y/n, default y)";
read rebootQ ;
if [ "$rebootQ" != "n" ]; then
	sudo fastboot reboot;
fi;
