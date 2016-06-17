# mac-create-icns-script

Usage: create_iconset.sh -i image_file.png [ -d destination.iconset ]

The original image must be png type. If destination folder.iconset is not given
a /tmp/image_file.png.iconset will be created for the generated icon files.

Final folder.icns file will be exported to the same location as the destination
folder. Example:

    create_iconset.sh -i ~/Pictures/image_file.png -d ~/Pictures/applet.iconset
    ~/Pictures/image_file.png
    ~/Pictures/applet.icns
    ~/Pictures/applet.iconset

This tool is based on instructions found here:
 http://blog.macsales.com/28492-create-your-own-custom-icons-in-10-7-5-or-later

