#!/bin/sh -l

MODEL_NAME=$1
MODULE_NAME=$2
BASE_DIR=$3
VERBOSE=$4

WGET="wget -q"
if [ $VERBOSE == true ]; then
    WGET="wget"
fi
MODULE_PATH="${BASE_DIR}modules/${MODULE_NAME}"
OUTPUT_PATH="output/${MODULE_NAME}"

if [ $VERBOSE == true ]; then
    echo "Create working directory"
fi
mkdir -p "work" && cd "work"
if [ $VERBOSE == true ]; then
    echo "Download generator"
fi
$WGET "https://updates.modulestudio.de/standalone/ModuleStudio-generator.jar"

if [ $VERBOSE == true ]; then
    echo "Fetch model and regenerate it"
fi
cp "../${MODULE_PATH}/Resources/docs/model/${MODEL_NAME}" "./${MODEL_NAME}"
java -jar ModuleStudio-generator.jar ${MODEL_NAME} "output"

if [ $VERBOSE == true ]; then
    echo "Remove unrequired files (marked with generated suffix)"
fi
#rm "${OUTPUT_PATH}/Resources/public/images/*.png"
find "${OUTPUT_PATH}" -type f -name '*.generated.*' -delete

if [ $VERBOSE == true ]; then
    echo "Copy generated module artifacts into the checkout"
fi
cp -R "${OUTPUT_PATH}/*" "../${MODULE_PATH}"
cd ..
