#!/bin/bash

# Analyse Epubs in build directory with epubcheck (both version 3 & 4)

# Location of epubcheck jars (update according to your own system)
epubcheck3Jar=/usr/share/java/epubcheck.jar
epubcheck4Jar=/home/johan/epubcheck/epubcheck.jar

# ---- No need to edit anything below this line, unless you know what you're doing!

# Installation directory
instDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Build directory - where newly created epubs are stored
buildDir="$instDir"/build/

# Epubcheck output directory - epubcheck output goes here
eCOutDir="$instDir"/epubcheckout/

# Subdirs for epubcheck versions
ec3OutDir="$eCOutDir"3.0.1/
ec4OutDir="$eCOutDir"4.0.1/

# Create output directory structure if it doesn't exist already

if ! [ -d $eCOutDir ] ; then
    mkdir $eCOutDir
fi

if ! [ -d $ec3OutDir ] ; then
    mkdir $ec3OutDir
fi

if ! [ -d $ec4OutDir ] ; then
    mkdir $ec4OutDir
fi

# **************
# MAIN PROCESSING LOOP
# **************

counter=0

while IFS= read -d $'\0' epub ; do
    # Base name (strip away path)
    epubFileName=$(basename "$epub")
    epubBaseName="${epubFileName%.*}"
    
    # Generate epubcheck output file names
    ec3OutName="$ec3OutDir"$"$epubBaseName".xml
    ec4OutName="$ec4OutDir"$"$epubBaseName".xml

    # Run Epubcheck
    java -jar $epubcheck3Jar "$epub" -out "$ec3OutName" # 2>tmpec3.stderr
    java -jar $epubcheck4Jar "$epub" -out "$ec4OutName" # 2>tmpec3.stderr
          
done < <(find "$buildDir" -maxdepth 1 -mindepth 1 -print0 -type f)

