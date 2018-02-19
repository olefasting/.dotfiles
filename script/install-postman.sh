#!/bin/sh

versionMaj="1"
versionMin="0"
versionRev="1"
version="$versionMaj.$versionMin-$versionRev"

echo "Removing old Postman tarballs"
rm -f $(ls Postman*.tar.gz)

echo "Downloading latest Postman tarball"
curlExists=$(command -v curl)

if [ -z $curlExists ]; then
	wget -q --show-progress "https://dl.pstmn.io/download/latest/linux64" --content-disposition
else
	curl -# "https://dl.pstmn.io/download/latest/linux64" -O -J
fi

if [ $? -gt 0 ]; then
	echo "Failed to download Postman tarball"
	exit
fi

if [ -d "Postman" ]; then
	echo "Removing old 'Postman/'"
	rm -rf "Postman/"
fi

echo "Extracting Postman tarball"
tar -xf $(ls Postman*.tar.gz)

if [ $? -gt 0 ]; then
	echo "Failed to extract Postman tarball"
	exit
fi

versionMaj=$(ls Postman*.tar.gz | awk -F '-' '{ print $4 }' | awk -F '.' '{ print $1 }')
versionMin=$(ls Postman*.tar.gz | awk -F '-' '{ print $4 }' | awk -F '.' '{ print $2 }')
versionRev=$(ls Postman*.tar.gz | awk -F '-' '{ print $4 }' | awk -F '.' '{ print $3 }')
version="$versionMaj.$versionMin-$versionRev"

echo "Postman V$version"

if [ -d "postman_$version" ]; then
	echo "Removing old 'postman_$version/'"
	rm -rf "postman_$version/"
fi

echo "Creating 'postman_$version' folder structure and files"
mkdir -p "postman_$version"

mkdir -p "postman_$version/usr/share/applications"
touch "postman_$version/usr/share/applications/Postman.desktop"

mkdir -p "postman_$version/usr/share/icons/hicolor/128x128/apps"

mkdir -p "postman_$version/opt/postman"

mkdir -p "postman_$version/DEBIAN"
touch "postman_$version/DEBIAN/control" "postman_$version/DEBIAN/postinst" "postman_$version/DEBIAN/prerm"

echo "Copying files"
cp "Postman/resources/app/assets/icon.png" "postman_$version/usr/share/icons/hicolor/128x128/apps/postman.png"
cp -R "Postman/"* "postman_$version/opt/postman/"

echo "Writing files"
echo "[Desktop Entry]\nType=Application\nName=Postman\nGenericName=Postman API Tester\nIcon=postman\nExec=postman\nPath=/opt/postman\nCategories=Development;" > "postman_$version/usr/share/applications/Postman.desktop"
echo "Package: Postman\nVersion: $version\nSection: devel\nPriority: optional\nArchitecture: amd64\nDepends: \nMaintainer: You\nDescription: Postman\n API something" > "postman_$version/DEBIAN/control"
echo "if [ -f \"/usr/bin/postman\" ]; then\n\tsudo rm -f \"/usr/bin/postman\"\nfi\n\nsudo ln -s \"/opt/postman/Postman\" \"/usr/bin/postman\"" > "postman_$version/DEBIAN/postinst"
echo "if [ -f \"/usr/bin/postman\" ]; then\n\tsudo rm -f \"/usr/bin/postman\"\nfi" > "postman_$version/DEBIAN/prerm"

echo "Setting modes"
chmod 0775 "postman_$version/DEBIAN/postinst"
chmod 0775 "postman_$version/DEBIAN/prerm"

if [ -f "postman_$version.deb" ]; then
	echo "Removing old 'postman_$version.deb'"
	rm -f "postman_$version.deb"
fi

echo "Building 'postman_$version.deb'"
dpkg-deb -b "postman_$version" > /dev/null

if [ $? -gt 0 ]; then
	echo "Failed to build 'postman_$version.deb'"
	exit
fi

echo "Cleaning up"
rm -f $(ls Postman*.tar.gz)
rm -rf "Postman/"
rm -rf "postman_$version/"

while true; do
	read -p "Do you want to install 'postman_$version.deb'[Y/n] " yn
	
	if [ -z $yn ]; then
		yn="y"
	fi
	
	case $yn in
		[Yy]* ) break;;
		[Nn]* ) exit;;
	esac
done

echo "Installing"
sudo apt install "./postman_$version.deb"

if [ $? -gt 0 ]; then
	echo "Failed to install 'postman_$version.deb'"
	exit
fi

echo "Removing 'postman_$version.deb'"
rm -f "postman_$version.deb"