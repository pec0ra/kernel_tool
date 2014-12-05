# Setting environment
export EXECDIR=$(cd $(dirname "$0"); pwd)
export ARCH=arm
export CROSS_COMPILE=/home/basile/Android/Development/toolchains/arm-cortex_a15-linux-gnueabihf-linaro_4.9.1-2014.05/bin/arm-cortex_a15-linux-gnueabihf-
export KBUILD_BUILD_USER=pec0ra
export KERNELS_PATH=~/Android/Development/kernels
export PACKING_PATH=~/Android/Development/build_tools/msm8960t_viskan
export FINALS_PATH=~/Android/Development/final
export DEFCONFIG="huashan_defconfig"
export CORES_NUMBER=4
export MAKE_OPTIONS="CONFIG_NO_ERROR_ON_MISMATCH=y"

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

