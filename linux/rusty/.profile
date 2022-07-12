if [[ -e ~/.bashrc ]];then
    source ~/.bashrc
fi

alias flubber='ssh flubber-smw'
alias mars='ssh mars-smw'
alias moon='ssh moon-smw'
alias opal='ssh opal-smw'
alias percival='ssh percival-smw'
alias saturn='ssh saturn-smw'

function lsi {
    IMAGE=$1
    if [[ -z "$IMAGE" ]];then
        echo "Give an image name as an arg!"
        return 1
    fi
    echo "Getting tag list for $IMAGE"
    GET="$(curl -X GET http://bit21/v2/$IMAGE/tags/list)"
    if [[ "$?" != '0' ]];then
        echo "Failed to get image tags for $IMAGE."
        return 1
    else
        echo "$GET" | python -m json.tool
    fi
    return 0
}
alias lsreg='curl -X GET http://bit21/v2/_catalog | python -m json.tool'

if [[ -e "$HOME/.pyenv/shims" ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi
export PATH="/usr/local/sbin:$PATH"
