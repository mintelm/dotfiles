# requires https://github.com/romkatv/gitstatus

setopt PROMPT_SUBST
function set_prompt() {
    TOKEN="{}"
    PROMPT="%(?:%{$fg_bold[green]%}$TOKEN :%{$fg_bold[red]%}$TOKEN )"
    PROMPT+="%{$fg[cyan]%}%c"

    if gitstatus_query MY && [[ $VCS_STATUS_RESULT == ok-sync ]]; then
        if [[ -n "$VCS_STATUS_LOCAL_BRANCH" ]]; then
            GITSTR="$VCS_STATUS_LOCAL_BRANCH"
        elif [[ -n "$VCS_STATUS_TAG" ]]; then
            GITSTR="#$VCS_STATUS_TAG"
        else
            GITSTR="@${VCS_STATUS_COMMIT:0:8}"
        fi
        PROMPT+="%{$fg[red]%}(${GITSTR})"
        (( $VCS_STATUS_NUM_UNSTAGED )) && PROMPT+="%{$fg[yellow]%}*"
        (( $VCS_STATUS_NUM_UNTRACKED )) && PROMPT+="%{$fg[yellow]%}+"
    fi
    PROMPT+="%{$reset_color%} "
}

gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'

autoload -Uz colors && colors
autoload -Uz add-zsh-hook
add-zsh-hook precmd set_prompt
