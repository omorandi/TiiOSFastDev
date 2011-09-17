#!/bin/bash          

TI_SDK_DIR="/Library/Application Support/Titanium"

function disclaimer()
{
	echo "********************************************************************************"
	echo "*                                                                              *"
	echo "*                            *** DISCLAIMER ***                                *"
	echo "*                                                                              *"
	echo "*   YOU ARE PATCHING YOUR TITANIUM MOBILE SDK DIRECTORY WITH UNTESTED,         *"
	echo "*   UNRELIABLE AND UNSUPPORTED CODE. DO THIS ONLY IF YOU KNOW WHAT YOU         *"
	echo "*   ARE DOING!!!                                                               *"
	echo "*   APPLY THIS PATCH ONLY ONTO A COPY OF YOUR 1.8.X TITANIUM SDK               *"
	echo "*   DO NOT USE THIS IN A PRODUCTION ENVIRONMENT                                *"
	echo "*                                                                              *"
	echo "********************************************************************************"
	echo
}

function usage()
{
	echo "usage: "
	echo "    $0 ti_sdk_ver [ti_sdk_dir]"
	echo
	echo "        ti_sdk_ver: the version of the Titanium SDK you want to patch"
	echo "                    currently only 1.8.X versions are supported"
	echo 
	echo "        ti_sdk_dir: (OPTIONAL) is the Titanium root directory"
	echo "                    defaults to: /Library/Application\ Support/Titanium"
	echo
	disclaimer
}


function check_dir() {
	titanium_file="${1}/titanium.py"
	
	if ! test -f "$titanium_file"
	then
		return 1
	fi
	return 0
}


function copy_file()
{
	if ! test -f $1
	then
		return 1
	fi
	
	cp $1 $2
	
}

function do_patch()
{
	path_to_sdk="${TI_SDK_DIR}mobilesdk/osx/$1"
	iphone_dir="${path_to_sdk}/iphone"
	
	if ! check_dir "$path_to_sdk"
	then
		echo "Cannot find a valid Titanium Mobile SDK at $path_to_sdk"
		echo "aborting..."
		return 1
	fi
    
    disclaimer

    echo "Do you want to proceed? (anything different from y[es] will abort)"
    read resp

    if ! echo $resp | grep -i '^yes$\|^y$' >/dev/null
    then
        echo "OK! aborting..."
        echo
        return 1
    fi
    
    echo "Patching Titanium Mobile SDK at ${path_to_sdk}..."
    cp -R ./TiFiles/ "$iphone_dir"
    echo "DONE!"
    return 0
}


if [ -z "$1" ]
then
	usage
	exit 1
fi

# set sdk dir (if provided)
if [ -n "$2" ]
then
	TI_SDK_DIR=$2
fi

# add a trailing "/" if necessary
if ! echo $TI_SDK_DIR | grep '/$' > /dev/null
then
	TI_SDK_DIR="$TI_SDK_DIR/"
fi


if ! echo $1 | grep "^1\.8\." > /dev/null  
then
	echo "ERROR: Invalid Titanium Mobile SDK version. Currently only 1.8.X is supported"
	exit 1
else
    do_patch $1
    echo
    exit $?
fi

