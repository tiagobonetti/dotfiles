# Woraround for VTE based terminals (Tilix)
VTE_SH=/etc/profile.d/vte.sh
if [[ ($TILIX_ID || $VTE_VERSION) && -f $VTE_SH ]]; then
    source $VTE_SH
fi

