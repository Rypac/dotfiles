complete --command dock --exclusive --condition __fish_use_subcommand --arguments connect --description "Start and connect to container"
complete --command dock --exclusive --condition __fish_use_subcommand --arguments stop --description "Stop running container"
complete --command dock --exclusive --condition __fish_use_subcommand --arguments clean --description "Remove unattached containers"
complete --command dock --exclusive --condition __fish_use_subcommand --arguments purge --description "Remove container images"
