Kernel tool
===========

Shell script to automate most of kernel building and packing commands.


Warning
-------
This tool can help you enter faster commands that you use a lot when building and packing kernels for android.
But it will NOT be of any use if you don't have a minimal knowledge about how to build kernels.

Before starting
---------------
You will need some directory structure in order to use this tool.
The folders you need are :
```
toolchains      # The path to your toolchains
kernels         # The path where you have your kernel sources (each different kernel in another subdirectory)
build_tools     # The path to DooMLoRD's build tool
final           # The path where you will create your zip files (each different kernel in another subdirectory)
```
Of course, you will need a toolchain and the DooMLoRd's build tools.

At the root of each kernel you compile (on the side of your Makefile), you will need a folder called elf in which you will put your ramdisk called ramdisk.img (You will have to change the name in the script if you use another extension)

You will then have to edit the main variables at the top of kernel_tool.sh to match with your folders.

In your "final" path, you will create a folder for each version of final kernel you export.
In each of this subfolder, you must create a subfolder called zip_content in which you put the extracted content of the zip you want to rezip with your kernel.

An example of structure is :
```
~/Android/
        kernel_tool/
              <this kernel tool>
        toolchains/
              linaro-4.9.1/
                     <your toolchain>
        kernels/
              williams/
                     elf/
                           ramdisk.img
                     Makefile
                     ...
              abricot/
                     elf/
                     Makefile
                     ...
        build_tools/
              msm8960t_viskan/
                     <DooMLoRD's build_tools>
        final/
              williams/
                     zip_content/
                             META-INF/
                                     ...
              abricot/
                     zip_content/
                             ...
```

How to use
----------
Just run 
```
./kernel_tool.sh
```

Main features
--------------
Building :
* clean
* make defconfig
* make
* copy automatically the zImage to your packing path (elf/)

Packing :
* Pack your kernel into .elf or .img file (depending on device)
* Reboot your phone to bootloader via adb
* Flash created .elf or .img via fastboot

Zip building :
* Automatically replace some lines in the updater script to match the name of your new version
(You will probably need to edit the script to match your update script)
* Copy your newly packed .elf or .img to your "final" directory
* Automatically build the new flashable zip file
