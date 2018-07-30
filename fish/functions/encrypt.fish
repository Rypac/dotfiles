function encrypt --description 'Encrypt a file to myself using GPG'
    command gpg --encrypt --recipient ryan@rypac.org --armour --output - $argv
end
