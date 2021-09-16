if test -d '/Applications/Android Studio.app'
    set -gx JAVA_HOME '/Applications/Android Studio.app/Contents/jre/Contents/Home'
    fish_add_path --append "$HOME/Library/Android/sdk/platform-tools"
end
