{ pkgs, profile, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "aisak";
        email = "isaac.rkt@proton.me";
      };

      init.defaultBranch = "main";
      # Better diffs
      color.ui = true;
      # Automatically rebase when pulling
      pull.rebase = true;

      # Some aliases
      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        cm = "commit";
        last = "log -1 HEAD";
      };
    };
  };
}
