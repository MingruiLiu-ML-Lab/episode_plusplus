#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: bash effect_of_S.sh DATASET"
    exit
fi
dataset=$1

if [ $dataset == "SNLI" ]; then
    R=5375
    eta=0.03
    gamma=0.03
    H=0.7
elif [ $dataset == "Sentiment140" ]; then
    R=2000
    eta=0.03
    gamma=0.01
    H=0.9
else
    echo "Unrecognized dataset '${dataset}'."
fi

N=8
I=4
algs=("local_clip" "minibatch_clip" "episode_mem" "scaffold_clip" "naive_parallel_clip" "episode")
family_base="${dataset}_I_${I}_H_${H}_N_${N}_effect_of_S"

i=0
while [ $i -lt ${#algs[@]} ]; do
    alg=${algs[$i]}
    bash run.sh ${family_base}/0_S_2 $alg $dataset $alg $N 2 $R $I $H $eta $gamma 1 0 2 0 &
    bash run.sh ${family_base}/2_S_6 $alg $dataset $alg $N 6 $R $I $H $eta $gamma 1 0 6 2 &
    wait
    bash run.sh ${family_base}/3_S_8 $alg $dataset $alg $N 8 $R $I $H $eta $gamma 1 0 8 0
    i=$(($i+1))
done

i=0
while [ $i -lt ${#algs[@]} ]; do
    alg=${algs[$i]}
    bash run.sh ${family_base}/1_S_4 $alg $dataset $alg $N 4 $R $I $H $eta $gamma 1 0 4 0 &
    i=$(($i+1))
    alg=${algs[$i]}
    bash run.sh ${family_base}/1_S_4 $alg $dataset $alg $N 4 $R $I $H $eta $gamma 1 0 4 4 &
    i=$(($i+1))
    wait
done
