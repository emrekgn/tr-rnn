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
DATA_PATH="$PRJ_ROOT_PATH"/data/wiki
SCRIPTS_PATH="$PRJ_ROOT_PATH"/scripts
PRJ_OWNER=$(ls -ld $PRJ_ROOT_PATH | awk '{ print $3":"$4 }')

#
# Install dependencies if necessary & create directory
#
echo "Checking dependencies..."
apt-get update && apt-get install -y --force-yes wget
echo "Checked dependencies."
mkdir -p $DATA_PATH

echo "Downloading Turkish Wikipedia dump..."
wget -nc https://dumps.wikimedia.org/other/cirrussearch/current/trwiki-20170424-cirrussearch-content.json.gz -P "$DATA_PATH"
echo "Downloaded Turkish Wikipedia dump."

echo "Extracting plain text..."
zcat "$DATA_PATH"/*.gz | "$SCRIPTS_PATH"/cirrus-extract.py -cb 250K -o "$DATA_PATH"/extracted -
find "$DATA_PATH"/extracted -name '*bz2' -prune -exec bunzip2 -c {} \; > "$DATA_PATH"/wiki.csv
echo "Extracted plain text."

rm -rf "$DATA_PATH"/extracted
chown -R "$PRJ_OWNER" "$PRJ_ROOT_PATH"
echo "Done. Generated Turkish Wikipedia dataset."
