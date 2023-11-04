{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "romain";
  home.homeDirectory = "/home/romain";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    ( discord.override { nss = nss_latest; } )
    autoconf
    automake
    autoreconfHook
    bat
    bc
    blueman
    burpsuite
    busybox
    clang-tools
    criterion
    docker
    docker-compose
    libsForQt5.dolphin
    dunst
    feh
    file
    flameshot
    gdb
    git-lfs
    htop
    hugo
    jetbrains.idea-ultimate
    libpcap
    libyamlcpp
    nerdfonts
    nitrogen
    nodejs
    oh-my-zsh
    openssl
    openvpn
    pavucontrol
    poetry
    pulseaudio
    slack
    tree
    unzip
    vscode	
    yarn
    zip
    zsh
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/romain/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "romain.de-javel-de-villersfarlay@epita.fr";
    userName = "Romain de Javel de Villersfarlay";
   # signing = {
   #     key = "3B8FFC4100942CB45A2A7DF25A44DA8F907191B0";
   #     gpgPath = "gpg2";
   #     signByDefault = true;
   # };
   # aliases = {
   #     l = "log --oneline --graph --decorate";
   #     sw = "switch";
   #     st = "status";
   #     cm = "commit";
   # };

    extraConfig = {
   #     core = {
   #         editor = "nvim";
   #         excludesfile = "~/.gitignore";
   #     };
        commit = {
            verbose = true;
        };
        pull = {
            rebase = true;
        };
   #     rebase = {
   #         autoSquash = true;
   #         autoStash = true;
   #     };
   #     color = {
   #         ui = true;
   #     };
        push = {
            default = "simple";
        };
   #     branch = {
   #         autosetuprebase = "always";
   #     };
    };

   # includes = [
   #     {
   #       condition = "gitdir:~/EPITA/prologin/";
   #       contents = {
   #         user = {
   #             email = "adrien.langou@prologin.org";
   #         };
   #       };
   # 	};
   # ];
};
  programs.zsh = {
    syntaxHighlighting.enable = true;
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
    #envExtra = ''
    #export NNTPSERVER='snews://news.epita.fr:563';
    #'';
    oh-my-zsh = {
        enable = true;
        plugins = [
            "git"
        ];
	#theme = "dallas"; 
    };

    plugins = [
    {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
    {
        name = "powerlevel10k-config";
        src = lib.cleanSource ~/.config/zsh;
        file = ".p10k.zsh";
    }
    #{
    #    name = "zsh-nix-shell";
    #    file = "nix-shell.plugin.zsh";
    #    src = pkgs.fetchFromGitHub {
    #        owner = "chisui";
    #        repo = "zsh-nix-shell";
    #        rev = "v0.5.0";
    #        sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
    #    };
     # }
    ];
    shellAliases = {
        ls = "ls --color=auto";
     #   cat = "bat";
    };
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
        telescope-nvim
        nvim-tree-lua
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
