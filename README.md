# TermLock 🔒

A simple shell-based terminal locker that prompts for a password every time a new terminal session starts.

---

## ✨ Features
- Password-protected terminal startup
- Locks immediately on opening any shell (bash, zsh, fish, etc.)
- Prevents Ctrl+C, Ctrl+Z, and Ctrl+\ escape attempts
- Lightweight, zero dependencies
- Easy to install and uninstall

---

## 🚀 Quick Setup

Run the following command in your terminal:

```bash
bash <(curl -s https://raw.githubusercontent.com/eswar-7116/termlock/main/setup.sh)
```

- It will ask you to **set a password**.
- After setup, every new terminal session will prompt for the password!

---

## 🛠️ Uninstall

If you want to remove Terminal Lock:

```bash
bash <(curl -s https://raw.githubusercontent.com/eswar-7116/termlock/main/uninstall.sh)
```

- This will safely remove the lock and clean your shell configuration files.

---

## 📂 What it does internally
- Creates a hidden `.termlock` file in your home directory
- Adds an automatic run of `.termlock` inside:
  - `.bashrc`
  - `.zshrc`
  - `.profile`
  - `.bash_profile`
  - (and fish shell config too)

- Removes everything cleanly during uninstall (including `.termlock` and config entries)

---

## ⚡ Notes
- After installing or uninstalling, **restart your terminal** (or run `source ~/.bashrc` or `source ~/.zshrc` manually).
- **If you forget your password**, simply **re-run the setup script** to reset it:
```bash
bash <(curl -s https://raw.githubusercontent.com/eswar-7116/termlock/main/setup.sh)
```
**No reboot** is required, just restart your terminal to apply the new password.

---

## 📜 License
This project is licensed under the MIT License.

---

Crafted with boundless love ❤️ and respect 🙏 for the Linux community 🐧.
