#!/bin/bash
# Run this on your Mac to make an icns file for your custom application.

function usage(){
	echo "Usage: $0 -i image_file.png [ -d destination.iconset ]"
	echo
	echo "The original image must be png type. If destination folder.iconset is not given"
	echo "a /tmp/image_file.png.iconset will be created for the generated icon files."
	echo 
	echo "Final folder.icns file will be exported to the same location as the destination"
	echo "folder. Example:"
	echo
	echo "    $0 -i ~/Pictures/image_file.png -d ~/Pictures/applet.iconset"
	echo "    ~/Pictures/image_file.png"
	echo "    ~/Pictures/applet.icns"
	echo "    ~/Pictures/applet.iconset"
	echo 
	echo "This tool is based on instructions found here:"
	echo " http://blog.macsales.com/28492-create-your-own-custom-icons-in-10-7-5-or-later"
	exit
}
while getopts "d:hi:" opt; do
  case ${opt} in
    h ) 
	usage
	# process option a
      ;;
    i ) IMG=$OPTARG; # process option l
      ;;
    d ) DEST=$OPTARG
      ;;
    \? ) 
	usage
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      ;;

  esac
done

# Make an output directory if it does not exist, or if the destination was blank.
if [ ! -d "$DEST" ]; then
	echo " ! Error: $DEST directory could not be found. Using /tmp output instead"
	DEST="/tmp/${IMG}.iconset"
	mkdir "$DEST" 
fi

echo -e "Img: $IMG\nDest: $DEST"

# Copy the file to a temp.
echo " * Copy $IMG to /tmp/tmpimg.png"
cp "$IMG" /tmp/tmpimg.png

echo " * Make tmpimg.png start as 1024 square"
#echo "sips -z 1024 1024  /tmp/tmpimg.png"
sips -z 1024 1024  /tmp/tmpimg.png

echo 
echo " * Create all the icons"
sips -Z 1024  /tmp/tmpimg.png --out "$DEST/icon_512x512@2x.png"
sips -Z 512  /tmp/tmpimg.png --out "$DEST/icon_512x512.png"
sips -Z 512  /tmp/tmpimg.png --out "$DEST/icon_256x256@2x.png"
sips -Z 256 /tmp/tmpimg.png --out "$DEST/icon_256x256.png"
sips -Z 256  /tmp/tmpimg.png --out "$DEST/icon_128x128@2x.png"
sips -Z 128  /tmp/tmpimg.png --out "$DEST/icon_128x128.png"
sips -Z 64  /tmp/tmpimg.png --out "$DEST/icon_32x32@2x.png"
sips -Z 32  /tmp/tmpimg.png --out "$DEST/icon_32x32.png"
sips -Z 32  /tmp/tmpimg.png --out "$DEST/icon_16x16@2x.png"
sips -Z 16  /tmp/tmpimg.png --out "$DEST/icon_16x16.png"

echo
echo " * Create an icns file"
echo iconutil -c icns "$DEST"
iconutil -c icns "$DEST"

# remove the temporary file
rm /tmp/tmpimg.png

echo "Done."
echo
echo "Try to select the $DEST folder and press 'space' to see if the set looks good."
echo "If the images are ok, right click the .app file, choose Get Info, then drag the"
echo "$DEST.icns file to the top right corner of the Get Info box to replace the icon." 
