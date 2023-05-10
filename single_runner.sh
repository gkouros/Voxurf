#!/usr/bin/env bash

CONFIG=$1
WORKDIR=$2
SCENE=$3

# enable conda and activate env
source ~/miniconda3/etc/profile.d/conda.sh
conda activate refnerf

# cuda stuff
export PATH="/usr/local/cuda-12/bin:/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda-12/lib64:/usr/local/cuda/lib64:$CONDA_PREFIX/lib/:$LD_LIBRARY_PATH"
export CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES/CUDA/}

# coarse training stage
echo python run.py --config ${CONFIG}/coarse.py -p ${WORKDIR} --no_reload --run_dvgo_init --sdf_mode voxurf_coarse --scene ${SCENE}
python run.py --config ${CONFIG}/coarse.py -p ${WORKDIR} --no_reload --run_dvgo_init --sdf_mode voxurf_coarse --scene ${SCENE}

# fine training stage
echo python run.py --config ${CONFIG}/fine.py --render_test -p ${WORKDIR} --no_reload --sdf_mode voxurf_fine --scene ${SCENE}
python run.py --config ${CONFIG}/fine.py --render_test -p ${WORKDIR} --no_reload --sdf_mode voxurf_fine --scene ${SCENE}

