#!/usr/bin/env bash

# usage: bash seda_scripts/execute_send.sh -c "sedachain" -d seda1ytra3y3cwd54ughexz4e786hzyxdpltnwyreps -r "http://127.0.0.1:26657" -p seda14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9snnh0yy


source seda_scripts/common.sh

wasm_execute '{"send_msg":{"msg":"hello_from_seda"}}' 0
