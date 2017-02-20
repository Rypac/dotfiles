function code --description 'Lauch Visual Studio Code with XDG friendly directories'
    switch (uname)
        case Linux
            command code --user-data-dir "$XDG_CONFIG_HOME/vscode" --extensions-dir "$XDG_CONFIG_HOME/vscode/extensions" $argv
        case '*'
            command code $argv
    end
end
