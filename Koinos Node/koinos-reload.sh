#! /bin/bash

HOME_DIR=${1:-~/}
KOINOS_PRODUCER_ADDRESS=${2:-''}
KOINOS_MINER_PRIVATE_KEY=${3:-''}
KOINOS_VERSION=${4:-0.4.0}

KOINOS_DIRECTORY=$HOME_DIR
KOINOS_DATA_DIRECTORY=$HOME_DIR".koinos"

mkdir "$HOME_DIR"

cd "$KOINOS_DIRECTORY"
rm -rf "$KOINOS_DIRECTORY/koinos"
git clone https://github.com/koinos/koinos.git
cd "$KOINOS_DIRECTORY/koinos"
git checkout "v$KOINOS_VERSION"
#pwd

#rm -rf "$KOINOS_DATA_DIRECTORY"
mkdir "$KOINOS_DATA_DIRECTORY"
mkdir "$KOINOS_DATA_DIRECTORY/block_producer"
echo $KOINOS_MINER_PRIVATE_KEY > "$KOINOS_DATA_DIRECTORY/block_producer/private.key"

sed -i.'' "s/# producer:/producer: $KOINOS_PRODUCER_ADDRESS/g" "$KOINOS_DIRECTORY/koinos/config/default-config.yml"

sed -i '' "s|BASEDIR=~/.koinos|BASEDIR=$KOINOS_DATA_DIRECTORY|g" .env

sed -i '' 's/MEMPOOL_TAG=v0.4.0/MEMPOOL_TAG=v0.4.1/g' .env
sed -i '' 's/CHAIN_TAG=v0.4.0/CHAIN_TAG=v0.4.2/g' .env
sed -i '' 's/BLOCK_STORE_TAG=v0.4.0/BLOCK_STORE_TAG=v0.4.2/g' .env
sed -i '' 's/P2P_TAG=v0.4.0/P2P_TAG=v0.4.1/g' .env
sed -i '' 's/BLOCK_PRODUCER_TAG=v0.4.0/BLOCK_PRODUCER_TAG=v0.4.1/g' .env
sed -i '' 's/TRANSACTION_STORE_TAG=v0.4.0/TRANSACTION_STORE_TAG=v0.4.2/g' .env
sed -i '' 's/CONTRACT_META_STORE_TAG=v0.4.0/CONTRACT_META_STORE_TAG=v0.4.2/g' .env
sed -i '' 's/JSONRPC_TAG=v0.4.0/JSONRPC_TAG=v0.4.2/g' .env

#pwd

exit


#Steve — 03/10/2022 I'm pretty sure we were able to run it internally on M1. The koinos-config docker container doesn't work -- which means that you have to set up your ~/.koinos directory manually but it should be able to work. This is not a user friendly experience though unfortunately.
#Lim.McQuai — 01/09/2022
#And actually here is the solution (maybe you can add this to the documentation).
#For Mac with Apple M1 chip, the following is required:
#- Change line 4 in /config/Dockerfile from FROM alpine:latest to FROM --platform=linux/amd64 alpine:latest
#- Compile Dockerfile again docker build - < Dockerfile
#- Run docker compose --profile all up
