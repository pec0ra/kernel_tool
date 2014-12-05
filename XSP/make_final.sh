cd $KERNEL_PATH;
clear
echo "----------------------------------------"
echo "|          Make final version          |"
echo "----------------------------------------"
echo
while [ ! $FINAL_PATH ]
do

i=1
for entry in $FINALS_PATH/*
do
	if [ -d "$entry" ]; then
	  	echo "$i : $entry"
	  	i=$((i+1))
	fi
done
echo
echo "Choose your path to put final version:"
read path_number
echo
i=1
for entry in $FINALS_PATH/*
do
	if [ "$i" == "$path_number" ] && [ -d "$entry" ]; then
	  	export FINAL_PATH="$entry"
	  	i=$((i+1))
	elif [ -d "$entry" ]; then
		i=$((i+1))
	fi

done
if [ ! $FINAL_PATH ]; then
	clear
	echo "Wrong number !"
fi
done #while
clear;

if [ -f elf/zImage ] && [ -f elf/kernel.elf ]; then
	
	echo "Your path is set to $FINAL_PATH"
	echo
	echo "Enter the version number"
	read version
	echo
	echo "Enter the version prefix"
	read prefix
	
	# won't remove META-INF because I don't use option -r
	rm $FINAL_PATH/zip_content/*.elf
	
	kernel_name=${prefix}_kernel_v${version}
	
	cp elf/zImage $FINAL_PATH/${prefix}_zImage_v$version
	cp elf/kernel.elf $FINAL_PATH/$kernel_name.elf
	cp $FINAL_PATH/$kernel_name.elf $FINAL_PATH/zip_content/$kernel_name.elf
	


	#
	# /!\ You will probably have to edit this part depending on the updater script you have /!\
	#
	# Replace the lines in updater script with correct version and file names
	sed -i "4s/v[0-9\.]*/v$version/" $FINAL_PATH/zip_content/META-INF/com/google/android/updater-script;
	sed -i "11s/\".*\.elf\"/\"$kernel_name.elf\"/" $FINAL_PATH/zip_content/META-INF/com/google/android/updater-script;
	
	if [ -f $FINAL_PATH/$kernel_name.zip ]; then
		rm $FINAL_PATH/$kernel_name.zip
	fi
	
	cd $FINAL_PATH/zip_content
	
	zip -r $FINAL_PATH/$kernel_name.zip *
	echo
	echo "Finished ! You can find your files in $FINAL_PATH"
	read -p "Press [Enter] to continue" 
	
else
	read -p "Files not found";
	clear;
fi
