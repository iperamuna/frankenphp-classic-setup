# FrankenPHP Classic Setup

**FrankenPHP Classic Setup** is a robust, modular Bash installer designed to streamline the deployment of FrankenPHP in "Classic Mode" behind an Nginx reverse proxy. 

It simplifies the process of running **Laravel**, **WordPress**, or **Vanilla PHP** applications with the power of FrankenPHP, providing a production-ready environment with Systemd services, custom CLI wrappers, and optimized configurations.

## 🚀 Features

- **Modular Architecture**: Clean, maintainable bash scripts separated by logic (core, install, user, systemd, etc.).
- **Multi-Framework Support**: First-class support for Laravel, WordPress, and generic PHP projects.
- **Automated Systemd Service**: Generates and registers a `systemd` service for your application automatically.
- **Custom CLI Wrapper**: create a custom alias (e.g., `fphp`) to run PHP CLI commands via FrankenPHP easily (e.g., `fphp artisan migrate`).
- **Nginx Configuration**: Generates production-ready Nginx proxy configurations to drop into your sites-available.
- **PHP.ini Management**: Smart handling of PHP configurations using `PHP_INI_SCAN_DIR`.

## 📦 Installation & Usage

### 1. Clone the Repository
```bash
git clone https://github.com/iperamuna/frankenphp-classic-setup.git
cd frankenphp-classic-setup
```

### 2. Run the Setup Script
Make sure the script is executable and run it with root privileges:

```bash
chmod +x setup.sh
sudo ./setup.sh
```

### 3. Follow the Interactive Prompts
The script will guide you through:
1.  **Installation**: Downloading and installing the FrankenPHP binary.
2.  **User Setup**: Configuring the user to run the service.
3.  **App Configuration**: Selecting your application type (Laravel, WordPress, etc.) and directory.
4.  **Systemd**: Creating and enabling the system service.
5.  **CLI Wrapper**: Setting up a convenient command-line alias (e.g., `fphp`).
6.  **Nginx**: generating the necessary Nginx configuration blocks.

## 🛠️ How to Release / Deliver

To package this script for a release or delivery:

1.  **Clean up**: Ensure no temporary `.bak` files or local configs are in the folder.
2.  **Zip the Directory**:
    ```bash
    zip -r frankenphp-setup-v1.0.0.zip . -x "*.git*"
    ```
3.  **Distribute**: Share the `.zip` file. The end user simply needs to unzip it and run `sudo ./setup.sh`.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!  
Feel free to check the [issues page](https://github.com/iperamuna/frankenphp-classic-setup/issues).

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

## 📝 License

Distributed under the MIT License. See `LICENSE` for more information.

## 👤 Author

**Indunil Peramuna**

- **GitHub**: [@iperamuna](https://github.com/iperamuna)
- **LinkedIn**: [indunilperamuna](https://www.linkedin.com/in/iperamuna/)
- **Facebook**: [indunil.priyashan](https://web.facebook.com/indunil.priyashan/)
- **Website**: [siyalude.io](https://siyalude.io)

### 📧 Contact
- **Email**: [iperamuna@gmail.com](mailto:iperamuna@gmail.com) / [indunil@siyalude.io](mailto:indunil@siyalude.io)
- **WhatsApp**: [+94 77 767 1771](https://wa.me/94777671771)

---
*Made with ❤️ by Indunil Peramuna*
