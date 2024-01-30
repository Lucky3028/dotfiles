import { defineConfig } from "https://raw.githubusercontent.com/Ryooooooga/gh-rd/main/src/config/types.ts";

export default defineConfig({
  tools: [
    {
      name: "rossmacarthur/sheldon",
      async onDownload({ bin: { sheldon }, $ }) {
        await $`${sheldon} source > sheldon.zsh`;
      },
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
        await $`${gh} completion --shell zsh > _gh`;
      },
    },
    {
      name: "Ryooooooga/zabrze",
      async onDownload({ bin: { zabrze }, $ }) {
        await $`${zabrze} init --bind-keys > zabrze.zsh`;
      },
    },
    {
      name: "eza-community/eza",
      async onDownload({ packageDir, $ }) {
        await $.request(
          "https://raw.githubusercontent.com/eza-community/eza/main/completions/zsh/_eza",
        ).pipeToPath(`${packageDir}/_eza`);
      },
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
      name: "denisidoro/navi",
    },
    {
      name: "sharkdp/fd",
    },
  ],
});
