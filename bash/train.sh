#! /bin/bash

DATASET_NAME=$1
SCENE_NAME=$2

RUNS_PATH=$(grep 'runs:' config/paths_config.cfg | sed 's/[^/]*//; s/[\{\} ,"]//g')
DATA_PATH=$(grep 'datasets:' config/paths_config.cfg | sed 's/[^/]*//; s/[\{\} ,"]//g')

echo "RUNS_PATH: $RUNS_PATH"
echo "DATA_PATH: $DATA_PATH"

# RUN_ID format: YYYY-MM-DD-HHMMSS
RUN_ID=$(date +'%Y-%m-%d-%H%M%S')
# RUN_ID="2024-06-11-123117"  # $(date +'%Y-%m-%d-%H%M%S')
OUTPUT_PATH=$RUNS_PATH/$DATASET_NAME/$SCENE_NAME/$RUN_ID
echo "OUTPUT_PATH: $OUTPUT_PATH"

python train.py -s $DATA_PATH/$DATASET_NAME/$SCENE_NAME --eval --white_background --model_path $OUTPUT_PATH --iterations 30000 --save_iterations 30000
python render.py --white_background --model_path $OUTPUT_PATH
python metrics.py --model_path $OUTPUT_PATH