#!/bin/bash
#SBATCH --job-name=mb25c-enis
#SBATCH --output=mb25c-enis.out
#SBATCH --gres=gpu:1
set -e
source /data/models/datasets.sh

DATASETS="eso bible ees emea2016 os2018 tatoeba wmt-2021-dev flores-dev"
OUT_DIR="evaluation_out/mb25c-enis"
SOURCE_LANG="en"
mkdir -p $OUT_DIR

translate_all_dev () {
    for d in $DATASETS; do
        FULL_PATH=$(get_dataset $d dev $SOURCE_LANG)
        translate $FULL_PATH $OUT_DIR $d
        # This creates
        # $OUT_DIR/$d.translation.${REF_LANG}-${SYS_LANG} 
    done
}
source /data/models/mbart25-cont-enis/scripts/generate.sh
translate_all_dev
