#!/bin/bash

WORKSPACE_ROOT="${GITHUB_WORKSPACE}/"
MODEL_NAME=$INPUT_MODEL_NAME
MODULE_NAME=$INPUT_MODULE_NAME
BASE_DIR=$INPUT_BASE_DIR
VERBOSE=${INPUT_VERBOSE:false}

# echo "Model: ${MODEL_NAME}"
# echo "Module: ${MODULE_NAME}"
# echo "Base dir: ${BASE_DIR}"
# echo "Verbose: ${VERBOSE}"

MODULE_PATH="${BASE_DIR}modules/${MODULE_NAME}"
OUTPUT_FOLDER="output"
OUTPUT_PATH="${WORKSPACE_ROOT}work/${OUTPUT_FOLDER}/${MODULE_NAME}"
GENERATOR_FILE="ModuleStudio-generator.jar"
GENERATOR_URL="https://updates.modulestudio.de/standalone/${GENERATOR_FILE}"

mkdir -p "work" && cd "work"
if [ "$VERBOSE" = true ]; then
    echo "Download generator"
    wget ${GENERATOR_URL}
else
    wget -q ${GENERATOR_URL}
fi

if [ "$VERBOSE" = true ]; then
    echo "Fetch model and regenerate it"
fi
cp "${WORKSPACE_ROOT}${MODULE_PATH}/Resources/docs/model/${MODEL_NAME}" "./${MODEL_NAME}"
GENERATOR="java -jar ${GENERATOR_FILE}"
if [ "$VERBOSE" = true ]; then
    ${GENERATOR} ${MODEL_NAME} ${OUTPUT_FOLDER}
else
    ${GENERATOR} ${MODEL_NAME} ${OUTPUT_FOLDER} >/dev/null
fi
echo "Test:"
ls -l ${OUTPUT_PATH}

if [ "$VERBOSE" = true ]; then
    echo "Remove unrequired files (marked with generated suffix)"
fi
#rm "${OUTPUT_PATH}/Resources/public/images/*.png"
find "${OUTPUT_PATH}" -type f -name '*.generated.*' -delete

if [ "$VERBOSE" = true ]; then
    echo "Copy generated module artifacts into the checkout"
fi
ls -l "${OUTPUT_PATH}"
cp -R "${OUTPUT_PATH}/*" "${WORKSPACE_ROOT}${MODULE_PATH}"
cd ..
rm -rf "work"
