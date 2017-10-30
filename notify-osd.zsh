# commands to ignore
cmdignore=(htop tmux top vim nvim)

# end and compare timer, notify-send if needed
function notifyosd-precmd() {
    #store return value
    cmd_retval=$?
    # if command variable is not set we do nothing
    if [ -z "$cmd" ]; then
        return
    fi
    #ignore if command is in ignore list
    if [[ ${cmdignore[(r)$cmd_basename]} == $cmd_basename ]]; then
        return
    fi
    #calculate total time
    cmd_end=`date +%s`
    ((cmd_total=$cmd_end - $cmd_start))
    #ignore short commands
    if [ $cmd_total -lt 10 ]; then
        return
    fi

    #command finished with success?
    if [ $cmd_retval -gt 0 ]; then
        cmd_status="Warning"
        cmd_urgency="critical"
    else
        cmd_status="Success"
        cmd_urgency="normal"
    fi
    # ran on a remote server?
    if [ ! -z $SSH_TTY ] ; then
        cmd_locale="on `hostname` "
    fi
    # parse time
    cmd_time=$(units "$cmd_total sec" "time" | sed -e 's/^[ \t]*//g')

    #send notification
    notify-send \
        --urgency=$cmd_urgency \
        --expire-time=10000 \
        --icon=utilities-terminal \
        --hint int:transient:1 \
        "${cmd_basename} completed ${cmd_locale}; result: ${cmd_status}, time: $cmd_time" \
        "\"$cmd\"";

    unset cmd
    unset cmd_basename
    unset cmd_start
}

# make sure this plays nicely with any existing precmd
precmd_functions+=( notifyosd-precmd )

# get command name and start the timer
function notifyosd-preexec() {
    cmd=$1
    cmd_basename=${${cmd:s/sudo //}[(ws: :)1]}
    cmd_start=`date +%s`
}

# make sure this plays nicely with any existing preexec
preexec_functions+=( notifyosd-preexec )
