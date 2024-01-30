import { defineConfig } from "https://raw.githubusercontent.com/Ryooooooga/gh-rd/main/src/config/types.ts";

const saveCommandOutput = async (
  cmd: [string, ...string[]],
  to: string,
) => {
  const { stdout } = await new Deno.Command(cmd[0], {
    args: cmd.slice(1),
    stderr: "inherit",
  }).output();

  await Deno.writeFile(to, stdout);
}

const saveRemoteFile = async (
  from: string,
  to: string,
) => {
  const res = await fetch(new URL(from));
  if (res.body !== null) {
    await Deno.writeFile(to, res.body);
  }
}

export default defineConfig({
  tools: [
    {
      name: "rossmacarthur/sheldon",
      async onDownload({ packageDir, bin: { sheldon } }) {
        await saveCommandOutput(
          [sheldon, "source"],
          `${packageDir}/sheldon.zsh`,
        );
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
      async onDownload({ packageDir, bin: { direnv } }) {
        await saveCommandOutput(
          [direnv, "hook", "zsh"],
          `${packageDir}/direnv.zsh`,
        );
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
      async onDownload ({ packageDir, bin: { gh } }) {
        await saveCommandOutput(
          [gh, "completion", "--shell", "zsh"],
          `${packageDir}/_gh`,
        );
      },
    },
    {
      name: "Ryooooooga/zabrze",
      async onDownload({ packageDir, bin: { zabrze } }) {
        await saveCommandOutput(
          [zabrze, "init", "--bind-keys"],
          `${packageDir}/zabrze.zsh`,
        );
      },
    },
    {
      name: "eza-community/eza",
      async onDownload({ packageDir }) {
        await saveRemoteFile(
          "https://raw.githubusercontent.com/eza-community/eza/main/completions/zsh/_eza",
          `${packageDir}/_eza`,
        );
      },
    },
    {
      name: "mikefarah/yq",
      rename: [
        { from: "yq_*", to: "yq", chmod: 0o755 },
      ],
      async onDownload({ packageDir, bin: { yq } }) {
        await saveCommandOutput(
          [yq, "shell-completion", "zsh"],
          `${packageDir}/_yq`,
        );
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
