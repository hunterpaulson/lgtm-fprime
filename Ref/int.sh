#!/bin/bash
export SCRIPT_DIR="$(dirname ${BASH_SOURCE})"
export SLEEP_TIME="10"
echo "[INFO] Starting headless GDS layer"
fprime-gds -d "${SCRIPT_DIR}" -g none &
GDS_PID=$!
echo "[INFO] Allowing GDS ${SLEEP_TIME} seconds to start"
sleep ${SLEEP_TIME}
# Check the above started successfully
ps -p ${GDS_PID} 2> /dev/null 1> /dev/null || exit 2
# Run integration tests
(
    cd "${SCRIPT_DIR}/test"
    echo "[INFO] Running Ref/test's pytest integration tests" 
    pytest 
)
RET_PYTEST=$?
pkill -P $GDS_PID
kill $GDS_PID
sleep 2
pkill -KILL Ref
exit ${RET_PYTEST}
