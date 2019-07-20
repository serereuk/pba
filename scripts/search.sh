#!/bin/bash
export PYTHONPATH="$(pwd)"

cifar100_search() {
    local_dir="/gdrive/My Drive/datasets/result"
    data_path="/gdrive/My Drive/datasets/datasets"

    python pba/search.py \
    --local_dir "$local_dir" \
    --model_name wrn_40_2 \
    --data_path "$data_path" --dataset cifar100 \
    --train_size 5000 --val_size 45000 \
    --checkpoint_freq 0 \
    --recompute_dset_stats \
    --name "cifar10_search" --gpu 0.5 --cpu 2 \
    --num_samples 16 --perturbation_interval 3 --epochs 200 \
    --explore cifar10 --aug_policy cifar10 \
    --lr 0.1 --wd 0.0005
}

svhn_search() {
    local_dir="$PWD/results/"
    data_path="$PWD/datasets/"

    python pba/search.py \
    --local_dir "$local_dir" --data_path "$data_path" \
    --model_name wrn_40_2 --dataset svhn \
    --train_size 1000 --val_size 7325 \
    --checkpoint_freq 0 \
    --name "svhn_search" --gpu 0.19 --cpu 2 \
    --num_samples 16 --perturbation_interval 3 --epochs 160 \
    --explore cifar10 --aug_policy cifar10 --no_cutout \
    --lr 0.1 --wd 0.005
}

if [ "$1" = "rcifar100" ]; then
    cifar100_search
elif [ "$1" = "rsvhn" ]; then
    svhn_search
else
    echo "invalid args"
fi
