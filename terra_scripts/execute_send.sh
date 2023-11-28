#!/usr/bin/env bash

# usage: bash terra_scripts/execute_send.sh -c "pisco-1" -d terra1cxzwsl2yh3nsglrt0sur2uhzh0mruvjy3d42nq -r "https://pisco-rpc.terra.dev:443" -p terra1xauftfyhlvxdvpxd9pt3ulms9p605q8rj0yuv6p7hmr5qfgyrgeszk2gm7


source terra_scripts/common.sh

wasm_execute '{"send_msg":{"msg":"hello_from_seda_to_terra"}}' 0
