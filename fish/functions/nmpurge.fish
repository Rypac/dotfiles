function nmpurge --description 'Recursively delete all node_modules folders' --argument target
    if test -z "$target"
        echo "Specify a directory to clean"
        return 1
    end

    command find "$target" -name node_modules -type d -prune -exec rm -rf '{}' +
end
