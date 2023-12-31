while getopts ":c:d:r:p:" opt; do  
case $opt in
    c) CHAIN_ID=$OPTARG;;  
    d) DEV_ACCOUNT=$OPTARG;;  
    r) RPC_URL=$OPTARG;;  
    p) POC_CONTRACT_ADDRESS=$OPTARG;;  
    *) usage  
esac  
done  

# wasm_execute <EXECUTE_MSG> <AMOUNT>
wasm_execute() {
    echo $1
    echo "DEV_ACCOUNT" $DEV_ACCOUNT
    echo "RPC_URL" $RPC_URL
    echo "CHAIN_ID" $CHAIN_ID

    OUTPUT="$(junod tx wasm execute $POC_CONTRACT_ADDRESS $1 --from $DEV_ACCOUNT --node $RPC_URL --gas-prices 0.025ujunox --gas auto --gas-adjustment 1.3 -y --output json --chain-id $CHAIN_ID --amount "$2"ujunox)"
    echo $OUTPUT

    TXHASH=$(echo "$OUTPUT" | jq -r '.txhash')
    echo $TXHASH

    sleep 10
}




# wasm_query <QUERY_MSG>
wasm_query() {

    OUTPUT="$(junod query wasm contract-state smart $POC_CONTRACT_ADDRESS $1 --node $RPC_URL --output json --chain-id $CHAIN_ID)"
    echo $OUTPUT

    sleep 10
}





# POC_CODE_ID: 3924
# ------------------------------------------
# POC_CONTRACT_ADDRESS:  juno1eh3uz5rckq5qas3dhc45pwqf6het8dz4kgf4ykn2vwmsqadf5xlq08f2hu
