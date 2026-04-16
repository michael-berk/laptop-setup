#!/bin/bash
set -e
source "$(conda info --base)/etc/profile.d/conda.sh"
ENV_NAME_BASE=${1:?Usage: $0 <env_name_base> <python_version>}
PYTHON_VERSION=${2:?Usage: $0 <env_name_base> <python_version>}
ENV_NAME="${ENV_NAME_BASE}-${PYTHON_VERSION}"
conda deactivate || true
conda remove -n "$ENV_NAME" --all -y || true
conda create -n "$ENV_NAME" "python=$PYTHON_VERSION.*" pip -y
conda activate "$ENV_NAME"
