---
allowed-tools: Bash(git switch main), Bash(git pull), Bash(git push), Bash(gh pr list:*), Bash(gh pr merge:*)
description: "Create and auto-merge PR."
---

# ファイルの変更をGitHub上のリモートリポジトリに反映する

以下の手順に従って、変更をリモートリポジトリに反映してください。

1. `git push`コマンドで現在のブランチの変更をすべてプッシュしてください。
2. `gh pr create`コマンドで、PRのタイトルや説明を適切に指定したうえで、PRを作成してください。PRのタイトルや説明は日本語で記載してください。
   すでにPRがある場合は、すでに存在するPRのタイトルや説明を書き換えてください。
3. `gh pr merge`コマンドで、作成したPRをマージしてください。
  その際、以下オプションを指定してください。
    - `--auto`: AutoMergeを有効にするため。
    - `--merge`: マージの方法をMergeとするため。（RebaseやSquashはしてはいけません。）
    - `--delete-branch`: ローカルとリモートにあるブランチを削除するため。
4. `git switch main`コマンドを実行することで、ブランチを`main`に切り替えて、`git pull`してください。
