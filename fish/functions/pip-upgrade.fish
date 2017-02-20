function pip-upgrade --description 'Update all installed pip packages'
    pip3 list --outdated --format=legacy $argv | cut -d ' ' -f 1 | xargs -n 1 pip3 install --upgrade $argv
end
