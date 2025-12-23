# 🚀 My Neovim Python IDE Setup

## 🛠️ General Settings
- **Leader Key**: `Space`
- **Auto-Format**: On (Runs `Ruff` and `BasedPyright` on every `.py` save)
- **Diagnostics**: Virtual text is **OFF**. Press `gl` to see error details.

---

## 📂 Navigation & Explorer
| Key | Action |
| :--- | :--- |
| `<leader>e` | **Toggle Nvim-Tree** (File Explorer) |
| `<leader>tf` | **Find Current File** in the Explorer tree |
| `Ctrl + h/j/k/l` | Move between windows (Left, Down, Up, Right) |
| `Ctrl + →` | **Next Tab** (Buffer) |
| `Ctrl + ←` | **Previous Tab** (Buffer) |
| `<leader>bq` | **Close Current Tab** (Quit Buffer) |

---

## 🔍 Telescope (Searching)
| Key | Action |
| :--- | :--- |
| `<leader>ff` | **Find Files** by name |
| `<leader>fg` | **Grep Search** (Search text inside files) |
| `<leader>fb` | Search through **Open Buffers** |
| `<leader>fr` | Search **Recent Files** |
| `<leader>fh` | Search **Help Tags** |

---

## 🐍 Python & LSP Features
| Key | Action |
| :--- | :--- |
| `<leader>ld` | **Definition**: Jump to function/class source |
| `<leader>lh` | **Hover**: Show documentation & types |
| `<leader>lr` | **Rename**: Refactor variable name project-wide |
| `<leader>la` | **Actions**: Show quick-fixes |
| `gl` | **Show Error**: View diagnostic for current line |
| `<leader>dn` | Go to **Next Error** |
| `<leader>dp` | Go to **Previous Error** |

---

## 🐞 Debugger (DAP)
| Key | Action |
| :--- | :--- |
| `<leader>db` | **Toggle Breakpoint** |
| `<leader>dc` | **Start / Continue** Debugging |
| `<leader>di` | **Step Into** function |
| `<leader>do` | **Step Over** line |
| `<leader>dt` | **Terminate** Debug session |
| `<leader>dr` | **Toggle Debug UI** (REPL/Windows) |

---

## 💻 Terminal
| Key | Action |
| :--- | :--- |
| `<leader>tf` | **Floating Terminal** (Best for quick commands) |
| `<leader>tv` | **Vertical Terminal** (Side-by-side) |
| `<leader>th` | **Horizontal Terminal** (Bottom split) |

---

## 🎨 Visual Indicators (Tokyonight Storm)
- **Blue Cursor/Lualine**: Normal Mode
- **Orange Cursor/Lualine**: Insert Mode
- **Purple Cursor/Lualine**: Visual Mode
