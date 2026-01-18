This is a repository for personal use, so no guarantee that it will work on your system. But feel free to try and modify.

## Prerequisites:
### For Python IDE
* `neovim` 0.11+
* For Wayland Systems: `wl-clipboard`
* A python virtual environment set at the location: `~/.local/share/nvim/venv/neovim`
* `pynvm` package is installed into the virtual environment mentioned above.
* `tree-sitter-cli` (v0.25+) is installed. (In Debian 13, the version is 0.22, therefore you need to install it in a different way. I used installing via `cargo`. But that was also old in Debian, so I installed tat from Debian backports first.)
* FOR DEBIAN-13: `cargo` (v1.88+) is installed on the system and `$HOME/.cargo/bin` is added to the `$PATH`.
* `ripgrep`

### For Latex Editor
* `zathura` (v0.5.11+) is installed.
    The following line is added to the zathura config file (`$HOME\.config\zathura\zathurarc`): 
    `set synctex-editor-command "nvr --remote-silent +%{line} %{input}"`.
* `neovim-remote` is installed to the python virtual environment neovim uses (see your `init.lua` file to remember its path)
* `xdotools` is installed. (not sure if this really works on Wayland, though)


