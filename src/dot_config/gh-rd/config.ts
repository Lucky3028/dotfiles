import { defineConfig } from "https://deno.land/x/gh_rd/mod.ts";

export default defineConfig({
  tools: [
    {
      name: "jj-vcs/jj"
    },
    {
      name: "sagiegurari/cargo-make",
      executables: [
        { glob: "**/makers" },
      ],
    },
    {
      name: "bitwarden/clients",
      tag: "cli-v2025.9.0",
      executables: [
        { glob: "bw" },
      ],
      async onDownload({ bin: { bw }, $ }) {
        await $`${bw} completion --shell zsh > _bw`;
      },
    },
    {
      name: "rhysd/actionlint",
    },
    {
      name: "suzuki-shunsuke/ghalint",
    },
    {
      name: "suzuki-shunsuke/pinact",
    },
    {
      name: "denisidoro/navi",
    },
    {
      name: "rossmacarthur/sheldon",
    },
    {
      name: "junegunn/fzf",
    },
    {
      name: "BurntSushi/ripgrep",
      executables: [
        { glob: "**/rg", as: "rg" },
      ],
    },
    {
      name: "eza-community/eza",
      completions: [
        { glob: "*/completions/zsh/_eza" },
      ],
    },
    {
      name: "mikefarah/yq",
      rename: [
        { from: "yq_*", to: "yq", chmod: 0o755 },
      ],
      async onDownload({ bin: { yq }, $ }) {
        await $`${yq} shell-completion zsh > _yq`;
      },
    },
    {
      name: "sharkdp/bat",
      completions: [
        { glob: "*/autocomplete/bat.zsh", as: "_bat" },
      ],
    },
    {
      name: "cli/cli",
      async onDownload({ bin: { gh }, $ }) {
        await $`${gh} completion --shell zsh >_gh`;
      },
    },
    {
      name: "x-motemen/ghq",
      completions: [
        { glob: "*/misc/zsh/_ghq" },
      ],
    },
    {
      name: "Ryooooooga/zabrze",
    },
    {
      name: "sharkdp/fd",
    },
    {
      name: "zellij-org/zellij",
    },
    {
      name: "starship/starship",
      async onDownload({ bin: { starship }, $ }) {
        await $`${starship} completions zsh >_starship`;
      },
    },
  ],
});
