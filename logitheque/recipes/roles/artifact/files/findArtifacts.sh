#! /bin/bash
# Build the list of artifacts in yaml list format

#parameter : project_home_dir
project_home_dir=$1
#parameter : artifact filetype
artifactExtension=$2
#parameter : targetFileName
targetFileName=$3

#! /bin/bash
# Build the list of artifacts in yaml list format

#parameter : project_home_dir
project_home_dir=$1
#parameter : artifact filetype
artifactExtension=$2
#parameter : targetFileName
targetFileName=$3

#init
rm -f $targetFileName

# get artifacts filenames
# find /opt/application01/ -name *.xml -fprint ~/tmp/test2
find $project_home_dir -name *.$artifactExtension -fprint ~/tmp/test2

# loop on file names
for FILENAME in `find $project_home_dir -name *.$artifactExtension -print`
do
  echo '- "'$FILENAME'"' >> $targetFileName.work
#  echo '- "'$FILENAME'"'
done

if [[ -e $targetFileName.work ]] ; then
  echo '---' > $targetFileName
  echo 'files:' >> $targetFileName
  cat $targetFileName.work >>$targetFileName
fi
rm -f $targetFileName.work
