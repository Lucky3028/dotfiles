{ ... }: {
  home.username = "lucky";
  home.homeDirectory = "/home/lucky";

  imports = [
    ./modules/packages.nix
    ./modules/activation.nix
  ];

  home.file = {
    # .zshenv
    ".zshenv".source = ./config/.zshenv;

    # zsh
    ".config/zsh/.zshrc".source = ./config/zsh/.zshrc;

    # git
    ".config/git/config".source = ./config/git/config;

    # mise
    ".config/mise/config.toml".source = ./config/mise/config.toml;
    ".config/mise/hooks/generate-tab-completion.sh" = {
      source = ./config/mise/hooks/generate-tab-completion.sh;
      executable = true;
    };
    ".config/mise/hooks/postinstall.sh" = {
      source = ./config/mise/hooks/postinstall.sh;
      executable = true;
    };
    ".config/mise/tasks/git/use-ssh-remote.sh" = {
      source = ./config/mise/tasks/git/use-ssh-remote.sh;
      executable = true;
    };
    ".config/mise/tasks/dot/apply-changes.sh" = {
      source = ./config/mise/tasks/dot/apply-changes.sh;
      executable = true;
    };
    ".config/mise/tasks/jj/commit.sh" = {
      source = ./config/mise/tasks/jj/commit.sh;
      executable = true;
    };
    ".config/mise/tasks/jj/create-pr.sh" = {
      source = ./config/mise/tasks/jj/create-pr.sh;
      executable = true;
    };
    ".config/mise/tasks/jj/merge-pr-and-rebase.sh" = {
      source = ./config/mise/tasks/jj/merge-pr-and-rebase.sh;
      executable = true;
    };
    ".config/mise/tasks/jj/merge-pr.sh" = {
      source = ./config/mise/tasks/jj/merge-pr.sh;
      executable = true;
    };
    ".config/mise/tasks/jj/push-and-create-pr.sh" = {
      source = ./config/mise/tasks/jj/push-and-create-pr.sh;
      executable = true;
    };
    ".config/mise/tasks/jj/push.sh" = {
      source = ./config/mise/tasks/jj/push.sh;
      executable = true;
    };
    ".config/mise/tasks/jj/rebase.sh" = {
      source = ./config/mise/tasks/jj/rebase.sh;
      executable = true;
    };
    ".config/mise/tasks/jj/split-commit.sh" = {
      source = ./config/mise/tasks/jj/split-commit.sh;
      executable = true;
    };

    # jj
    ".config/jj/config.toml".source = ./config/jj/config.toml;

    # gh
    ".config/gh/config.yml".source = ./config/gh/config.yml;

    # sheldon
    ".config/sheldon/plugins.toml".source = ./config/sheldon/plugins.toml;

    # starship
    ".config/starship/starship.toml".source = ./config/starship/starship.toml;

    # vim
    ".config/vim/vimrc".source = ./config/vim/vimrc;

    # zabrze
    ".config/zabrze/config.toml".source = ./config/zabrze/config.toml;

    # cage
    ".config/cage/presets.yaml".source = ./config/cage/presets.yaml;

    # claude
    ".claude/CLAUDE.md".source = ./claude/CLAUDE.md;
    ".claude/commands/jj-commit.md".source = ./claude/commands/jj-commit.md;
    ".claude/commands/jj-split-commit.md".source = ./claude/commands/jj-split-commit.md;
    ".claude/commands/search.md".source = ./claude/commands/search.md;
    ".claude/commands/serena.md".source = ./claude/commands/serena.md;
    ".claude/hooks/curl-get-only.py" = {
      source = ./claude/hooks/curl-get-only.py;
      executable = true;
    };
    ".claude/settings.json".source = ./claude/settings.json;

    # serena
    ".serena/serena_config.yml".source = ./serena/serena_config.yml;

    # ssh
    ".ssh/config".source = ./ssh/config;
    ".ssh/allowed_signers".source = ./ssh/allowed_signers;

    # bin
    "bin/github-mcp-server" = {
      source = ./bin/github-mcp-server;
      executable = true;
    };
    "bin/restore-zsh-history" = {
      source = ./bin/restore-zsh-history;
      executable = true;
    };
    "bin/toast" = {
      source = ./bin/toast;
      executable = true;
    };
  };

  home.stateVersion = "24.11";
}
