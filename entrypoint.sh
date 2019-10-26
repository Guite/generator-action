#!/bin/sh -l

MODEL_NAME=$1
MODULE_NAME=$2

echo "Create working directory"
mkdir -p work
cd work
wget https://updates.modulestudio.de/standalone/ModuleStudio-generator.jar

echo "Fetch model and regenerate it"
cp ../src/modules/$MODULE_NAME/Resources/docs/model/$MODEL_NAME ./$MODEL_NAME
java -jar ModuleStudio-generator.jar $MODEL_NAME output

echo "Remove unrequired files and copy new module into the checkout"
outputPath="output/$MODULE_NAME"
rm $outputPath/Resources/public/images/*.png
find $outputPath -type f -name '*.generated.*' -delete
cp -R $outputPath/* ../src/modules/$MODULE_NAME
cd ..
