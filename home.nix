{ config, pkgs, inputs, ... }:

{
  home.username = "immutaboy";
  home.homeDirectory = "/home/immutaboy";
  programs.git = {
    enable = true;
    settings.user.name = "loudbudgie";
    settings.user.email = "165721002+loudbudgie@users.noreply.github.com";
};
  home.stateVersion = "26.05";
  services.cliphist = {

      enable = true;

      # A Wayland session
      systemdTargets = ["graphical-session.target"];

      # Sway Target 
      # if using make sure that:
      # "wayland.windowManager.sway.systemd.enable = true;" is set
      # systemdTargets = ["sway-session.target"];

      extraOptions = [
        "-max-dedupe-search"
        "10"
        "-max-items"
        "100"
      ];
      allowImages = true;

    };

  programs.fish = {
    enable = true;
    functions = {
    	fish_prompt.body = ''
		set_color green
		echo (whoami)'@'(hostname)' '(prompt_pwd)
		set_color blue
		echo -n '$ '
	'';
    };
    interactiveShellInit = ''
    set fish_greeting
    set -g fish_prompt_pwd_dir_length 0
    '';
    shellAliases = {
	confignix = "nvim ~/.config/nixos/configuration.nix";
	flakenix = "nvim ~/.config/nixos/flake.nix";
	homenix = "nvim ~/.config/nixos/home.nix";
	updtf = "sudo nixos-rebuild switch --flake ~/.config/nixos#nixos";
#	swayconf = "nvim ~/.config/sway/config";
	niriconf = "nvim ~/.config/niri/config.kdl";
#	mangoconf = "nvim ~/.config/mango/config.conf";
#	qsconf = "nvim ~/.config/quickshell/config.qml";
	ll = "ls -Flash";
	ff = "fastfetch --logo nixos_old_small";
	upall = "nix flake update --flake ~/.config/nixos && sudo nixos-rebuild switch --flake ~/.config/nixos#nixos";
	gc5d = "nix-collect-garbage --delete-older-than 5d";
	dm = "niri-session";
    };
  };
# home.file.".config/fastfetch".source = ./config/fastfetch-configv1;
home.file.".config/fastfetch".source = ./config/fastfetch-configv2;
}
