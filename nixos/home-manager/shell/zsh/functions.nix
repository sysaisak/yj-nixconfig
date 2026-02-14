{ ... }:
{
  programs.zsh.initContent = ''
    function fmtu() {
        local tun
        tun=$(sudo ip -o link show | awk -F': ' '/tun/ {print $2; exit}')
        if [[ -z "$tun" ]]; then
            echo "No tun interface found"
            return 1
        fi
        sudo ip link set "$tun" mtu 1200
    }

    # make base dirs to organize information
    function make_efs() {
        # Note the double single-quote before the dollar sign for arrays
        dirs=("./enumeration" "./files" "./scripts")
        all_exist=true

        for dir in "''${dirs[@]}"; do
            if [[ ! -d "$dir" ]]; then
                all_exist=false
                break
            fi
        done

        if "$all_exist"; then
            echo "[*] All dirs are present."
        else
            echo "[!] Making dirs"
            mkdir -p "''${dirs[@]}" 2>/dev/null
        fi
    }

    # Who is using that port?
    function portused () {
        sudo lsof -i :"''${1}"
    }

    function extract () {
        if [[ -f $1 ]]; then
            case $1 in
                *.tar.bz2) tar xjf $1 ;;
                *.tar.gz)  tar xzf $1 ;;
                *.bz2)     bunzip2 $1 ;;
                *.rar)     unrar x $1 ;;
                *.gz)      gunzip $1 ;;
                *.tar)     tar xf $1 ;;
                *.zip)     unzip $1 ;;
                *.7z)      7z x $1 ;;
                *) echo "[!] Unknown format" ;;
            esac
        else
            echo "$1 is not a valid file"
        fi
    }

    # Extract ports from nmap grepable output
    extract_ports() {
        if [ -z "''${1}" ]; then
            echo "[!] Usage: extract-ports <nmap_grep_file>"
            return 1
        fi

        if [ ! -f "''${1}" ]; then
            echo "[!] File ''${1} not found"
            return 1
        fi

        # Clipboard detection
        clip=()
        if [ "$XDG_SESSION_TYPE" = "wayland" ] && command -v wl-copy >/dev/null 2>&1; then
            clip="wl-copy"
        elif command -v xclip >/dev/null 2>&1; then
            clip="xclip -selection clipboard"
        fi

        # Extract ports. only open ports.
        ports=$(grep -oE '[0-9]{1,5}/open' "''${1}" \
            | cut -d/ -f1 \
            | xargs \
            | tr ' ' ',')

        # Extract the IP addr
        ip_address=$(grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' "''${1}" \
            | sort -u | head -n 1)

        echo -e "\n[*] Extracting information...\n"
        echo -e "\t[*] IP Address: ''${ip_address}"
        echo -e "\t[*] Open ports: ''${ports}\n"

        if [ -n "$clip" ]; then
            echo -n "''${ports}" | "''${clip[@]}"
            echo "[*] Ports copied to clipboard"
        else
            echo "[!] No clipboard utility found"
        fi
    }

    function mkdircd () {
        mkdir -p "$@" && cd "$_"
    }
  '';
}
