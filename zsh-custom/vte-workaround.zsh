# Woraround for VTE based terminals (Tilix)
if [[ $TILIX_ID || $VTE_VERSION ]]; then
    vte_glob=(/etc/profile.d/vte*.sh(N)) # zsh: (N) use nullglob
    vte_sh=${vte_glob[-1]}
    if [[ -f $vte_sh ]]; then
        source $vte_sh
    fi
fi

