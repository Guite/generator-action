#!/bin/bash

MODEL_NAME=$INPUT_MODEL_NAME
MODULE_NAME=$INPUT_MODULE_NAME
BASE_DIR=$INPUT_BASE_DIR
VERBOSE=${INPUT_VERBOSE:false}

# echo "Model: ${MODEL_NAME}"
# echo "Module: ${MODULE_NAME}"
# echo "Base dir: ${BASE_DIR}"
# echo "Verbose: ${VERBOSE}"

WGET="wget -q"
if [ "$VERBOSE" = true ]; then
    WGET="wget"
fi
GENERATOR_FILE="https://updates.modulestudio.de/standalone/ModuleStudio-generator.jar"

MODULE_PATH="${BASE_DIR}modules/${MODULE_NAME}"
OUTPUT_PATH="output/${MODULE_NAME}"

if [ "$VERBOSE" = true ]; then
    echo "Create working directory"
fi
mkdir -p "work" && cd "work"
if [ "$VERBOSE" = true ]; then
    echo "Download generator"
fi
${WGET} ${GENERATOR_FILE}

if [ "$VERBOSE" = true ]; then
    echo "Fetch model and regenerate it"
fi
cp "../${MODULE_PATH}/Resources/docs/model/${MODEL_NAME}" "./${MODEL_NAME}"
GENERATOR="java -jar ModuleStudio-generator.jar"
if [ "$VERBOSE" = true ]; then
    ${GENERATOR} ${MODEL_NAME} "output"
else
    ${GENERATOR} ${MODEL_NAME} "output" >/dev/null
fi

if [ "$VERBOSE" = true ]; then
    echo "Remove unrequired files (marked with generated suffix)"
fi
#rm "${OUTPUT_PATH}/Resources/public/images/*.png"
find "${OUTPUT_PATH}" -type f -name '*.generated.*' -delete

if [ "$VERBOSE" = true ]; then
    echo "Copy generated module artifacts into the checkout"
    echo "Call: cp -R ${OUTPUT_PATH}/* ../${MODULE_PATH}"
fi
cp -R "${OUTPUT_PATH}/*" "../${MODULE_PATH}"
cd ..
rm -rf "work"
