#!/usr/bin/env bash


# usage: bash seda_scripts/query.sh -c "sedachain" -d seda1ytra3y3cwd54ughexz4e786hzyxdpltnwyreps -r "http://127.0.0.1:26657" -p seda14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9snnh0yy


source seda_scripts/common.sh

wasm_query '{"get_msg":{"sender":"seda1ytra3y3cwd54ughexz4e786hzyxdpltnwyreps"}}'
