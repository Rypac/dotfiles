function rake
    if command -sq bundle
        bundle exec rake $argv
    else
        command rake $argv
    end
end
