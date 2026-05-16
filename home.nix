{ ... }: {
  home.username = "lucky";
  home.homeDirectory = "/home/lucky";

  imports = [
    ./modules/packages.nix
    ./modules/activation.nix
  ];

  home.file = {
    # .zshenv
    ".zshenv".source = ./home/config/zsh/.zshenv;

    # zsh
    ".config/zsh/.zshrc".source = ./home/config/zsh/.zshrc;

    # git
    ".config/git/config".source = ./home/config/git/config;

    # mise
    ".config/mise/config.toml".source = ./home/config/mise/config.toml;
    ".config/mise/hooks/generate-tab-completion.sh" = {
      source = ./home/config/mise/hooks/generate-tab-completion.sh;
      executable = true;
    };
    ".config/mise/hooks/postinstall.sh" = {
      source = ./home/config/mise/hooks/postinstall.sh;
      executable = true;
    };
    ".config/mise/tasks/git/use-ssh-remote.sh" = {
      source = ./home/config/mise/tasks/git/use-ssh-remote.sh;
      executable = true;
    };
    ".config/mise/tasks/dot/apply-changes.sh" = {
      source = ./home/config/mise/tasks/dot/apply-changes.sh;
      executable = true;
    };
    ".config/mise/tasks/jj/commit.sh" = {
      source = ./home/config/mise/tasks/jj/commit.sh;
      executable = true;
    };
    ".config/mise/tasks/jj/create-pr.sh" = {
      source = ./home/config/mise/tasks/jj/create-pr.sh;
      executable = true;
    };
    ".config/mise/tasks/jj/merge-pr-and-rebase.sh" = {
      source = ./home/config/mise/tasks/jj/merge-pr-and-rebase.sh;
      executable = true;
    };
    ".config/mise/tasks/jj/merge-pr.sh" = {
      source = ./home/config/mise/tasks/jj/merge-pr.sh;
      executable = true;
    };
    ".config/mise/tasks/jj/push-and-create-pr.sh" = {
      source = ./home/config/mise/tasks/jj/push-and-create-pr.sh;
      executable = true;
    };
    ".config/mise/tasks/jj/push.sh" = {
      source = ./home/config/mise/tasks/jj/push.sh;
      executable = true;
    };
    ".config/mise/tasks/jj/rebase.sh" = {
      source = ./home/config/mise/tasks/jj/rebase.sh;
      executable = true;
    };
    ".config/mise/tasks/jj/split-commit.sh" = {
      source = ./home/config/mise/tasks/jj/split-commit.sh;
      executable = true;
    };

    # jj
    ".config/jj/config.toml".source = ./home/config/jj/config.toml;

    # gh
    ".config/gh/config.yml".source = ./home/config/gh/config.yml;

    # sheldon
    ".config/sheldon/plugins.toml".source = ./home/config/sheldon/plugins.toml;

    # starship
    ".config/starship/starship.toml".source = ./home/config/starship/starship.toml;

    # vim
    ".config/vim/vimrc".source = ./home/config/vim/vimrc;

    # zabrze
    ".config/zabrze/config.toml".source = ./home/config/zabrze/config.toml;

    # cage
    ".config/cage/presets.yaml".source = ./home/config/cage/presets.yaml;

    # opencode
    ".config/opencode/opencode.jsonc".source = ./home/config/opencode/opencode.jsonc;

    # claude
    ".claude/CLAUDE.md".source = ./home/claude/CLAUDE.md;
    ".claude/commands/jj-commit.md".source = ./home/claude/commands/jj-commit.md;
    ".claude/commands/jj-split-commit.md".source = ./home/claude/commands/jj-split-commit.md;
    ".claude/commands/search.md".source = ./home/claude/commands/search.md;
    ".claude/hooks/curl-get-only.py" = {
      source = ./home/claude/hooks/curl-get-only.py;
      executable = true;
    };
    ".claude/hooks/rtk-rewrite.sh" = {
      source = ./home/claude/hooks/rtk-rewrite.sh;
      executable = true;
    };
    ".claude/hooks/.rtk-hook.sha256".source = ./home/claude/hooks/.rtk-hook.sha256;
    ".claude/settings.json".source = ./home/claude/settings.json;

    # githooks
    ".githooks/pre-push" = {
      source = ./home/githooks/pre-push;
      executable = true;
    };

    # ssh
    ".ssh/config".source = ./home/ssh/config;
    ".ssh/allowed_signers".source = ./home/ssh/allowed_signers;

    # bin
    "bin/restore-zsh-history" = {
      source = ./home/bin/restore-zsh-history;
      executable = true;
    };
    "bin/toast" = {
      source = ./home/bin/toast;
      executable = true;
    };
    "bin/functions/cd-ghq".source = ./home/bin/functions/cd-ghq;
  };

  home.stateVersion = "24.11";
}
