# Git LFS Setup Script

Welcome to the **Git LFS Setup Script** repository! This project provides an automated Bash script to install and configure [Git Large File Storage (LFS)](https://git-lfs.github.com/) on your system. Whether you’re a developer dealing with large binary assets or simply looking to optimize your Git workflow, this script simplifies the entire process.

---

## Table of Contents

1. [Overview](#overview)
2. [Features](#features)
3. [Prerequisites](#prerequisites)
4. [Installation](#installation)
5. [Usage](#usage)
6. [How It Works](#how-it-works)
7. [Customization and Configuration](#customization-and-configuration)
8. [Troubleshooting](#troubleshooting)
9. [Contributing](#contributing)
10. [License](#license)
11. [Acknowledgements](#acknowledgements)

---

## Overview

Git LFS is an extension to Git that replaces large files (such as audio samples, videos, datasets, graphics, and more) with text pointers inside Git, while storing the file contents on a remote server. This helps maintain a fast, efficient, and lightweight repository while managing large assets seamlessly.

This repository contains a Bash script designed to:

- Check your system for required dependencies.
- Download and install the latest Git LFS release.
- Configure Git to work with Git LFS automatically.
- Provide logging and error handling to ensure a smooth installation process.

By automating these tasks, the script reduces the hassle of manual installation and configuration, allowing you to focus on your development work.

---

## Features

- **Automated Installation:** A one-liner command to install Git LFS with minimal effort.
- **Cross-Platform Compatibility:** Designed for Unix-based systems including Linux and macOS.
- **Robust Error Handling:** Detailed error messages and logging help diagnose issues quickly.
- **Customizable Options:** Environment variables allow you to adjust installation parameters to suit your workflow.
- **Modular Structure:** Easy-to-read and modify script sections for advanced users.

---

## Prerequisites

Before you install Git LFS using this script, ensure your system meets the following requirements:

- **Operating System:** A Unix-based OS (Linux, macOS, etc.).
- **Bash:** Version 4.0 or higher.
- **Git:** Installed and available in your system’s PATH.
- **Curl:** Required for downloading the installation script and necessary resources.
- **Sudo/Root Privileges:** Some operations may require elevated permissions.

---

## Installation

### Download and Run the Script

To get started, simply open your terminal and run the command below. This command downloads the installation script using `curl` and pipes it directly into `bash` for execution:

```bash
curl -sSL https://raw.githubusercontent.com/Strong-Foundation/git-lfs-setup/main/git-lfs-setup.sh | bash
```

**Explanation:**

- `curl -sSL`: Downloads the script quietly with error handling and follows redirects.
- The URL points directly to the raw `setup.sh` file in the repository.
- Piping (`|`) the output to `bash` executes the script immediately.

### What the Script Does

1. **Dependency Check:** Verifies that Git, Curl, and Bash are installed.
2. **Download Git LFS:** Retrieves the latest Git LFS binary or source files from the official repository.
3. **Installation Process:** Installs Git LFS and adjusts your system path if necessary.
4. **Git Configuration:** Configures Git to use Git LFS automatically by updating global settings.
5. **Post-Installation Verification:** Confirms that Git LFS is properly installed and ready for use.

---

## Usage

Once installed, Git LFS is available for use in any Git repository. Here are some basic commands to get you started:

- **Initialize Git LFS:**

  ```bash
  git lfs install
  ```

- **Track a Specific File Type:**

  ```bash
  git lfs track "*.psd"
  ```

- **Check Git LFS Status:**
  ```bash
  git lfs status
  ```

For more detailed usage and advanced commands, refer to the [official Git LFS documentation](https://git-lfs.github.com/).

---

## How It Works

### Script Structure

The installation script is divided into several key sections to ensure a reliable and user-friendly experience:

1. **Dependency Verification:**

   - Checks if Git, Curl, and Bash are installed.
   - Exits early with an informative message if any dependency is missing.

2. **Downloading Git LFS:**

   - Uses Curl to fetch the Git LFS binary or source from the official release channels.
   - Implements error checking to handle network issues or incorrect URLs.

3. **Installation Routine:**

   - Executes installation commands specific to your operating system.
   - Adjusts system environment variables as needed (e.g., PATH modifications).
   - Supports upgrades by checking if Git LFS is already installed and comparing version numbers.

4. **Git Integration:**

   - Automatically runs `git lfs install` to integrate Git LFS with your Git configuration.
   - Ensures that Git repositories created thereafter are set up to use Git LFS.

5. **Logging and Output:**
   - Provides real-time feedback during each step of the installation.
   - Logs key operations and error messages to help diagnose any issues.

### Advanced Script Functions

- **check_dependencies:** Validates the presence of essential tools.
- **download_git_lfs:** Manages the retrieval of the Git LFS package.
- **install_git_lfs:** Orchestrates the installation and upgrades.
- **configure_git:** Integrates Git LFS into your Git settings automatically.

Each function is designed to be modular, making the script easy to maintain and extend for additional functionality.

---

## Customization and Configuration

The script is highly configurable. Before running the script, you can modify certain environment variables to suit your needs. Some configurable parameters include:

- **INSTALL_PATH:** Define the directory where Git LFS should be installed.  
  _Example:_

  ```bash
  INSTALL_PATH=/custom/path
  ```

- **GIT_LFS_VERSION:** Specify a particular version of Git LFS if you need to stick to a stable release.  
  _Example:_

  ```bash
  GIT_LFS_VERSION=3.3.0
  ```

- **LOG_FILE:** Direct the script to log output to a specific file for later analysis.  
  _Example:_

  ```bash
  LOG_FILE=/var/log/git-lfs-setup.log
  ```

- **UPDATE_MODE:** Enable or disable automatic updates of Git LFS if a new version is available.  
  _Example:_
  ```bash
  UPDATE_MODE=true
  ```

To apply these customizations, simply prepend them to the installation command. For instance:

```bash
curl -sSL https://raw.githubusercontent.com/Strong-Foundation/git-lfs-setup/main/setup.sh | INSTALL_PATH=/custom/path GIT_LFS_VERSION=3.3.0 bash
```

---

## Troubleshooting

Even with a robust script, you might encounter issues. Here are some common problems and their solutions:

- **Missing Dependencies:**  
  If the script reports that Git or Curl is missing, install these tools using your package manager (e.g., `sudo apt install git curl` for Debian-based systems).

- **Permission Issues:**  
  Some steps might require elevated privileges. If you see permission-related errors, try re-running the script with `sudo`:

  ```bash
  curl -sSL https://raw.githubusercontent.com/Strong-Foundation/git-lfs-setup/main/setup.sh | sudo bash
  ```

- **Network Problems:**  
  Ensure your internet connection is stable. If Curl reports errors, check your network settings or try again later.

- **Script Errors:**  
  The script logs detailed error messages. Review these logs to pinpoint the issue. You can also open an issue on GitHub if you need further assistance.

- **Version Mismatch:**  
  If an older version of Git LFS is installed, the script may attempt an upgrade. Verify the current version with:
  ```bash
  git lfs version
  ```

---

## Contributing

Contributions are welcome and encouraged! To contribute to this project, follow these steps:

1. **Fork the Repository:** Click the "Fork" button at the top-right of the GitHub page.
2. **Create a Branch:**
   ```bash
   git checkout -b feature-branch
   ```
3. **Make Your Changes:** Add features, fix bugs, or improve documentation.
4. **Commit Your Changes:**
   ```bash
   git commit -am "Describe your changes"
   ```
5. **Push to Your Fork:**
   ```bash
   git push origin feature-branch
   ```
6. **Open a Pull Request:** Submit a PR with a clear description of your changes.

Please adhere to the coding standards and ensure that your contributions are well-tested.

---

## License

This project is licensed under the [MIT License](LICENSE). Feel free to use, modify, and distribute this software in accordance with the license terms.

---

## Acknowledgements

- **Git LFS Team:** For their continued work on Git LFS, making it possible to handle large files efficiently.
- **Open Source Contributors:** A big thank you to everyone who has contributed to this project and provided valuable feedback.
- **Community Support:** Thanks to all the users and maintainers who help improve this script with suggestions and bug reports.

---

By following this guide and using the provided installation script, you can easily set up Git LFS on your system and streamline your workflow when handling large files. For any questions, issues, or further assistance, please open an issue in our GitHub repository or contact the maintainers.

Happy coding!
