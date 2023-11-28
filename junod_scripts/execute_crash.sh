#!/usr/bin/env bash

# usage: bash junod_scripts/execute_crash.sh -c "uni-6" -d juno1e32g7uv8pw7jrxdhtz7adxfws0vw6u9gzyfmua -r "https://uni-rpc.reece.sh:443" -p juno1eh3uz5rckq5qas3dhc45pwqf6het8dz4kgf4ykn2vwmsqadf5xlq08f2hu


source junod_scripts/common.sh

wasm_execute '{"crash":{}}' 0
