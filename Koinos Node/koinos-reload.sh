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

if [ "$KOINOS_VERSION" = "latest" ]
then echo "cloning koinos repo at latest"; git checkout "master";
else echo "using koinos version $KOINOS_VERSION"; git checkout "v$KOINOS_VERSION"
fi

# remove existing koinos-related images
docker rmi $(docker images | grep 'koinos\|rabbitmq')

mkdir "$KOINOS_DATA_DIRECTORY"
mkdir "$KOINOS_DATA_DIRECTORY/block_producer"
echo $KOINOS_MINER_PRIVATE_KEY > "$KOINOS_DATA_DIRECTORY/block_producer/private.key"

# if the sed .bak strategy seems strange, it to accommodate both macOS and linux sed (https://stackoverflow.com/a/22084103)
sed -i.bak "s/# producer:/producer: $KOINOS_PRODUCER_ADDRESS/g" "$KOINOS_DIRECTORY/koinos/config/default-config.yml"
rm "$KOINOS_DIRECTORY/koinos/config/default-config.yml.bak"

# update entire producer line in existing config.yml in case this is someone else’s config.yml
sed -i.bak "s/  producer:.*/  producer: $KOINOS_PRODUCER_ADDRESS/" "$KOINOS_DIRECTORY/.koinos/config.yml"
rm "$KOINOS_DIRECTORY/.koinos/config.yml.bak"

sed -i.bak "s|BASEDIR=~/.koinos|BASEDIR=$KOINOS_DATA_DIRECTORY|g" "$KOINOS_DIRECTORY/koinos/.env"
rm "$KOINOS_DIRECTORY/koinos/.env.bak"


# Can use this strategy for between-release updates on particular images
# This one updates the v0.4.0 release to use newer images
sed -i.bak 's/MEMPOOL_TAG=v0.4.0/MEMPOOL_TAG=v0.4.1/g' "$KOINOS_DIRECTORY/koinos/.env"
sed -i.bak 's/CHAIN_TAG=v0.4.0/CHAIN_TAG=v0.4.2/g' "$KOINOS_DIRECTORY/koinos/.env"
sed -i.bak 's/BLOCK_STORE_TAG=v0.4.0/BLOCK_STORE_TAG=v0.4.2/g' "$KOINOS_DIRECTORY/koinos/.env"
sed -i.bak 's/P2P_TAG=v0.4.0/P2P_TAG=v0.4.1/g' "$KOINOS_DIRECTORY/koinos/.env"
sed -i.bak 's/BLOCK_PRODUCER_TAG=v0.4.0/BLOCK_PRODUCER_TAG=v0.4.1/g' "$KOINOS_DIRECTORY/koinos/.env"
sed -i.bak 's/TRANSACTION_STORE_TAG=v0.4.0/TRANSACTION_STORE_TAG=v0.4.2/g' "$KOINOS_DIRECTORY/koinos/.env"
sed -i.bak 's/CONTRACT_META_STORE_TAG=v0.4.0/CONTRACT_META_STORE_TAG=v0.4.2/g' "$KOINOS_DIRECTORY/koinos/.env"
sed -i.bak 's/JSONRPC_TAG=v0.4.0/JSONRPC_TAG=v0.4.2/g' "$KOINOS_DIRECTORY/koinos/.env"

# This one updates the v04.1 release to use newer images
sed -i.bak 's/MEMPOOL_TAG=v0.4.1//g' "$KOINOS_DIRECTORY/koinos/.env"
sed -i.bak 's/MEMPOOL_TAG=v0.4.1//g' "$KOINOS_DIRECTORY/koinos/.env"
sed -i.bak 's/CHAIN_TAG=v0.4.2/CHAIN_TAG=v0.4.3/g' "$KOINOS_DIRECTORY/koinos/.env"
sed -i.bak 's/BLOCK_STORE_TAG=v0.4.2//g' "$KOINOS_DIRECTORY/koinos/.env"
sed -i.bak 's/P2P_TAG=v0.4.2//g' "$KOINOS_DIRECTORY/koinos/.env"
sed -i.bak 's/BLOCK_PRODUCER_TAG=v0.4.2//g' "$KOINOS_DIRECTORY/koinos/.env"
sed -i.bak 's/TRANSACTION_STORE_TAG=v0.4.3//g' "$KOINOS_DIRECTORY/koinos/.env"
sed -i.bak 's/CONTRACT_META_STORE_TAG=v0.4.3//g' "$KOINOS_DIRECTORY/koinos/.env"
sed -i.bak 's/JSONRPC_TAG=v0.4.2//g' "$KOINOS_DIRECTORY/koinos/.env"

rm "$KOINOS_DIRECTORY/koinos/.env.bak"

# Support for Apple Silicon
cd "$KOINOS_DIRECTORY/koinos/config"
sed -i '' 's|FROM alpine:latest|FROM --platform=linux/amd64 alpine:latest|g' Dockerfile
docker build - < Dockerfile

exit
