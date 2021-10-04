if command -q docker
    function dock --description 'Some handy docker aliases'
        switch $argv
            case connect
                docker start -ai (docker ps -ql)
            case stop
                docker stop (docker ps -aq)
            case clean
                docker rm -f (docker ps -aq)
            case purge
                docker rmi -f (docker images -aq)
        end
    end
end
