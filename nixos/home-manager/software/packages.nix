{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # --- Recon & Enumeration ---
    nmap                # Port scanning and service discovery
    rustscan            # Ultra-fast port scanner (modern wrapper for nmap)
    ffuf                # Fast web fuzzer (directories, parameters, vhosts)
    gobuster            # Directory and DNS subdomain brute-forcing
    feroxbuster         # Recursive content discovery tool
    subfinder           # Passive subdomain enumeration
    dnsrecon            # Advanced DNS enumeration
    amass               # In-depth asset mapping and OSINT framework
    dig                 # Manual DNS query utility

    # --- Web Vulnerability ---
    burpsuite           # Intercepting proxy for manual web testing
    sqlmap              # Automated SQL injection exploitation
    nikto               # Web server misconfiguration scanner
    wpscan              # WordPress security scanner
    dirb                # Classic web directory brute-forcer
    whatweb             # Web technology fingerprinting tool

    # --- Exploitation & Shells ---
    metasploit          # Exploitation and post-exploitation framework
    netexec             # SMB/AD enumeration and abuse framework
    exploitdb           # Local exploit database (searchsploit)
    netcat-gnu          # Manual TCP/UDP connections and reverse shells
    rlwrap              # Adds history and editing to basic shells
    powershell          # Cross-platform PowerShell (useful in AD environments)

    # --- Wireless / WiFi ---
    aircrack-ng         # WiFi auditing suite (WEP/WPA/WPA2)
    reaverwps-t6x       # WPS PIN brute-force attacks
    wifite2             # Automated WiFi attack tool
    hcxdumptool         # Capture WPA handshakes and PMKIDs
    hcxtools            # Convert captures to hashcat-compatible formats
    bully               # Fast alternative WPS attack tool
    mdk4                # Advanced WiFi attacks (deauth, beacon flood, etc.)
    iw                  # Modern wireless interface configuration tool
    wirelesstools       # Legacy wireless tools (iwconfig, iwlist)

    # --- SMB, Windows & Active Directory ---
    smbclient-ng        # Modern SMB client
    samba               # SMB client/server suite
    enum4linux-ng       # Automated SMB enumeration tool
    bloodhound          # AD relationship visualization tool
    bloodhound-py       # Python-based AD data collector
    python313Packages.impacket # Python toolkit for Windows protocol abuse
    evil-winrm          # Remote PowerShell shell over WinRM
    kerbrute            # Kerberos user enumeration and brute force
    openldap            # Command-line LDAP client
    adidnsdump          # Dump DNS records from Active Directory
    neo4j               # Graph database backend for BloodHound
    #certipy             # Active Directory Certificate Services exploitation
    freerdp             # Modern and full-featured RDP client
    ligolo-ng           # Advanced tunneling and pivoting tool

    # --- Passwords & Cracking ---
    hashcat             # GPU-accelerated password cracking
    john                # John the Ripper (CPU password cracking)
    hashid              # Hash type identification tool
    thc-hydra           # Fast network login brute-forcer
    seclists            # Collection of wordlists and attack payloads
    rockyou             # Classic password wordlist
    wordlists            # Contains 2 scripts to get wordlist path. ej $(wordlists_path)/rockyou.txt

    # --- Networking & Sniffing ---
    tshark              # CLI network protocol analyzer (Wireshark terminal)
    bettercap           # MITM, sniffing, and network attack framework
    responder           # LLMNR/NBT-NS/MDNS poisoning tool
    sniffnet            # Visual network traffic monitoring tool
    

    # --- Reverse Engineering & Forensics ---
    ghidra-bin          # Advanced reverse engineering suite (GUI)
    radare2             # CLI reverse engineering framework
    binwalk             # Firmware and binary extraction tool
    stegseek            # Fast steghide password cracker
    steghide            # Hide data inside images/audio files
    exiftool            # Read and edit file metadata

    # --- Privacy Tools ---
    tor-browser         # Anonymous browsing via Tor network

    # --- Development ---
    python3             # Scripting and tooling development
    ruby                # Required for many offensive security tools
    ty                  # Python language server
    go                  # Build modern Go-based security tools
    gopls               # Go language server
    openjdk             # Required for BloodHound and Java-based tools
    maven               # Java project management tool
    rustup              # Rust toolchain manager
    nixd                # Nix language server

    # --- Personal ---
    telegram-desktop    # Messaging client
    qbittorrent         # BitTorrent client
    keepassxc           # Password manager
    emacs               # Advanced text editor
    vlc                 # Media player
    gimp                # Image editor
    gajim               # XMPP client
    goofcord            # Privacy focused Discord alternative
    ffmpeg-full         # Audio/video processing toolkit
    tmux                # Terminal multiplexer
    openvpn             # VPN client
    xclip               # Clipboard utility for terminal
    virt-manager        # qemu front end
    android-tools       # adb and some others I guess
    strawberry          # Music player. Can play local music and music from services
  ];
}
