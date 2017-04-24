#!/usr/bin/env bash

# set up bash to handle errors more aggressively - a "strict mode" of sorts
set -e # give an error if any command finishes with a non-zero exit code
set -u # give an error if we reference unset variables
set -o pipefail # for a pipeline, if any of the commands fail with a non-zero exit code, fail the entire pipeline with that exit code

pushd $(dirname $0) > /dev/null
PRJ_ROOT_PATH=$(dirname $(pwd -P))
popd > /dev/null
echo "Project path: $PRJ_ROOT_PATH"

#
# Common variables
#
DATA_PATH1="$PRJ_ROOT_PATH"/data/author-1
DATA_PATH2="$PRJ_ROOT_PATH"/data/author-2
SCRIPTS_PATH="$PRJ_ROOT_PATH"/scripts
PRJ_OWNER=$(ls -ld $PRJ_ROOT_PATH | awk '{ print $3 }')
PRJ_GRP=$(ls -ld $PRJ_ROOT_PATH | awk '{ print $4 }')

echo "Extracting plain text..."
find "$DATA_PATH1" -type f -name '*.epub' -prune -exec sh -c "python $SCRIPTS_PATH/ebook-extractor.py {} $DATA_PATH1/author-1.csv" \;
echo "Extracted plain text."

# Ensure that every file has the same owner
#chown -R "$PRJ_OWNER":"$PRJ_GRP" "$PRJ_ROOT_PATH"

echo "Done. Generated Turkish e-book dataset."
