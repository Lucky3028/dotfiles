import { defineConfig } from "https://deno.land/x/gh_rd/mod.ts";

export default defineConfig({
  tools: [
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
      name: "direnv/direnv",
      rename: [
        { from: "direnv*", to: "direnv" },
      ],
       async onDownload({ bin: { direnv }, $ }) {
        await $`${direnv} hook zsh > direnv.zsh`;
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
  ],
});
