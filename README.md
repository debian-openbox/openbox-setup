# 🪟 openbox-setup

A complete Openbox configuration setup by [JustAGuy Linux](https://www.youtube.com/@JustAGuyLinux), featuring a polished, minimal desktop experience with theming, tools, and smart automation via a single `install.sh` script.

## 📦 What's Included

- 🖼️ Openbox configuration with custom theme: `Simply_Circles_Dark`
- 🧠 Smart workspace keybinds, window snapping, and mouse actions
- 📁 File manager: Thunar with archive plugin
- 🖥️ Terminal: [WezTerm](https://wezfurlong.org/wezterm/)
- 🔍 App launcher: Rofi
- 🔔 Notifications: Dunst
- 💡 Compositor: Picom (FT-Labs build)
- 📊 Panel: Polybar
- 🌗 Redshift toggle + volume scripts
- 🎛️ GTK & icon themes (Orchis & Colloid)
- 📄 Keybind viewer: `Super + h` for Rofi
- 🧰 `obmenu-generator` with dynamic menu support

## 🛠️ Directory Structure

```
openbox-setup/
├── install.sh              # One script to install and configure everything
├── README.md               # This file
└── config/
    ├── rc.xml              # Main Openbox config
    ├── autostart           # Startup applications
    ├── environment         # Session environment variables
    ├── menu.xml            # Static right-click menu
    ├── keybinds.rasi       # Rofi cheatsheet theme
    ├── dunst/              # Notification settings
    ├── picom/              # FT-Labs Picom config
    ├── polybar/            # Panel configuration
    ├── rofi/               # Rofi themes/configs
    ├── scripts/            # Custom volume/redshift/keybind tools
    ├── wallpaper/          # Default and custom wallpapers
    ├── obmenu/             # obmenu-generator schema
    └── themes/
        └── Simply_Circles_Dark/  # Openbox window border theme
```

## 🚀 Installation

1. Clone the repository:
```bash
git clone https://github.com/drewgrif/openbox-setup.git
cd openbox-setup
chmod +x install.sh
```

2. Run the installer:
```bash
./install.sh
```

3. Follow the prompts — your Openbox environment will be ready in minutes!

## 💾 What It Installs

The script will:

- Back up any existing `~/.config/openbox` directory
- Install required packages (`openbox`, `rofi`, `picom`, `thunar`, etc.)
- Set up themes and GTK appearance
- Install [fastfetch](https://github.com/fastfetch-cli/fastfetch) and download your preferred config
- Install [wezterm](https://github.com/wez/wezterm)
- Optionally replace `.bashrc` with the one from [jag_dots](https://github.com/drewgrif/jag_dots)
- Install and configure `obmenu-generator` with your custom schema
- Apply user directories and screenshot folder
- Enable relevant services (`avahi-daemon`, `acpid`)

## 🧷 Key Features

| Shortcut            | Action                           |
|---------------------|----------------------------------|
| `Super + Enter`     | Launch terminal (WezTerm)        |
| `Super + Space`     | App launcher (Rofi)              |
| `Super + H`         | Show keybinds in terminal        |
| `Super + Arrow Keys`| Snap window to side/center       |
| `Super + 1-0`       | Switch to desktop                |
| `Super + Shift + 1-0`| Move window to desktop          |
| `Print`             | Screenshot via `maim`            |
| `Alt + Print`       | Screenshot via `flameshot`       |
| `XF86Audio*`        | Multimedia keys support          |

## 🎨 Themes

- **Openbox theme:** Simply_Circles_Dark (from `config/themes`)
- **GTK Theme:** Orchis (dark, teal, grey tweaks)
- **Icon Theme:** Colloid Everforest/Dracula

## 🧠 Notes

- Menu is generated via `obmenu-generator -p -i`
- Wallpapers are located in `~/.config/openbox/wallpaper/`
- Scripts in `~/.config/openbox/scripts/` handle redshift, volume, keybinds

## 📺 Watch on YouTube

Want to see how it looks and works?  
🎥 Check out [JustAGuy Linux on YouTube](https://www.youtube.com/@JustAGuyLinux)

---

🧈 Part of the [Butter Bean Linux](https://butterbeanlinux.com) ecosystem.
```

---

Would you like this saved into your repo as `README.md`? I can also push it directly into the script if you're ready.
