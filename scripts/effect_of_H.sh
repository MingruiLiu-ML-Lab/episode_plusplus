#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: bash effect_of_H.sh DATASET"
    exit
fi
dataset=$1

if [ $dataset == "SNLI" ]; then
    R=5375
    eta=0.03
    gamma=0.03
elif [ $dataset == "Sentiment140" ]; then
    R=2000
    eta=0.03
    gamma=0.01
else
    echo "Unrecognized dataset '${dataset}'."
fi


N=8
S=4
I=4
algs=("local_clip" "episode_mem" "episode" "naive_parallel_clip" "scaffold_clip" "minibatch_clip")
family_base="${dataset}_I_${I}_N_${N}_S_${S}_effect_of_H"

i=0
while [ $i -lt ${#algs[@]} ]; do
    alg=${algs[$i]}
    bash run.sh ${family_base}/0_H_0.8 $alg $dataset $alg $N $S $R $I 0.8 $eta $gamma 1 0 4 0 &
    bash run.sh ${family_base}/2_H_1.0 $alg $dataset $alg $N $S $R $I 1.0 $eta $gamma 1 0 4 4 &
    wait
    i=$(($i+1))
done
