{
  description = "Floxpkgs/Project Template";
  nixConfig.bash-prompt = "[flox] \\[\\033[38;5;172m\\]λ \\[\\033[0m\\]";
  inputs.floxpkgs.url = "github:flox/floxpkgs";

  # Declaration of external resources
  # =================================
  inputs.dream2nix.url = "github:nix-community/dream2nix";

  # =================================

  outputs = args @ {floxpkgs,dream2nix,  ...}: floxpkgs.project args (_: {
   
  passthru =  (dream2nix.lib.makeFlakeOutputs {
      systems = ["x86_64-linux"];
      config.projectRoot = ./.;
      source = ./.;
      settings = [
        {
          subsystemInfo.noDev = true;
          subsystemInfo.nodejs = 18;
        }
      ];
    })
    // {
      #checks = self.packages;
    };
  });
}
