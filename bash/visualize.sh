#! /bin/bash

DATASET_NAME=$1
SCENE_NAME=$2

RUNS_PATH=$(grep 'runs:' config/paths_config.cfg | sed 's/[^/]*//; s/[\{\} ,"]//g')
EXP_NAME="base"

OUTPUT_PATH=$RUNS_PATH/3dgs/$EXP_NAME/$SCENE_NAME
# echo $OUTPUT_PATH

if [ ! -d "$OUTPUT_PATH" ]; then
    echo "Directory $OUTPUT_PATH does not exist. Exiting..."
    exit 1
fi

# find all folders in OUTPUT_PATH and sort them by name
FOLDERS_IN_OUTPUT_PATH=$(find $OUTPUT_PATH -maxdepth 1 -mindepth 1 -type d | sort)
# get the last folder name
MODEL_PATH=$(echo "$FOLDERS_IN_OUTPUT_PATH" | tail -n 1)

./SIBR_viewers/install/bin/SIBR_gaussianViewer_app -m $MODEL_PATH --vsync 0 # --load_images