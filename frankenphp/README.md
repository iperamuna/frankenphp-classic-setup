# FrankenPHP Static Standalone Build (x86_64)

This folder contains a **Static Standalone** build of FrankenPHP for Linux x86_64 architectures. 

Being a static binary, it bundles all necessary libraries (including libc) directly into the executable. This means it has **zero external dependencies** and will run on virtually any Linux distribution (Alpine, Ubuntu, Debian, CentOS, RHEL, Arch, etc.) regardless of the system's glibc version.

## 📦 Build Information

- **PHP Version**: 8.4.2
- **FrankenPHP Version**: 1.10.1
- **Architecture**: x86_64
- **OS**: Linux
- **Type**: Static Binary (built with static-php-cli 2.7.9)
- **SSL**: OpenSSL 3.6.0
- **ICU**: 77.1

## 🚀 Included Extensions

This build comes pre-packaged with a comprehensive set of extensions to support minimal to complex applications (Laravel, WordPress, Symfony, etc.).

### Generic / Core
- **Core**: 8.4.2
- **Date/Time**: Support enabled (Timelib 2022.12)
- **Filter**: Input validation
- **Hash**: Support for all major hashing engines (sha256, sha512, bcrypt, argon2, etc.)
- **JSON**: Native support
- **OpenSSL**: 3.6.0
- **PCRE**: Perl Compatible Regular Expressions
- **Random**: PHP 8.4 Random extension
- **Reflection**: Full support
- **Session**: Native session support (Files, Redis, Memcached)
- **SPL**: Standard PHP Library
- **Standard**: Standard library functions
- **Tokenizer**: PHP tokenizer
- **ZLib**: Compression support

### Web & Protocols
- **cURL**: 8.17.0 (with HTTP/2, HTTP/3, TLS-SRP, IPv6, AsynchDNS, etc.)
- **FTP/FTPS**: Enabled
- **Sockets**: Network socket support
- **OpenLDAP**: Client support (2.6.10)
- **SSH2**: 1.11.1 (libssh2)
- **SOAP**: Client and Server enabled

### Database Drivers
- **MySQL**: `mysqli` & `pdo_mysql` (mysqlnd 8.4.2)
- **PostgreSQL**: `pgsql` & `pdo_pgsql` (libpq 18.1)
- **SQLite**: `sqlite3` & `pdo_sqlite` (3.45.2)
- **SQL Server**: `sqlsrv` & `pdo_sqlsrv` (5.12.0)
- **Redis**: 6.3.0 (with lz4 & zstd compression)
- **Memcached**: 3.4.0 (libmemcached-awesome 1.1.4)
- **DBA**: Berkeley DB style database abstraction

### Image & Media
- **GD**: 2.1.0 compatible (FreeType, JPEG, PNG, WebP, AVIF, BMP, TGA)
- **Imagick**: 3.8.0 (ImageMagick 7.1.2-8)
- **Exif**: Metadata support
- **Fileinfo**: MIME type detection (libmagic 545)

### Encryption & Security
- **Sodium**: 1.0.20
- **GnuGMP**: 6.3.0
- **Bcrypt**: Supported
- **Argon2**: Supported

### XML & Data Formats
- **DOM**: DOM/XML support
- **SimpleXML**: XML manipulation
- **XMLReader / XMLWriter**: Stream-based XML
- **XSL**: XSLT transformation (libxslt 1.1.43)
- **YAML**: 2.3.0 (LibYAML 0.2.5)
- **Igbinary**: 3.2.16 (Binary serialization)
- **MsgPack**: Not present (based on JSON)
- **XLSWriter**: 1.5.8 (Excel export)

### Compression & Archives
- **Zip**: 1.22.4 (AES encryption support)
- **Bzip2**: Enabled
- **Phar**: PHP Archive support
- **LZ4**: 0.6.0
- **Zstd**: 0.15.2
- **XZ**: 1.1.4

### Multibyte & Internationalization
- **Intl**: ICU 77.1
- **Mbstring**: Multibyte string support
- **GetText**: Localization support
- **Iconv**: Character set conversion

### Caching & Optimization
- **Opcache**: Enabled
- **APCu**: 5.1.27

### Process Control
- **PCNTL**: Process control extensions
- **POSIX**: POSIX functions
- **Parallel**: 1.2.8 (Concurrency)
- **Shmop**: Shared memory
- **SysV**: Msg, Sem, Shm

## ⚠️ Requirements

- **Linux x86_64** (AMD64) system.
- **None** (Self-contained static binary).

## 📥 Usage

If you are on an x86_64 system, the installer will automatically detect this build in the `frankenphp/` folder and offer to use it.

```bash
# Manual usage
./frankenphp php-cli -v
```
