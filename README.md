# ohmyzsh-custom-public

Custom configurations for [oh-my-zsh](https://ohmyz.sh/). This folder lives at `~/.oh-my-zsh/custom/` and all `*.zsh` files are automatically sourced in alphabetical order.

## Structure

```
~/.oh-my-zsh/custom/
├── aliases.zsh          # General aliases
├── aws.zsh              # AWS helpers
├── functions.zsh        # Utility functions
├── git.zsh              # Git aliases and functions
├── history.zsh          # Shell history settings
├── images.zsh           # Image conversion functions
├── options.zsh          # Shell options and exports
├── private.zsh          # Loader for private/ folder
├── utility.zsh          # Dev tool wrappers
├── private/             # Private configs (gitignored)
├── plugins/
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
| `us` | `source ~/.zshrc` |
| `me` | `cd ~` |
| `custom` | `cd ~/.oh-my-zsh/custom` |
| `npm-global` | `npm -g ls --depth=0` |
| `npm-local` | `npm ls --depth=0` |
| `shrug` | Copies `¯\_(ツ)_/¯` to clipboard |
| `lenny` | Copies `( ͡° ͜ʖ ͡°)` to clipboard |
| `wut` | Copies `ಠ_ಠ` to clipboard |

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

#### Functions

| Function | Description |
|---|---|
| `sshow <term>` | Show diff of a stash by name |
| `sapply <term>` | Apply a stash by name |
| `gbDA <prefix>` | Delete local branches by prefix (e.g. `gbDA backup/`) |
| `gpatch [base]` | Generate `.patch` file from current branch vs base |
| `gpatchfiles [file]` | List files changed in a patch |
| `gsubup` | Update all git submodules to latest remote |

---

### functions.zsh

| Function | Description |
|---|---|
| `psg <term>` | Search processes by name |
| `killport <port>` | Kill processes on a given port |
| `hg <term>` | Search shell history |
| `blue <text>` | Print text in blue |
| `f <term>` | Find file by name (case-insensitive) |
| `r <term>` | Recursive grep in current directory |
| `delete_node_modules_recursive` | Remove all `node_modules/` recursively |
| `desgpt` | Replace ` — ` with `; ` in `.md` files |

---

### images.zsh

| Function | Description |
|---|---|
| `webptopng <name>` | `.webp` → `.png` |
| `pngtowebp <name>` | `.png` → `.webp` |
| `jpgtowebp <name>` | `.jpg` → `.webp` |
| `heictojpg <name>` | `.heic` → `.jpg` |
| `heictopng <name>` | `.heic` → `.png` |
| `pngtojpg <name>` | `.png` → `.jpg` |
| `jpgfy` | Convert all `.HEIC` in current directory to `.jpg` |
| `rmpng` | Remove all `.png` from current directory (with confirmation) |

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

---

### options.zsh

| Setting | Value |
|---|---|
| `auto_cd` | Navigate to directories without typing `cd` |
| `VISUAL` / `EDITOR` | `vim` |
| `ZSH_HIGHLIGHT_MAXLENGTH` | `60` |
| `SPACESHIP_GCLOUD_SHOW` | `false` |

---

### utility.zsh

Dev tool wrappers for `nx` and `make`.

---

## Plugins and themes

### Plugins (submodules)

| Plugin | Description |
|---|---|
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

You can keep your private configuration in its own git repository and add it as a submodule:

```bash
cd ~/.oh-my-zsh/custom

# Add your private repo as a submodule
git submodule add git@github.com:youruser/ohmyzsh-private.git private

# Initialize and pull the contents
git submodule update --init --recursive
```

Since `private/` is in `.gitignore`, the submodule reference in `.gitmodules` won't be tracked by this public repo. Your private config stays in its own repository, and `private.zsh` will source all `*.zsh` files from it automatically.

To clone everything on a new machine:

```bash
# 1. Clone the public repo
git clone --recurse-submodules git@github.com:youruser/ohmyzsh-custom-public.git ~/.oh-my-zsh/custom

# 2. Add the private repo
cd ~/.oh-my-zsh/custom
git clone git@github.com:youruser/ohmyzsh-private.git private
```

> **Note:** Since `private/` is gitignored, using `git submodule add` will be blocked by git. Simply `git clone` your private repo directly into the `private/` folder instead. It will function as an independent repository.

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
```
