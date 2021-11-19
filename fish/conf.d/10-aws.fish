# AWS CLI: unified tool to manage AWS services
# https://aws.amazon.com/cli/
if command -q aws
    set -gx AWS_CONFIG_FILE "$XDG_CONFIG_HOME/aws/config"
    set -gx AWS_SHARED_CREDENTIALS_FILE "$XDG_CONFIG_HOME/aws/credentials"
end
