{ ... }:

{
  imports = [
    ./packages.nix # Importa tu lista de paquetes general
    ./configs/newsboat.nix # Importa la configuración específica de Newsboat
    ./configs/fcitx.nix # Importa la configuracion de fcitx
  ];
}
