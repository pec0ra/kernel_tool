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
		$PACKING_PATH/mkqcdtbootimg --kernel elf/zImage --ramdisk elf/ramdisk.cpio.gz --base 0x00000000 --ramdisk_offset 0x02000000 --tags_offset 0x01E00000 --pagesize 2048 --cmdline "console=ttyHSL0,115200,n8 androidboot.hardware=qcom user_debug=23 msm_rtb.filter=0x3b7 ehci-hcd.park=3 androidboot.bootdevice=msm_sdcc.1 vmalloc=300M dwc3.maximum_speed=high dwc3_msm.prop_chg_detect=Y" --dt_dir arch/arm/boot/ --dt_version 2 -o elf/boot.img
		sudo fastboot flash boot elf/boot.img;;
	2) 	$PACKING_PATH/mkqcdtbootimg --kernel elf/zImage --ramdisk elf/ramdisk.cpio.gz --base 0x00000000 --ramdisk_offset 0x02000000 --tags_offset 0x01E00000 --pagesize 2048 --cmdline "console=ttyHSL0,115200,n8 androidboot.hardware=qcom user_debug=23 msm_rtb.filter=0x3b7 ehci-hcd.park=3 androidboot.bootdevice=msm_sdcc.1 vmalloc=300M dwc3.maximum_speed=high dwc3_msm.prop_chg_detect=Y" --dt_dir arch/arm/boot/ --dt_version 2 -o elf/boot.img
		sudo fastboot flash boot elf/boot.img;;
	3) 	echo "Do you want to reboot to bootloader via adb ? (y/n, default n)";
		read rebootQ ;
		if [ "$rebootQ" == "y" ]; then
			sudo adb reboot-bootloader;
		fi;
		echo "Do you want to pack the zImage to elf ? (y/n, default n)";
		read elfQ ;
		if [ "$elfQ" == "y" ]; then
			$PACKING_PATH/mkqcdtbootimg --kernel elf/zImage --ramdisk elf/ramdisk.cpio.gz --base 0x00000000 --ramdisk_offset 0x02000000 --tags_offset 0x01E00000 --pagesize 2048 --cmdline "console=ttyHSL0,115200,n8 androidboot.hardware=qcom user_debug=23 msm_rtb.filter=0x3b7 ehci-hcd.park=3 androidboot.bootdevice=msm_sdcc.1 vmalloc=300M dwc3.maximum_speed=high dwc3_msm.prop_chg_detect=Y" --dt_dir arch/arm/boot/ --dt_version 2 -o elf/boot.img
		fi;
		echo "Do you want to fastboot flash the elf ? (y/n, default n)";
		read flashQ ;
		if [ "$flashQ" == "y" ]; then
			sudo fastboot flash boot elf/boot.img;
		fi;;
	m) exit;;
esac

echo "Do you want to reboot from fastboot ? (y/n, default y)";
read rebootQ ;
if [ "$rebootQ" != "n" ]; then
	sudo fastboot reboot;
fi;
