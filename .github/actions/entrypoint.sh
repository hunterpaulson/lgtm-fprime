#!/bin/sh

# Exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT

cd "$GITHUB_WORKSPACE"
"$GITHUB_WORKSPACE/mk/ci/master.bash" QUICK
"$GITHUB_WORKSPACE/mk/ci/master.bash" STATIC
