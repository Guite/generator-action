#!/bin/bash

WORKSPACE_ROOT="${GITHUB_WORKSPACE}/"
MODEL_NAME=$1
MODULE_NAME=$2
BASE_DIR=$3
VERBOSE=${4:-false}

# echo "Model: ${MODEL_NAME}"
# echo "Module: ${MODULE_NAME}"
# echo "Base dir: ${BASE_DIR}"
# echo "Verbose: ${VERBOSE}"

MODULE_PATH="${WORKSPACE_ROOT}${BASE_DIR}extensions/${MODULE_NAME}"
if [ ! -d "$MODULE_PATH" ]; then
    MODULE_PATH="${WORKSPACE_ROOT}${BASE_DIR}modules/${MODULE_NAME}"
fi
WORK_FOLDER="work"
OUTPUT_FOLDER="output"
OUTPUT_PATH="${WORKSPACE_ROOT}${WORK_FOLDER}/${OUTPUT_FOLDER}/${MODULE_NAME}"
GENERATOR_FILE="ModuleStudio-generator.jar"
GENERATOR_URL="https://github.com/Guite/MostGenerator/releases/download/standalone/${GENERATOR_FILE}"

mkdir -p ${WORK_FOLDER} && cd ${WORK_FOLDER}
if [ "$VERBOSE" = true ]; then
    echo "Download generator"
    wget ${GENERATOR_URL}
else
    wget -q ${GENERATOR_URL}
fi

if [ "$VERBOSE" = true ]; then
    echo "Fetch model and regenerate it"
fi
cp "${MODULE_PATH}/Resources/docs/model/${MODEL_NAME}" "./${MODEL_NAME}"
GENERATOR="java -jar ${GENERATOR_FILE}"
if [ "$VERBOSE" = true ]; then
    ${GENERATOR} ${MODEL_NAME} ${OUTPUT_FOLDER}
else
    ${GENERATOR} ${MODEL_NAME} ${OUTPUT_FOLDER} >/dev/null
fi

if [ "$VERBOSE" = true ]; then
    echo "Remove unrequired files (marked with generated suffix)"
fi
find "${OUTPUT_PATH}" -type f -name '*.generated.*' -delete

if [ "$VERBOSE" = true ]; then
    echo "Copy generated module artifacts into the checkout"
fi
cp -R "${OUTPUT_PATH}/"* "${MODULE_PATH}"
cd ${WORKSPACE_ROOT}
rm -rf ${WORK_FOLDER}
