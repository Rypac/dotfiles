function weather --description 'Retrieve a weather forcast for the specified location'
    set -l location $argv
    if test -z $location
        set location Melbourne
    end

    set -l url "wttr.in/$location"

    if command -sq curl
        command curl "$url"
    else if command -sq wget
        command wget -qO- "$url"
    else
        return 1
    end
end
