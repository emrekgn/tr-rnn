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

#
# Install dependencies if necessary & create directory
#
echo "Checking dependencies..."
apt-get install -y --force-yes build-essential python
echo "Checked dependencies."

# Create a new virtual environment with python2.7 as interpreter
if [ ! -d "$PRJ_ROOT_PATH/venv" ]; then
	echo "Creating virtual environment..."
	virtualenv -p /usr/bin/python2.7 "$PRJ_ROOT_PATH"/venv
	echo "Created virtual environment."
fi

# Install requirements
if [ ! -f "$PRJ_ROOT_PATH/venv/updated" -o $SCRIPTS_PATH/requirements.txt -nt $PRJ_ROOT_PATH/venv/updated ]; then
	echo "Installing requirements..."
	pip install -r "$SCRIPTS_PATH"/requirements.txt -E $PRJ_ROOT_PATH/venv
	touch $PRJ_ROOT_PATH/venv/updated
	echo "Installed requirements."
fi
