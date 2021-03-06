source UtilScripts/PrintUtils

# source dir where IOS drawbles exist
if [ -z "$1" ]
then
  sourceDir="/Users/envative/git/EmobaImagesIOSToAndroid/Images.xcassets"
  echo $sourceDir
else
  sourceDir="$1"
fi


# destination dir to create the drawable folders in
if [ -z "$2" ]
then
  destinationDir="/Users/envative/git/EmobaImagesIOSToAndroid/Android"
  echo $destinationDir
else
  destinationDir="$2"
fi


#create destination dir if not exists
[ -d "$destinationDir" ] || mkdir $destinationDir

cd "$destinationDir"

# create drawable directories if they dont exist already
if [ -d "drawable" ]
then
  print_info "Destination (drawable, drawable-hdpi, drawable-xhdpi) directories exists"
else
  print_info "Destination (drawable, drawable-hdpi, drawable-xhdpi) directories do not exist"
  print_info "Creating Directories (drawable, drawable-hdpi, drawable-xhdpi)"
  mkdir drawable
  mkdir drawable-hdpi
  mkdir drawable-xhdpi
fi

#navigation to Source Dir
cd "$sourceDir"

# loop through all image directories
for imageDir in *.imageset/ ; do
 echo ""
 print_info "Copying files from $imageDir"
 cd $imageDir

 # loop through all files
 for imageFile in *; do

  if  echo "$imageFile" | grep -q "Contents"
  then
    print_skipped "ignore: $imageFile"
  else
    # copy files drawable folders
    # rename file to lowercase letters with underscore between caps
    case "$imageFile" in
      *@3x*)
        newImageFilename="$(echo $imageFile | sed "s/@3x//")"
        newImageFilename="$(echo $newImageFilename | sed 's/[A-Z]/_&/g;s/^_//')"
        newImageFilename="$(echo $newImageFilename | sed 's/__/_/g')"
        newImageFilename="$(echo $newImageFilename | tr '[A-Z]' '[a-z]')"
        outputPath="$destinationDir/drawable-xhdpi/$newImageFilename"
        print_completed "Copied: $outputPath"
        cp -rf $imageFile $outputPath
      ;;
      *@2x*)
        newImageFilename="$(echo $imageFile | sed "s/@2x//")"
        newImageFilename="$(echo $newImageFilename | sed 's/[A-Z]/_&/g;s/^_//')"
        newImageFilename="$(echo $newImageFilename | sed 's/__/_/g')"
        newImageFilename="$(echo $newImageFilename | tr '[A-Z]' '[a-z]')"
        outputPath="$destinationDir/drawable-hdpi/$newImageFilename"
        print_completed "Copied: $outputPath"
        cp -rf $imageFile $outputPath
      ;;
      *)
        newImageFilename="$(echo $imageFile | sed 's/[A-Z]/_&/g;s/^_//')"
        newImageFilename="$(echo $newImageFilename | sed 's/__/_/g')"
        newImageFilename="$(echo $newImageFilename | tr '[A-Z]' '[a-z]')"
        outputPath="$destinationDir/drawable/$newImageFilename"
        print_completed "Copied: $outputPath"
        cp -rf $imageFile $outputPath
      ;;
    esac
  fi
 done

 cd ..
done
