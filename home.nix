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
#    gtk = {
#	enable = true;
#    };
    qt = {
	enable = true;
#	platformTheme.name = "qtct";
	style.name = "kvantum";
	kvantum = {
	    enable = true;
	    themes = [ (pkgs.catppuccin.override {
	    accent = "green";
	    variant = "mocha";
	    themeList = [ "kvantum" ];
	    })
	    ];
	    settings.General.theme = "catppuccin-mocha-green";
	};
    };
# for qtile
programs.rofi = {
    enable = true;
    theme = "material";
    font = "Fira Sans 12";
    package = pkgs.rofi;
    modes = [
      "drun"
      "run"
      "window"
      "ssh"  
    ];
    extraConfig = {
      show-icons = true;
    };
  };
services.swayosd = {
    enable = true;
    topMargin = 0.9;
};
programs.waybar = {
    enable = true;
    systemd.enable = false;
};
# services.clipmenu = {
#     enable = true;
#     launcher = "rofi";
# };


services.dunst = {
  enable = true;
  settings = {
    global = {
      font = "Fira Sans 12";
      corner_radius = 8;
	frame_color = "#70bc6d";
	frame_width = 2;
	background = "#50854e"; # Vibrant emerald green background
      foreground = "#cbe8ca"; # Dark gray/black text so it's easy to read
      timeout = 10;
    };
  };
};
# end of qtile block

  programs.fish = {
    enable = true;
    functions = {
    	fish_prompt.body = ''
		set_color green
		echo (whoami)'@'(hostname)' '(prompt_pwd)
		set_color blue
		echo -n '> '
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
