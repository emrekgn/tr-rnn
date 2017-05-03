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
DATA_PATH3="$PRJ_ROOT_PATH"/data/author-3
SCRIPTS_PATH="$PRJ_ROOT_PATH"/scripts
PRJ_OWNER=$(ls -ld $PRJ_ROOT_PATH | awk '{ print $3":"$4 }')

#
# Install dependencies if necessary & create directory
#
echo "Checking dependencies..."
apt-get update && apt-get install -y --force-yes python-ebooklib
echo "Checked dependencies."
mkdir -p $DATA_PATH1
mkdir -p $DATA_PATH2
mkdir -p $DATA_PATH3

echo "Extracting plain text..."
find "$DATA_PATH1" -type f -name '*.epub' -prune -exec sh -c "python $SCRIPTS_PATH/ebook-extractor.py {} $DATA_PATH1/author.csv" \;
find "$DATA_PATH2" -type f -name '*.epub' -prune -exec sh -c "python $SCRIPTS_PATH/ebook-extractor.py {} $DATA_PATH2/author.csv" \;
find "$DATA_PATH3" -type f -name '*.epub' -prune -exec sh -c "python $SCRIPTS_PATH/ebook-extractor.py {} $DATA_PATH3/author.csv" \;
echo "Extracted plain text."

chown -R "$PRJ_OWNER" "$PRJ_ROOT_PATH"
echo "Done. Generated Turkish e-book dataset."
