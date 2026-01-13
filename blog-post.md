# Supercharge Your PHP Apps: The Ultimate Guide to FrankenPHP Classic Mode with Nginx

**By Indunil Peramuna**

Are you tired of the complexity of PHP-FPM tuning? Looking for modern performance without rewriting your entire infrastructure? Enter **FrankenPHP**.

While FrankenPHP is famous for its worker mode (running PHP as a long-running process), its **Classic Mode** is an unsung hero. It allows you to run standard PHP scripts with the power of the Caddy web server under the hood, but acts as a drop-in replacement for PHP-FPM, often yielding better performance and simplicity.

In this guide, I'll walk you through why you should care, how to set it up manually, and finally, I'll share a **free automated tool** I built to do it all for you in seconds.

---

## 🚀 Why FrankenPHP Classic Mode?

1.  **Modern Architecture**: Built on top of Caddy and Go, it brings modern HTTP/3 and automatic HTTPS capabilities (if exposed directly).
2.  **Performance**: Even in "Classic Mode" (where it behaves like a standard PHP server), it often outperforms traditional PHP-FPM setups due to its efficient Go-based threading model.
3.  **Simplicity**: It's a single binary. No more managing complex pools or FPM configurations.
4.  **Reverse Proxy Friendly**: It integrates perfectly behind Nginx, allowing you to keep your existing load balancers and server blocks while upgrading the PHP engine.
5.  **103 Early Hints Support**: Unlike FPM, FrankenPHP leverages Caddy to send "Early Hints," telling the browser to start downloading CSS and JS before the HTML is even fully generated.
6.  **Observability & Robustness**: You get enterprise-ready Prometheus metrics, structured logging, and the memory safety of Go for the server layer.

---

## 📦 The Build Debate: Static vs. Dynamic (Glibc)

When installing FrankenPHP, you often choose between a **Static Build** and a **Normal (Dynamic/Glibc) Build**. Here is why that matters:

### 🛡️ Static Build (The "Run Anywhere" Powerhouse)
The static build is one of FrankenPHP's killer features.
*   **Zero Dependencies**: Libraries like `libpng`, `libicu`, and `openssl` are baked directly into the binary. You don't need to `apt-get install` anything.
*   **True Portability**: The same file runs consistently on Alpine Linux, Debian, Ubuntu, CentOS, or Fedora. It’s "write once, run anywhere."
*   **Container Perfection**: It allows for microscopic Docker images (using `scratch` or `distroless`) since it doesn't need an OS userland.

### 🔗 Normal / Dynamic Build (Glibc)
This operates like the traditional `php` package you are used to.
*   **System Integration**: It relies on your operating system's shared libraries (`.so` files). This is useful if you need to use a specific system-patched version of a library.
*   **Extensibility**: sometimes easier to load rare, non-bundled PHP extensions that depend on specific system headers.
*   **Standard Behavior**: If you are in a standard Debian/Ubuntu environment and aren't moving binaries around, this feels the most familiar.

---

## 🛠️ The Hard Way: Manual Setup Guide

If you want to understand what's happening under the hood, here is how you set it up manually.

### 1. Download the Binary
First, you need to get the specific binary for your architecture.
```bash
curl https://frankenphp.dev/install.sh | sh
mv frankenphp /usr/local/bin/
```

### 2. Run It
You can run it directly:
```bash
frankenphp php-server --listen 127.0.0.1:9000 --root /path/to/app/public
```

### 3. Create a Systemd Service
To keep it running, you need a service file at `/etc/systemd/system/frankenphp.service`:

```ini
[Unit]
Description=FrankenPHP Server
After=network.target

[Service]
User=www-data
ExecStart=/usr/local/bin/frankenphp php-server --listen 127.0.0.1:9000 --root /var/www/html/public
Restart=always

[Install]
WantedBy=multi-user.target
```

### 4. Configure Nginx
Finally, point Nginx to port 9000:

```nginx
location ~ \.php$ {
    fastcgi_pass 127.0.0.1:9000;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include fastcgi_params;
}
```

---

## ⚡ The Smart Way: Automating with `frankenphp-classic-setup`

Manually editing systemd files and Nginx configs for every site is tedious and error-prone. That's why I created **FrankenPHP Classic Setup**.

It’s a modular Bash installer that handles everything for **Laravel**, **WordPress**, and **Vanilla PHP** projects.

### Key Features
*   ✅ **Auto-Detects Architecture**: Automatically installs the generic binary or a custom optimized static build (x86_64).
*   ✅ **Systemd Automation**: Generates and enables the service file for you.
*   ✅ **Nginx Configs**: Generates the exact Nginx proxy block you need.
*   ✅ **CLI Wrapper**: Creates an `fphp` alias (e.g., `fphp artisan migrate`) so you don't miss the `php` command.

### How to Use It

1.  **Clone the Repo**:
    ```bash
    git clone https://github.com/iperamuna/frankenphp-classic-setup.git
    cd frankenphp-classic-setup
    ```

2.  **Run the Script**:
    ```bash
    chmod +x setup.sh
    sudo ./setup.sh
    ```

3.  **Follow the Prompts**: The interactive script will ask for your app type and directory, then do the rest!

---

## 🤝 Need Help?

I’m committed to making PHP deployment easier for everyone. If you have questions or want to contribute, check out the project on GitHub or reach out to me directly.

**Indunil Peramuna**
*   **GitHub**: [@iperamuna](https://github.com/iperamuna)
*   **LinkedIn**: [indunilperamuna](https://www.linkedin.com/in/iperamuna/)
*   **Email**: [iperamuna@gmail.com](mailto:iperamuna@gmail.com)
*   **Website**: [siyalude.io](https://siyalude.io)
*   **Telegram**: [@iperamuna](https://t.me/iperamuna)
*   **Discord**: iperamuna
*   **WhatsApp**: [+94777671771](https://wa.me/94777671771)

Happy Coding! 🐘✨
