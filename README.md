# ohmyzsh-custom-public

> **Wondering why anyone would spend this much time on a terminal?** 🤔
> Fair question. I wrote a whole article about it: why the default oh-my-zsh setup is just the warm-up, and how this repo turns a pile of plugins into a fast, lazy-loaded, actually-yours shell. Pick your language and come judge my aliases:
>
> - 🇧🇷 [Customizando o oh-my-zsh de verdade](https://lauraesteves.com/programacao/customizando-o-oh-my-zsh-de-verdade/)
> - 🇺🇸 [Customizing oh-my-zsh for real](https://lauraesteves.com/programming/customizing-oh-my-zsh-for-real/)
> - 🇪🇸 [Personalizando oh-my-zsh de verdad](https://lauraesteves.com/programacion/personalizando-oh-my-zsh-de-verdad/)

Custom configurations for [oh-my-zsh](https://ohmyz.sh/). This folder lives at `~/.oh-my-zsh/custom/` and all `*.zsh` files are automatically sourced in alphabetical order.

## Structure

```
~/.oh-my-zsh/custom/
├── aliases.zsh          # General aliases
├── aws.zsh              # AWS helpers
├── docker.zsh           # Docker aliases and cleanup
├── functions.zsh        # Utility functions
├── git.zsh              # Git aliases and functions
├── history.zsh          # Shell history settings
├── images.zsh           # Image conversion functions
├── lazyenv.zsh          # Lazy loader for dev tools (zinit)
├── options.zsh          # Shell options and exports
├── private.zsh          # Loader for private/ folder
├── theme.zsh            # Spaceship theme configuration
├── private/             # Private configs (gitignored)
├── plugins/
│   ├── wakatime/                 (submodule)
│   ├── zsh-autosuggestions/      (submodule)
│   └── zsh-syntax-highlighting/  (submodule)
└── themes/
    ├── spaceship-prompt/         (submodule)
    └── spaceship.zsh-theme       (symlink)
```

---

## Reference

### aliases.zsh

| Alias | Command |
|---|---|
| `zshconfig` | `subl ~/.zshrc ~/.oh-my-zsh/custom` |
| `bashconfig` | `subl ~/.bashrc` |
| `ohmyzsh` | `subl ~/.oh-my-zsh` |
| `awsconfig` | `subl ~/.aws` |
| `me` | `cd ~` |
| `custom` | `cd ~/.oh-my-zsh/custom` |
| `npm-global` | `npm -g ls --depth=0` |
| `npm-local` | `npm ls --depth=0` |
| `yanr` | `yarn` (typo-friendly) |
| `shrug` | Copies `¯\_(ツ)_/¯` to clipboard |
| `lenny` | Copies `( ͡° ͜ʖ ͡°)` to clipboard |
| `wut` | Copies `ಠ_ಠ` to clipboard |

#### Global pipe aliases

| Alias | Description |
|---|---|
| `G` | Pipe to `grep -i` (e.g. `ps aux G docker`) |
| `L` | Pipe to `less` |
| `T` | Pipe to `tail -20` |
| `NUL` | Redirect to `/dev/null 2>&1` |

---

### git.zsh

#### Aliases

| Alias | Command |
|---|---|
| `gti` | `git` (typo-friendly) |
| `gst.` | `git status .` |
| `gcqa` | `gco qa` |
| `gbD` | `git branch --delete --force` |
| `glprs` | List merge pull requests in log |
| `glaca` | Log with author and co-author |
| `gtl` | Show most recent tag |
| `gbcd` | Switch to develop, pull, delete previous branch |
| `gbcm` | Switch to main, pull, delete previous branch |
| `gwl` | `git worktree list` |
| `gwa` | `git worktree add` |
| `gwr` | `git worktree remove` |
| `gwp` | `git worktree prune` |

#### Functions

| Function | Description |
|---|---|
| `gstshow <term>` | Show diff of a stash by name |
| `gstapply <term>` | Apply a stash by name |
| `gsubup` | Update all git submodules to latest remote |
| `gbcn` | Copy branch name to clipboard (strips flow prefixes) |
| `gbDA <prefix>` | Delete local branches by prefix (e.g. `gbDA backup/`) |
| `gpatch [base]` | Generate `.patch` file from current branch vs base |
| `gpatchfiles [file]` | List files changed in a patch |
| `gwb <branch> [base]` | Create worktree + branch in sibling folder |
| `gwrm [branch]` | Remove worktree and optionally delete branch |
| `gwpr <pr-number>` | Checkout a PR into its own worktree for review |

---

### functions.zsh

| Function | Description |
|---|---|
| `extract <file>` | Universal decompressor (tar, zip, rar, gz, bz2, 7z) |
| `zsh-time` | Benchmark shell startup time |
| `mktouch <path>` | Create file with parent directories |
| `pdfman <cmd>` | Open man page as PDF in Preview |
| `folder-sizes` | Show sizes of subdirectories |
| `tophistory` | Show 30 most used commands |
| `man <cmd>` | Colorized man pages |
| `aliases [keyword]` | Search aliases and functions by keyword |
| `psg <term>` | Search processes by name |
| `killport <port>` | Kill processes on a given port |
| `hg <term>` | Search shell history |
| `blue <text>` | Print text in blue |
| `f <term>` | Find file by name (case-insensitive) |
| `r <term>` | Recursive grep in current directory |
| `delete_node_modules_recursive` | Remove all `node_modules/` recursively |
| `desgpt` | Replace ` — ` with `; ` in `.md` files |
| `showcolors` | Display all 256 terminal colors |

---

### docker.zsh

| Alias | Command |
|---|---|
| `dk` | `docker` |
| `dkr` / `dkrr` / `dkrri` | `docker run` / `--rm` / `--rm -it` |
| `dks` / `dkstop` / `dkrs` | `docker start` / `stop` / `restart` |
| `dkrm` / `dkrmi` | `docker rm` / `rmi` |
| `dkps` / `dkpsa` | `docker ps` / `ps -a` |
| `dke` / `dkei` | `docker exec` / `exec -it` |
| `dkl` / `dklf` | `docker logs` / `logs -f` |
| `dki` / `dktop` | `docker inspect` / `top` |
| `dkims` / `dkp` | `docker images` / `pull` |
| `containerclean` | Remove all stopped containers |
| `imageclean` | Remove dangling images |

---

### images.zsh

| Function | Description |
|---|---|
| `webptopng <name>` | `.webp` -> `.png` |
| `pngtowebp <name>` | `.png` -> `.webp` |
| `jpgtowebp <name>` | `.jpg` -> `.webp` |
| `heictojpg <name>` | `.heic` -> `.jpg` |
| `heictopng <name>` | `.heic` -> `.png` |
| `pngtojpg <name>` | `.png` -> `.jpg` |
| `jpgfy` | Convert all `.HEIC` in current directory to `.jpg` |
| `rmpng` | Remove all `.png` from current directory (with confirmation) |

---

### lazyenv.zsh

Lazy environment loader that defers slow tool initialization to ~2 seconds after prompt using [zinit](https://github.com/zdharma-continuum/zinit). Significantly reduces shell startup time.

| Tool | Method |
|---|---|
| nvm | `lazyenv-add` (with macOS brew detection) |
| pyenv + virtualenv | `lazyenv-add` |
| direnv | `lazyfn-add` |
| kubectl | `lazyfn-add` |
| brew completions | `lazyfn-add` |
| gvm | zinit direct eval |
| sdkman | zinit direct eval |
| gcloud | zinit direct eval |
| bun | zinit direct eval |

---

### aws.zsh

| Function | Description |
|---|---|
| `aws_none` | Unset `AWS_PROFILE`, `AWS_REGION`, and `AWS_DEFAULT_REGION` |

Also disables SAM CLI telemetry.

---

### history.zsh

| Setting | Value |
|---|---|
| `HISTFILE` | `~/.zhistory` |
| `HISTSIZE` / `SAVEHIST` | `10000` |
| `sharehistory` | Share history across sessions |
| `extendedhistory` | Save timestamps in history entries |
| `hist_ignore_dups` | Skip duplicate entries |
| `hist_ignore_space` | Commands prefixed with space are not saved |
| `inc_append_history` | Add commands as they run, not on exit |

---

### options.zsh

| Setting | Value |
|---|---|
| `auto_cd` | Navigate to directories without typing `cd` |
| `auto_menu` | Cycle through completions on repeated Tab |
| `always_to_end` | Move cursor to end after completion |
| `complete_in_word` | Tab-complete from the middle of a word |
| `COMPLETE_ALIASES` | Make aliases eligible for completion |
| `noflowcontrol` | Disable flow control (ctrl-s/ctrl-q) |
| `VISUAL` / `EDITOR` | `vim` |
| `ZSH_HIGHLIGHT_MAXLENGTH` | `60` |
| `SPACESHIP_GCLOUD_SHOW` | `false` |
| `SPACESHIP_PROMPT_ORDER` | `dir git node exec_time line_sep char` |
| `SPACESHIP_RPROMPT_ORDER` | `exit_code` |

---

### theme.zsh

Spaceship prompt theme configuration with custom sections and styling.

| Setting | Value |
|---|---|
| `ZSH_THEME` | `spaceship` |
| `SPACESHIP_PROMPT_ASYNC` | `false` |
| `SPACESHIP_PROMPT_ADD_NEWLINE` | `true` |
| `SPACESHIP_BATTERY_SHOW` | `false` |
| `SPACESHIP_DOCKER_SHOW` | `true` (cyan) |
| `SPACESHIP_TIME_SHOW` | `true` (gray, 24h format) |
| `SPACESHIP_DIR_TRUNC` | `5` (relative to repo root) |
| `SPACESHIP_EXEC_TIME_ELAPSED` | `2s` |
| `SPACESHIP_CHAR_SYMBOL` | `⚡` |

Custom sections and prompt order are defined in the private config.

---

## Plugins and themes

### Plugins (submodules)

| Plugin | Description |
|---|---|
| [wakatime](https://github.com/sobolevn/wakatime-zsh-plugin) | Sends terminal activity to WakaTime |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | History-based suggestions |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Terminal syntax highlighting |

### Themes

| Theme | Description |
|---|---|
| [spaceship-prompt](https://github.com/spaceship-prompt/spaceship-prompt) | Minimal and extensible prompt (submodule) |

---

## Private configuration

The `private/` folder is gitignored and meant for personal configuration that shouldn't be public (API keys, personal aliases, machine-specific settings, etc.).

`private.zsh` at the root automatically sources all `*.zsh` files inside `private/`, since oh-my-zsh only loads `*.zsh` files from the top level of `custom/` — it does not recurse into subdirectories.

### Using a separate repo for your private config

You can keep your private configuration in its own git repository and clone it directly:

```bash
cd ~/.oh-my-zsh/custom
git clone git@github.com:youruser/ohmyzsh-private.git private
```

Since `private/` is in `.gitignore`, the two repositories remain completely independent. `private.zsh` will source all `*.zsh` files from it automatically.

---

## Setup on a new machine

```bash
# 1. Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 2. Replace the custom folder with this repo
rm -rf ~/.oh-my-zsh/custom
git clone --recurse-submodules git@github.com:youruser/ohmyzsh-custom-public.git ~/.oh-my-zsh/custom

# 3. If you forgot --recurse-submodules
cd ~/.oh-my-zsh/custom
git submodule update --init --recursive

# 4. Install zinit (for lazy loading)
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
mkdir -p "$(dirname $ZINIT_HOME)"
git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# 5. Add private config (optional)
git clone git@github.com:youruser/ohmyzsh-private.git private
```
