function dedup_env --description 'Remove duplicates from an environment variable'
    set -l deduped_env
    for entry in $$argv
        if not contains -- $entry $deduped_env
            set deduped_env $deduped_env $entry
        end
    end
    set $argv $deduped_env
end
