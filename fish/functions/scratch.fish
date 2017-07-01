function scratch --description 'Jump to a unique scratch directory'
    set -l name $argv[1]
    set -l pattern '^[a-z0-9\\-]+$'
    if test -z $name
        set name (random)
    end

    set -l timestamp (date +%Y%m%d-%H%M%S)
    set -l tmp "$HOME/tmp/$timestamp-$name"
    mkdir -p $tmp
    pushd $tmp

    echo "Working in scratch dir: $tmp"
end
