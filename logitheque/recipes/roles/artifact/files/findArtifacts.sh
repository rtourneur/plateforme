#! /bin/bash
# Build the list of artifacts in yaml list format

#parameter : project_home_dir - the directory of the project, where we search artifacts
project_home_dir=$1
#parameter : artifact filetype - the file type extension that let us know a file is an artifact
artifactExtension=$2
#parameter : targetFileName - the file where to output the results, in Yaml format
targetFileName=$3

#init : reset output
rm -f $targetFileName

# get artifacts filenames, loop on
# TODO filter on target directories only
for FILENAME in `find $project_home_dir -name *.$artifactExtension -print`
do
  echo '- "'$FILENAME'"' >> $targetFileName.work
done

# layout result in Yaml format (a list in a 'files' node)
if [[ -e $targetFileName.work ]] ; then
  echo '---' > $targetFileName
  echo 'files:' >> $targetFileName
  cat $targetFileName.work >>$targetFileName
fi

#cleanup
rm -f $targetFileName.work
