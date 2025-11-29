{ pkgs, ... }:

{
  # Define user accounts for the system
  users.users.noorul = {
    isNormalUser = true;
    description = "Noorul Islam K M";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  users.users.unreal = {
    isNormalUser = true;
    description = "Mr.Noman";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  users.users.shaz = {
    isNormalUser = true;
    description = "Chachu";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
