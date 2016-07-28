while true # Main loop
do
	cd $KERNEL_PATH;
	clear
	echo "----------------------------------------"
	echo "|          Building options            |"
	echo "----------------------------------------"
	echo
	echo "1 : clean"
	echo "2 : make defconfig"
	echo "3 : make"
	echo "m : return to main menu"
	echo
	echo "Choose your function :"
	read option
	case $option in
		1) 	make clean; read -p "Press [Enter] to continue" ;;
		2) 	make $DEFCONFIG; read -p "Press [Enter] to continue" ;;
		3)	clear;
			echo "Enter the local version number or keep empty for default"
			read localversion;
			if [ "$localversion" == "" ]; then
				localversion="test";
				echo "Starting compilation of test version";
			else
				localversion="v$localversion";
				echo "Starting compilation of $localversion";
			fi;
		 	make -j$CORES_NUMBER $MAKE_OPTIONS LOCALVERSION="$localversion";
			read -p "Press [Enter] to continue";
			echo "Do you want to copy the zImage to your packing path ? (y/n, default y)";
			read copyQ ;
			if [ "$copyQ" != "n" ]; then
				cp arch/arm/boot/zImage elf/;
			fi;
			echo "Do you want to go to the packing options ? (y/n, default y)";
			read packQ ;
			if [ "$packQ" != "n" ]; then
				$EXECDIR/pack_options.sh;
			else
				read -p "Press [Enter] to continue" 
			fi;;
		m) 	exit;;
	esac 
done # Main loop

clear
