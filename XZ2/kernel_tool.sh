# Setting environment
export EXECDIR=$(cd $(dirname "$0"); pwd)
export ARCH=arm
export CROSS_COMPILE=/home/basile/Android/Development/toolchains/arm-cortex_a15-linux-gnueabihf-linaro_4.9.1-2014.05/bin/arm-cortex_a15-linux-gnueabihf- #path to your toolchain
export KBUILD_BUILD_USER=pec0ra # Name of the user who will appear in kernel information
export KERNELS_PATH=~/Android/Development/kernels # The path where you have your kernel sources (each different kernel in another subdirectory)
export PACKING_PATH=~/Android/Development/build_tools/msm8974ab_shinano # The path to DooMLoRD's build tool
export FINALS_PATH=~/Android/Development/final # The path where you will create your zip files (each different kernel in another subdirectory)
export DEFCONFIG="abricot_defconfig" # The name of your defconfig
export CORES_NUMBER=4 # Number of thread used to compile
export MAKE_OPTIONS="CONFIG_NO_ERROR_ON_MISMATCH=y" # Add here any additional option for compilation

clear
echo "----------------------------------------"
echo "|        Starting kernel tool          |"
echo "----------------------------------------"

echo
echo
# =========== CHOSING KERNEL_PATH ============
while [ ! $KERNEL_PATH ]
do

i=1
for entry in $KERNELS_PATH/*
do
	if [ -d "$entry" ]; then
	  	echo "$i : $entry"
	  	i=$((i+1))
	fi
done
echo
echo "Choose your kernel path :"
read path_number
echo
i=1
for entry in $KERNELS_PATH/*
do
	if [ "$i" == "$path_number" ] && [ -d "$entry" ]; then
	  	export KERNEL_PATH="$entry"
	  	i=$((i+1))
	elif [ -d "$entry" ]; then
		i=$((i+1))
	fi
	
done
if [ ! $KERNEL_PATH ]; then
	clear
	echo "Wrong number !"
fi
done #while
clear


while true # Main loop
do
	clear
	echo "----------------------------------------"
	echo "|              Main menu               |"
	echo "----------------------------------------"
	echo
	echo "Your current working path is : "
	echo "$KERNEL_PATH"
	echo
	echo "1 : building options"
	echo "2 : packing options"
	echo "3 : create final version"
	echo "4 : Change path"
	echo "q : exit"
	echo
	echo "Choose your function :"
	read fonction
	
	case $fonction in
		1) $EXECDIR/build_options.sh ;;
		2) $EXECDIR/pack_options.sh ;;
		3) $EXECDIR/make_final.sh;;
		4) break;;
		q) cd $EXECDIR; clear; exit;;
	esac
	if [ "$option" == "q" ]; then
		exit
	fi
	
done # Main loop

export KERNEL_PATH=
export FINAL_PATH=
$EXECDIR/kernel_tool.sh

