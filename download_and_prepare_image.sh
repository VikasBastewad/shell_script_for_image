#!/bin/bash

# Check if a download link is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <download_link>"
  exit 1
fi

LINK=$1

# Download the file using axel
echo "Downloading image from $LINK..."
axel -n 100 "$LINK" -o image.tar.gz

# Check if axel command was successful
if [ $? -ne 0 ]; then
  echo "Error: Download failed."
  exit 1
fi

echo "Download successful: image.tar.gz"

# Create updateImage directory
echo "Creating directory updateImage..."
mkdir updateImage

# Check if mkdir command was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to create directory updateImage. It may already exist."
  exit 1
fi

# Extract the image
echo "Extracting image.tar.gz to updateImage..."
tar -xzf image.tar.gz -C updateImage

# Check if tar command was successful
if [ $? -ne 0 ]; then
  echo "Error: Extraction failed."
  exit 1
fi

echo "Extraction successful."

# Change directory to updateImage
echo "Changing directory to updateImage..."
cd updateImage

# Check if cd command was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to change directory to updateImage."
  exit 1
fi

# Delete dtb.bin
echo "Deleting dtb.bin..."
rm dtb.bin
if [ $? -ne 0 ]; then
  echo "Error: Failed to delete dtb.bin."
  # It might not be critical, so we can choose to continue or exit
  # For now, let's exit to be safe
  cd .. # Attempt to go back before exiting
  exit 1
fi

# Rename do_not_use.img to data.img
echo "Renaming do_not_use.img to data.img..."
mv do_not_use.img data.img
if [ $? -ne 0 ]; then
  echo "Error: Failed to rename do_not_use.img to data.img."
  cd .. # Attempt to go back before exiting
  exit 1
fi

# Rename dtb_RW.bin to dtb.bin
echo "Renaming dtb_RW.bin to dtb.bin..."
mv dtb_RW.bin dtb.bin
if [ $? -ne 0 ]; then
  echo "Error: Failed to rename dtb_RW.bin to dtb.bin."
  cd .. # Attempt to go back before exiting
  exit 1
fi

echo "File operations successful."

# Change back to the original directory
echo "Changing back to the original directory..."
cd ..
if [ $? -ne 0 ]; then
  echo "Error: Failed to change back to the original directory."
  exit 1
fi

# Remove the downloaded archive
echo "Removing image.tar.gz..."
rm image.tar.gz

# Check if rm command was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to remove image.tar.gz."
  exit 1
fi

echo "Cleanup successful."
exit 0
