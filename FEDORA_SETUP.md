# Setting up dml-arch-fixes on a Fedora machine

Step-by-step guide for installing GitHub CLI on a fresh Fedora box and
cloning + extending the `daiqi26470/dml-arch-fixes` private repo.

## 1. Install GitHub CLI

Pick one. The first two don't need sudo for the install step; the third is
the most common and adds the official repo so `dnf update` keeps gh current.

```bash
# Option A: from the official repo (recommended)
sudo dnf install -y 'dnf-command(config-manager)'
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install -y gh

# Option B: from Fedora's COPR (one-shot)
sudo dnf copr enable -y ubershmekel/gh-cli
sudo dnf install -y gh

# Option C: from the official tarball (no repo)
#   https://github.com/cli/cli/releases  (download gh_2.x.x_linux_amd64.tar.gz)
#   tar -xzf gh_*.tar.gz
#   sudo cp gh_*/bin/gh /usr/local/bin/
```

Verify:

```bash
gh --version
# gh version 2.x.x (2024-xx-xx)
```

## 2. Authenticate

You need a GitHub Personal Access Token (PAT) with `repo` scope.
Create one at https://github.com/settings/tokens/new (classic tokens
or fine-grained with "Administration: Read and write" if you want to
create repos through gh).

Save the token to a file (so it doesn't end up in shell history):

```bash
echo "ghp_replace_with_your_token" > ~/.config/gh/token
chmod 600 ~/.config/gh/token
```

Log in:

```bash
gh auth login --with-token < ~/.config/gh/token
gh auth status
# expected: ✓ Logged in to github.com as daiqi26470
```

## 3. Clone dml-arch-fixes

```bash
git clone https://github.com/daiqi26470/dml-arch-fixes.git
cd dml-arch-fixes

# Or use gh directly (handles auth prompt):
gh repo clone daiqi26470/dml-arch-fixes
cd dml-arch-fixes
```

You should see:

```
FEDORA_SETUP.md           this file
README.md                 14-round fix log
mod-clear-restart-source/ the new C++ module
clear-instance-and-restart.sh
gdkp-restart-watcher.sh
docker-compose.yml.current
clear_raid_and_restart.lua
worldserver.conf.additions
```

## 4. Make a change and push

```bash
# 1. Create a branch
git checkout -b my-fork-update

# 2. Edit something (e.g. add a note to README)
echo "" >> README.md
echo "<!-- edited on Fedora -->" >> README.md

# 3. Stage + commit
git add .
git commit -m "Note: edited on Fedora"

# 4. Push
git push -u origin my-fork-update
```

On github.com it now shows a `my-fork-update` branch.

## 5. Open a Pull Request (optional)

```bash
gh pr create --title "Update from Fedora" --body "First commit from the Fedora box."
```

This opens a PR against the main branch in the same repo. For a private
repo you can also use:

```bash
gh pr create --base main --head my-fork-update
```

## 6. Common pitfalls on Fedora

- **`gh: command not found` after install** — open a fresh shell. The
  install puts `gh` in `/usr/bin` but your current shell may not have
  rehashed `PATH`.
- **TLS errors behind corporate proxy** — set
  `git config --global http.proxy http://proxy.corp:8080` and
  `git config --global https.proxy http://proxy.corp:8080`.
- **Token revoked / 401** — go back to step 2 and re-issue a PAT. Old
  classic tokens are periodically auto-revoked by GitHub.
- **Wrong git author** — set your identity first:
  ```bash
  git config --global user.name  "Your Name"
  git config --global user.email "you@example.com"
  ```

## 7. Quick reference

| Task                                  | Command                                     |
|---------------------------------------|---------------------------------------------|
| Check auth                            | `gh auth status`                            |
| Show current user                     | `gh api user --jq .login`                   |
| List my repos                         | `gh repo list`                              |
| Create a new private repo             | `gh repo create my-thing --private --source=.` |
| Pull latest                           | `git pull`                                  |
| New branch                            | `git checkout -b <name>`                    |
| Commit + push                         | `git add . && git commit -m "msg" && git push` |
| Open a PR                             | `gh pr create`                              |

## 8. Where to look when things go wrong

- `gh auth status`            — token is valid? correct scopes?
- `git remote -v`             — is the remote URL correct?
- `gh repo view --web`        — does the repo even exist on GitHub?
- `tail -f ~/.config/gh/logs/*` — gh's own log

If gh is broken in a way the docs above don't cover, the GitHub CLI
manual is at https://cli.github.com/manual/.
