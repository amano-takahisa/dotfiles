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
    eog
    fd
    fish
    fzf
    less
    libsixel
    diffutils
    nodejs
    sshfs
    which
    zip
    ##### Neovim #####
    eslint
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
    (python3.pkgs.buildPythonApplication {
      pname = "totaliterm";
      version = "1.0.0";
      format = "pyproject";
      src = /home/takahisa/Documents/git/totaliterm;
      buildInputs = with pkgs.python3Packages; [hatchling];
      propagatedBuildInputs = with pkgs.python3.pkgs; [
        click
        rich
        tomlkit
        ];
    })
    ##### misc #####
    tmux
    tree
    unzip
    wl-clipboard
    xdg-user-dirs
    zk
    ##### fonts #####
    hackgen-nf-font
    font-awesome
  ];

  home.file = {
    ".config/fish/conf.d" = {
      source = lib.file.mkOutOfStoreSymlink /home/takahisa/Documents/git/dotfiles/.config/fish/conf.d;
    };
    ".config/fish/functions" = {
      source = lib.file.mkOutOfStoreSymlink /home/takahisa/Documents/git/dotfiles/.config/fish/functions;
    };
    ".config/git" = {
      source = lib.file.mkOutOfStoreSymlink /home/takahisa/Documents/git/dotfiles/.config/git;
    };
    ".config/nvim" = {
      source = lib.file.mkOutOfStoreSymlink /home/takahisa/Documents/git/dotfiles/.config/nvim;
    };
    ".config/zk" = {
      source = lib.file.mkOutOfStoreSymlink /home/takahisa/Documents/git/dotfiles/.config/zk;
    };
    ".jupyter/lab/user-settings" = {
      source = lib.file.mkOutOfStoreSymlink /home/takahisa/Documents/git/dotfiles/.jupyter/lab/user-settings;
    };
    ".jupyter/jupyter_lab_config.py" = {
      source = lib.file.mkOutOfStoreSymlink /home/takahisa/Documents/git/dotfiles/.jupyter/jupyter_lab_config.py;
    };
    ".tmux.conf" = {
      source = lib.file.mkOutOfStoreSymlink /home/takahisa/Documents/git/dotfiles/.tmux.conf;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
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


  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;
}
