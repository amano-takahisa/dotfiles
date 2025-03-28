{ config, pkgs, ... }:

let
  lib = config.lib;
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "takahisa";
  home.homeDirectory = "/home/takahisa";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    ##### dev-tools #####
    gcc
    gnumake
    openssh
    ##### basic tool #####
    bat
    eza
    fd
    fish
    fzf
    less
    libsixel
    nodejs
    sshfs
    which
    zip
    ##### Neovim #####
    eslint
    neovim
    nodePackages.prettier
    python3
    python3Packages.pynvim
    tree-sitter
    ##### Python #####
    isort
    jq
    pixi
    ripgrep
    ripgrep-all
    ruff
    ##### git #####
    gh
    git
    lazygit
    ##### misc #####
    tmux
    tree
    unzip
    wl-clipboard
    xdg-user-dirs
    zk
  ];

  home.file = {
    ".config/fish/conf.d" = {
      source = /home/takahisa/Documents/git/dotfiles/.config/fish/conf.d;
      recursive = true;
    };
    ".config/git" = {
      source = /home/takahisa/Documents/git/dotfiles/.config/git;
      recursive = true;
    };
    ".config/nvim" = {
      source = lib.file.mkOutOfStoreSymlink /home/takahisa/Documents/git/dotfiles/.config/nvim;
    };
    ".tmux.conf" = {
      source = /home/takahisa/Documents/git/dotfiles/.tmux.conf;
    };
  };

  programs.fish = {
                enable = true;
    interactiveShellInit = ''
      # Set up Nix environment for fish
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
        source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
      end

      # Add Nix paths to fish_user_paths
      if test -d $HOME/.nix-profile/bin
        fish_add_path $HOME/.nix-profile/bin
      end
    '';
          };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
