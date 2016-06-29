# EmobaImagesIOSToAndroid
Copies and renames files from a given Images.xcassets directory from XCode to an Android Directory with drawable, drawable-hdpi, and drawable-xhdpi directories.


Instructions:

Run script in the following format:

### If you want to provide your own source and destination directories
./CopyImagesIOSToAndroid "source directory" "destination directory"

### If you don't want to use the parameters follow these steps
1. Paste the contents of your Images.xcassets directory from XCode into the Images.xcassets directory in this repository
2. Ensure the Android Directory exists at the root level of this repository
3. Run Script via

./CopyImagesIOSToAndroid
