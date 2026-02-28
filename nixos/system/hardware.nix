{
  config,
  lib,
  pkgs,
  profile,
  ...
}:

{
  services.xserver.videoDrivers = lib.mkIf profile.gpu.nvidia [
    "nvidia"
    "amdgpu"
  ];

  hardware.graphics.enable = true;

  hardware.nvidia = lib.mkIf profile.gpu.nvidia {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = lib.mkIf profile.gpu.prime {
      nvidiaBusId = profile.gpu.nvidiaBusId;
      amdgpuBusId = profile.gpu.amdgpuBusId;

      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

  environment.systemPackages = lib.mkIf profile.gpu.nvidia (
    with pkgs;
    let
      # 1. Tomamos el paquete original de Hashcat y forzamos el soporte CUDA.
      # 2. Inyectamos el parche oficial (autoAddDriverRunpath) para evitar el problema de los "stubs".
      hashcat-parcheado = (hashcat.override { cudaSupport = true; }).overrideAttrs (oldAttrs: {
        nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ autoAddDriverRunpath ];
      });
    in
    [
      cudaPackages.cudatoolkit
      cudaPackages.cuda_nvrtc

      (writeShellScriptBin "hashcat" ''
        exec nvidia-offload ${hashcat-parcheado}/bin/hashcat "$@"
      '')
    ]
  );
}
