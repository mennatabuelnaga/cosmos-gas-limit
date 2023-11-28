#!/usr/bin/env bash

# usage: bash terra_scripts/deploy.sh -c "pisco-1" -d "terra1cxzwsl2yh3nsglrt0sur2uhzh0mruvjy3d42nq" -r "https://pisco-lcd.terra.dev:1317"

source terra_scripts/common.sh

TX_FLAGS="--from $DEV_ACCOUNT --node $RPC_URL --gas-prices 0.1uluna --gas auto --gas-adjustment 1.6 -y --output json --chain-id $CHAIN_ID"
# store_contract CONTRACT_NAME
store_contract(){
    echo $1
    echo "DEV_ACCOUNT" $DEV_ACCOUNT
    echo "RPC_URL" $RPC_URL
    echo "CHAIN_ID" $CHAIN_ID

    OUTPUT="$(terrad tx wasm store "./artifacts/$1.wasm" $TX_FLAGS)"
    echo $OUTPUT

    TXHASH=$(echo $OUTPUT | jq -r '.txhash')
    echo $TXHASH

    sleep 10

    OUTPUT=$(terrad query tx $TXHASH --node $RPC_URL --output json)
    echo $OUTPUT

    CODE_ID=$(echo "$OUTPUT" | jq -r '.logs[].events[] | select(.type=="store_code") | .attributes[] | select(.key=="code_id") | .value')
  
}

# instantiate_contract CODE_ID INSTANTIATE_MSG LABEL
instantiate_contract() {
    echo $1
    echo $2

    echo "DEV_ACCOUNT" $DEV_ACCOUNT
    echo "RPC_URL" $RPC_URL
    echo "CHAIN_ID" $CHAIN_ID

    OUTPUT=$(terrad tx wasm instantiate $1 $2 --no-admin --label "$3$1" $TX_FLAGS)
    echo $OUTPUT

    TXHASH=$(echo "$OUTPUT" | jq -r '.txhash')

    sleep 10


    OUTPUT="$(terrad query tx $TXHASH --node $RPC_URL --output json)"
    echo $OUTPUT

    CONTRACT_ADDRESS=$(echo "$OUTPUT" | jq -r '.logs[].events[] | select(.type=="instantiate") | .attributes[] | select(.key=="_contract_address") | .value')


}


# Upload PoC contract
store_contract "infinite_loop"
POC_CODE_ID=$CODE_ID

# Instantiate PoC
LABEL=infinite_loop_poc
INSTANTIATE_MSG='{}'
instantiate_contract $POC_CODE_ID $INSTANTIATE_MSG $LABEL
POC_CONTRACT_ADDRESS=$CONTRACT_ADDRESS



echo "------------------------------------------"
echo "POC_CODE_ID:" $POC_CODE_ID
echo "------------------------------------------"
echo "POC_CONTRACT_ADDRESS: " $POC_CONTRACT_ADDRESS
echo "------------------------------------------"



# ------------------------------------------
# POC_CODE_ID: 12108
# ------------------------------------------
# POC_CONTRACT_ADDRESS:  terra1xauftfyhlvxdvpxd9pt3ulms9p605q8rj0yuv6p7hmr5qfgyrgeszk2gm7
# ------------------------------------------
