# For OS X to source .bashrc
if [[ -e ~/.bashrc ]];then
    source ~/.bashrc
fi

function dcheck {
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
alias dreg='curl -X GET http://bit21/v2/_catalog | python -m json.tool'

export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/sbin:/sbin:
