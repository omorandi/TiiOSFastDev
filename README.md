#Titanium Mobile FastDev-like solution for iOS
Testing large Titanium Mobile applications on device can be cumbersome, since the build & deploy process can take several minutes, even when the project is launched directly from XCode.

Here is a hackish solution that allows you to change your JS files on the fly and get them pulled by your app (either on device or simulator) without needing to rebuild it, sign it, and re-deploy it.

The solution consists in a bunch of scripts that perform these operations:

1.  patch your Titanium SDK folder (or, better, a copy of it)

2. start an HTTP server in the Resources directory of your Titanium Mobile project

Once these steps are completed, you can build your app and deploy it to the device for testing. Should you find you need to fix some of your program files, just do it, manually restart the app, and proceed with testing without needing to rebuild & redeploy it.

This process is similar to the one involved when using the fastdev feature for Android testing, however it is not quite the same, since the mechanism is not managed by Titanium Studio, and involves a series of steps to be performed manually.

The Ti SDK patching script expects you to work with a 1.8.X Titanium Mobile SDK. It can be modified in order to work with 1.7.X versions, however this is not currently supported.

## How to use it
In the following steps I use the following symbols for the involved directories:

	$TI_FASTDEV_DIR (the directory containing this repository)
	$TI_SDK_DIR (usually /Library/Application\ Support/Titanium)
	$PRJ_DIR (The root directory of your Ti Mobile App project)

1. Check out your Titanium Mobile directory under `$TI_SDK_DIR`. There you'll find one or more directories of the SDKs installed in your system.

2. Create a copy of the SDK directory you want to patch and call it for example `1.8.0-fastdev` (actually you'll want to keep the original SDK directory intact for the normal development workflow)

3. In a terminal window, go to the directory that contains the files of this repository (`$TI_FASTDEV_DIR`) and perform the following:

	./patch.sh 1.8.0-fastdev

4. Launch your Ti Mobile application from Titanium Studio or through your preferred method. This is needed in order to re-create the `build/iphone` directory in your project, with the patched files. If this doesn't happen, just clean the project and relaunch it

5. For your convenience, create an alias for the `startserver.py`script:

	alias fdstart='$TI_FASTDEV_DIR/startserver.py'

6. Then `cd` in the `Resources` directory of your Titanium Mobile application project, for example:

	cd $PRJ_DIR/Resources

7. Using the previously created alias, you can start the server with:

	fdstart

8. That's it, you can now restart the application from Ti Studio (if you want to use the simulator), deploy it on the device, or, better, build the app for device in XCode (by opening the XCode project you find in `$PRJ_DIR/build/iphone`, sign the product and install it on device. From now on your application JS files are pulled through the server you started in the `Resources` directory of your project.

9. Enjoy the time you have saved with this hack ;-)


## License
The script files are Copyright 2011 by Olivier Morandi and are distributed through the MIT license. 

The files under the `TiFiles` directory are Copyright by Appcelerator (except `ServerAddr.h` and `ServerPort.h`, which are Copyright 2011 by Olivier Morandi) and are subjected to the original Titanium Mobile Apache 2.0 Licence

## How this works
I'll soon post the details of what's under the hood of this hack  on my [Titanium Ninja](http://titaniumninja.com) blog.

## Contacts
For any enquiry, just drop me an [email](mailto:olivier.morandi@gmail.com).

You may also be interested in following me on [twitter](http://twitter.com/olivier_morandi)