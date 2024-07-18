#!/bin/bash

# Get arguments
increment=$1
chart_file=$2

# Get current version
current_version=$(grep 'version:' $chart_file | awk '{print $2}' | tr -d \'\")

# Get major, minor, patch
major=$(echo $current_version | cut -d. -f1)
minor=$(echo $current_version | cut -d. -f2)
patch=$(echo $current_version | cut -d. -f3)

# Increment version part 
case $increment in
  major)
    major=$((major+1))
    minor=0
    patch=0
    ;;
  minor)
    minor=$((minor+1))
    patch=0
    ;;
  patch|*)
    patch=$((patch+1))
    ;;
esac

# Construct new version
new_version="$major.$minor.$patch"

# Replace version in chart file
sed -i "s/version: '$current_version'/version: '$new_version'/g" $chart_file

echo "Updated version in $chart_file to $new_version"