#!/usr/bin/env bash

# set up bash to handle errors more aggressively - a "strict mode" of sorts
set -e # give an error if any command finishes with a non-zero exit code
set -u # give an error if we reference unset variables
set -o pipefail # for a pipeline, if any of the commands fail with a non-zero exit code, fail the entire pipeline with that exit code

pushd $(dirname $0) > /dev/null
PRJ_ROOT_PATH=$(dirname $(pwd -P))
popd > /dev/null
echo "Project path: $PRJ_ROOT_PATH"

OUTPUT_PATH=$PRJ_ROOT_PATH/output

echo "Setting up environment..."
#$PRJ_ROOT_PATH/scripts/setup.sh TODO
echo "Environment setup."
mkdir -p $OUTPUT_PATH

cd $PRJ_ROOT_PATH
export PYTHONPATH=.
export MODEL_OUTPUT_FILE=$OUTPUT_PATH/wiki-output.data

exec python train.py $@
