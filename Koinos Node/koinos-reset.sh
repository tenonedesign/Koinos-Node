#! /bin/bash

HOME_DIR=${1:-~/}
KOINOS_PRODUCER_ADDRESS=${2:-''}
KOINOS_MINER_PRIVATE_KEY=${3:-''}
KOINOS_VERSION=${4:-0.4.0}

KOINOS_DIRECTORY=$HOME_DIR
KOINOS_DATA_DIRECTORY=$HOME_DIR".koinos"

rm -rf "$HOME_DIR"

exit
