function mkcd --description 'Create and navigate to a directory'
    mkdir -p $argv[1]
    and cd $argv[1]
end
