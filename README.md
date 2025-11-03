<h1 align="center">
  Glossy Shell🍀
</h1>
<h3 align="center">
A promised future for your desktop
</h2>
<h3 align="center">
  
![Arch](https://img.shields.io/badge/Arch%20Linux-1793D1?logo=arch-linux&logoColor=fff&style=for-the-badge) ![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)

![Версия проекта](https://img.shields.io/badge/version-0.0.1-blue) ![Статус сборки](https://img.shields.io/badge/build-passing-brightgreen) ![Лицензия](https://img.shields.io/badge/license-MIT-green) ![Открытые issues](https://img.shields.io/github/issues/qvap/glossy-shell) ![Форки](https://img.shields.io/github/forks/qvap/glossy-shell) ![Звезды](https://img.shields.io/github/stars/qvap/glossy-shell)

</h3>

### 🐋 Description

**Glossy Shell** — is a modern, fast and configurable shell, designed for visually appealing workspaces on Linux systems.

---

### 🐠 Design principles

The development of Glossy Shell includes individual attention to its design: it is inspired by the Frutiger Aero aesthetic and its subgenres,
making the shell look glossy, transparent, and beautifully animated. Glossy Shell combines the principles of Material 3 and Frutiger Aero,
which makes it possible to create a unique design.

---

### 🦋 Manual installation

To setup Glossy Shell on your system, do these steps:
1. **Install dependecies from AUR**:
    ```sh
    yay quickshell-git swww matugen
    ```
    or use another AUR package manager.

2. **Add next code to the matugen config (~/.config/matugen/config.toml)**:
    ```sh
    [config]
    reload_apps = true

    [config.wallpaper]
    command = "swww"
    arguments = [ "img", "-t", "fade", "--transition-duration", "0.5", "--transition-step", "255", "--transition-fps", "60", "-f", "Nearest",]
    set = true

    [templates.glossy]
    input_path = "~/.config/quickshell/glossy/matugen/template.json"
    output_path = "~/.config/quickshell/glossy/userconfig/colors.json"
    ```

3.  **Clone repository to Quickshell folder:**
    ```sh
    cd ~/.config/quickshell && git clone https://github.com/qvap/Glossy-Shell.git
    ```

4.  **Run:**
    ```sh
    qs -c Glossy-Shell
    ```
    
    you can add this prompt to Hyprland's execs
