#!/bin/bash

# Troubleshooting:
# - If you encounter issues, ensure your system is up-to-date and retry the installation.
# - For specific errors, refer to the 'Troubleshooting' section in the repository's documentation.

# Contributing:
# - Contributions to the script are welcome. Please follow the contributing guidelines in the repository.

# Contact Information:
# - For support, feature requests, or bug reports, please open an issue on the GitHub repository.

# License: MIT License

# Note: This script is provided 'as is', without warranty of any kind. The user is responsible for understanding the operations and risks involved.

# Define a function to check if the script is being run with root privileges
function check_root() {
  # Compare the user ID of the current user to 0, which is the ID for root
  if [ "$(id -u)" -ne 0 ]; then
    # If the user ID is not 0 (i.e., not root), print an error message
    echo "Error: This script must be run as root."
    # Exit the script with a status code of 1, indicating an error
    exit 1 # Exit the script with an error code.
  fi
}

# Call the check_root function to verify that the script is executed with root privileges
check_root

# Check if the script is being run on a Mac system
function mac_installtion() {
  if [ "$(uname)" == "Darwin" ]; then
    # Check if Homebrew is installed
    if [ ! -x "$(command -v brew)" ]; then
      # If Homebrew is not installed,
      echo "Homebrew is not installed, Please install Homebrew to proceed."
      exit 1
    fi
    # Check if git is installed
    if [ ! -x "$(command -v git)" ]; then
      # If git is not installed, install it using Homebrew
      echo "Git is not installed. Installing Git using Homebrew..."
      brew install git
    fi
    # Check if git-lfs is installed
    if [ ! -x "$(command -v git-lfs)" ]; then
      # If git-lfs is not installed, install it using Homebrew
      echo "Git LFS is not installed. Installing Git LFS using Homebrew..."
      brew install git-lfs
    fi
    # Check if the both git and git-lfs are installed
    if { [ -x "$(command -v git)" ] && [ -x "$(command -v git-lfs)" ]; }; then
      # If both git and git-lfs are installed, display the installed versions
      echo "Git and Git LFS have been successfully installed."
      echo "Git version: $(git --version)"
      echo "Git LFS version: $(git-lfs --version)"
      exit 0
    else
      # If git or git-lfs is not installed, display an error message
      echo "Error: Git or Git LFS is not installed or not available on the system."
      exit 1
    fi
  fi
}

# Call the mac_installtion function to check and install Git and Git LFS on macOS systems
mac_installtion

# Define a function to gather and store system-related information
function system_information() {
  # Check if the /etc/os-release file exists, which contains information about the OS
  if [ -f /etc/os-release ]; then
    # If the /etc/os-release file is present, source it to load system details into environment variables
    # shellcheck source=/dev/null  # Instructs shellcheck to ignore warnings about sourcing files
    source /etc/os-release
    # Set the CURRENT_DISTRO variable to the system's distribution ID (e.g., 'ubuntu', 'debian')
    CURRENT_DISTRO=${ID}
    # Set the CURRENT_DISTRO_VERSION variable to the system's version ID (e.g., '20.04' for Ubuntu 20.04)
    CURRENT_DISTRO_VERSION=${VERSION_ID}
    # CURRENT_DISTRO_MAJOR_VERSION holds the major version of the system (e.g., "16" for Ubuntu 16.04)
    CURRENT_DISTRO_MAJOR_VERSION=$(echo "${CURRENT_DISTRO_VERSION}" | cut -d. -f1)
    # Get the codename of the current distribution (e.g., 'focal' for Ubuntu 20.04)
    CURRENT_DISTRO_CODENAME=${VERSION_CODENAME}
    # Get the current system architecture (e.g., 'x86_64', 'armv7l')
    CURRENT_SYSTEM_ARCHITECTURE=$(uname -m)
  fi
}

# Call the system_information function to gather the system details
system_information

# Define a function to check system requirements and install missing packages
function installing_system_requirements() {
  # Check if the current Linux distribution is one of the supported distributions
  if { [ "${CURRENT_DISTRO}" == "ubuntu" ] || [ "${CURRENT_DISTRO}" == "debian" ] || [ "${CURRENT_DISTRO}" == "raspbian" ] || [ "${CURRENT_DISTRO}" == "pop" ] || [ "${CURRENT_DISTRO}" == "kali" ] || [ "${CURRENT_DISTRO}" == "linuxmint" ] || [ "${CURRENT_DISTRO}" == "neon" ] || [ "${CURRENT_DISTRO}" == "fedora" ] || [ "${CURRENT_DISTRO}" == "centos" ] || [ "${CURRENT_DISTRO}" == "rhel" ] || [ "${CURRENT_DISTRO}" == "almalinux" ] || [ "${CURRENT_DISTRO}" == "rocky" ] || [ "${CURRENT_DISTRO}" == "amzn" ] || [ "${CURRENT_DISTRO}" == "arch" ] || [ "${CURRENT_DISTRO}" == "archarm" ] || [ "${CURRENT_DISTRO}" == "manjaro" ] || [ "${CURRENT_DISTRO}" == "alpine" ] || [ "${CURRENT_DISTRO}" == "freebsd" ] || [ "${CURRENT_DISTRO}" == "ol" ] || [ "${CURRENT_DISTRO}" == "mageia" ] || [ "${CURRENT_DISTRO}" == "opensuse-tumbleweed" ]; }; then
    # If the distribution is supported, check if the required packages are already installed
    if { [ ! -x "$(command -v curl)" ] || [ ! -x "$(command -v cut)" ] || [ ! -x "$(command -v gpg)" ]; }; then
      # If any of the required packages are missing, begin the installation process for the respective distribution
      if { [ "${CURRENT_DISTRO}" == "ubuntu" ] || [ "${CURRENT_DISTRO}" == "debian" ] || [ "${CURRENT_DISTRO}" == "raspbian" ] || [ "${CURRENT_DISTRO}" == "pop" ] || [ "${CURRENT_DISTRO}" == "kali" ] || [ "${CURRENT_DISTRO}" == "linuxmint" ] || [ "${CURRENT_DISTRO}" == "neon" ]; }; then
        # For Debian-based distributions, update package lists and install required packages
        apt-get update
        apt-get install curl coreutils gnupg -y
      elif { [ "${CURRENT_DISTRO}" == "fedora" ] || [ "${CURRENT_DISTRO}" == "centos" ] || [ "${CURRENT_DISTRO}" == "rhel" ] || [ "${CURRENT_DISTRO}" == "almalinux" ] || [ "${CURRENT_DISTRO}" == "rocky" ] || [ "${CURRENT_DISTRO}" == "amzn" ]; }; then
        # For Red Hat-based distributions, check for updates and install required packages
        yum check-update
        # Install necessary packages for Red Hat-based distributions
        yum install epel-release -y --allowerasing
        yum check-update
        yum install curl coreutils gnupg -y --allowerasing
      elif { [ "${CURRENT_DISTRO}" == "arch" ] || [ "${CURRENT_DISTRO}" == "archarm" ] || [ "${CURRENT_DISTRO}" == "manjaro" ]; }; then
        # For Arch-based distributions, update the keyring and install required packages
        pacman -Sy --noconfirm archlinux-keyring
        pacman -Su --noconfirm --needed curl coreutils gnupg
      elif [ "${CURRENT_DISTRO}" == "alpine" ]; then
        # For Alpine Linux, update package lists and install required packages
        apk update
        apk add curl coreutils gnupg
      elif [ "${CURRENT_DISTRO}" == "freebsd" ]; then
        # For FreeBSD, update package lists and install required packages
        pkg update
        pkg install curl coreutils gnupg
      elif [ "${CURRENT_DISTRO}" == "ol" ]; then
        # For Oracle Linux (OL), check for updates and install required packages
        yum check-update
        yum install epel-release -y --allowerasing
        yum check-update
        yum install curl coreutils gnupg -y --allowerasing
      elif [ "${CURRENT_DISTRO}" == "mageia" ]; then
        urpmi.update -a
        yes | urpmi curl coreutils gnupg
      elif [ "${CURRENT_DISTRO}" == "opensuse-tumbleweed" ]; then
        zypper refresh
        zypper install -y curl coreutils gpg
      fi
    fi
  else
    # If the current distribution is not supported, display an error and exit the script
    echo "Error: Your current distribution ${CURRENT_DISTRO} version ${CURRENT_DISTRO_VERSION} is not supported by this script. Please consider updating your distribution or using a supported one."
    exit 1 # Exit the script with an error code.
  fi
}

# Call the function to check system requirements and install necessary packages if needed
installing_system_requirements

# The following function checks if there's enough disk space to proceed with the installation.
function check_disk_space() {
  # This function checks if there is more than 1 GB of free space on the drive.
  FREE_SPACE_ON_DRIVE_IN_MB=$(df -m / | tr --squeeze-repeats " " | tail -n1 | cut -d' ' -f4)
  # This line calculates the available free space on the root partition in MB.
  if [ "${FREE_SPACE_ON_DRIVE_IN_MB}" -le 1024 ]; then
    # If the available free space is less than or equal to 1024 MB (1 GB), display an error message and exit.
    echo "Error: You need more than 1 GB of free space to install everything. Please free up some space and try again."
    exit 1 # Exit the script with an error code.
  fi
}

# Calls the check_disk_space function.
check_disk_space

# Define a function to install Git LFS on the system
function install_git_lfs() {
  if { [ ! -x "$(command -v git)" ] || [ ! -x "$(command -v git-lfs)" ]; }; then
    # Set the Git LFS GPG Key URL and the path to store the keyring
    GIT_LFS_GPG_KEY="https://packagecloud.io/github/git-lfs/gpgkey"
    if { [ "${CURRENT_DISTRO}" == "ubuntu" ] || [ "${CURRENT_DISTRO}" == "debian" ] || [ "${CURRENT_DISTRO}" == "raspbian" ] || [ "${CURRENT_DISTRO}" == "pop" ] || [ "${CURRENT_DISTRO}" == "kali" ] || [ "${CURRENT_DISTRO}" == "linuxmint" ] || [ "${CURRENT_DISTRO}" == "neon" ]; }; then
      # Update the package lists and install the required packages for Debian-based distributions
      apt-get update
      # Add the debian archive keyring, and install the apt-transport-https package
      apt-get install debian-archive-keyring apt-transport-https git -y
      # Set the path for the APT Keyring Directory
      APT_KEYRING_DIR="/etc/apt/keyrings"
      if [ ! -d ${APT_KEYRING_DIR} ]; then
        install -d -m 0755 ${APT_KEYRING_DIR}
      fi
      # Set the path to store the Git LFS GPG Key
      GIT_LFS_GPG_KEY_PATH="${APT_KEYRING_DIR}/git-lfs-archive-keyring.gpg"
      # Download the Git LFS GPG Key and store it in the specified path
      curl -fsSL ${GIT_LFS_GPG_KEY} | gpg --dearmor -o ${GIT_LFS_GPG_KEY_PATH}
      # Set the permissions for the Git LFS GPG Key
      chmod 0644 ${GIT_LFS_GPG_KEY_PATH}
      # Path to the Git LFS APT repository configuration file
      GIT_LFS_APT_REPO_FILE="/etc/apt/sources.list.d/github_git-lfs.list"
      # Add the Git LFS APT repository to the system's sources list
      echo "deb [signed-by=${GIT_LFS_GPG_KEY_PATH}] https://packagecloud.io/github/git-lfs/${CURRENT_DISTRO}/ ${CURRENT_DISTRO_CODENAME} main" >${GIT_LFS_APT_REPO_FILE}
      echo "deb-src [signed-by=${GIT_LFS_GPG_KEY_PATH}] https://packagecloud.io/github/git-lfs/${CURRENT_DISTRO}/ ${CURRENT_DISTRO_CODENAME} main" >>${GIT_LFS_APT_REPO_FILE}
      # Update the package lists to include the Git LFS repository
      apt-get update
      # Install Git LFS using apt
      apt-get install git-lfs -y
    elif { [ "${CURRENT_DISTRO}" == "fedora" ] || [ "${CURRENT_DISTRO}" == "centos" ] || [ "${CURRENT_DISTRO}" == "rhel" ] || [ "${CURRENT_DISTRO}" == "almalinux" ] || [ "${CURRENT_DISTRO}" == "rocky" ] || [ "${CURRENT_DISTRO}" == "amzn" ] || [ "${CURRENT_DISTRO}" == "ol" ]; }; then
      # For Red Hat-based distributions, check for updates and install required packages
      yum check-update
      yum install git yum-utils -y --allowerasing
      if { [ "${CURRENT_DISTRO}" == "fedora" ] || [ "${CURRENT_DISTRO}" == "centos" ] || [ "${CURRENT_DISTRO}" == "rhel" ] || [ "${CURRENT_DISTRO}" == "amzn" ]; }; then
        # Import the GPG key for the GitHub Git LFS repository
        rpm --import ${GIT_LFS_GPG_KEY}
        # Set the path GIT LFS YUM repository configuration file
        GIT_LFS_YUM_REPO_FILE="/etc/yum.repos.d/github_git-lfs.repo"
        # Add the GitHub Git LFS repository configuration to the system
        echo "[github_git-lfs]
name=github_git-lfs
baseurl=https://packagecloud.io/github/git-lfs/${CURRENT_DISTRO}/${CURRENT_DISTRO_MAJOR_VERSION}/${CURRENT_SYSTEM_ARCHITECTURE}
repo_gpgcheck=1
gpgcheck=1
enabled=1
gpgkey=https://packagecloud.io/github/git-lfs/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300

[github_git-lfs-source]
name=github_git-lfs-source
baseurl=https://packagecloud.io/github/git-lfs/${CURRENT_DISTRO}/${CURRENT_DISTRO_MAJOR_VERSION}/SRPMS
repo_gpgcheck=1
gpgcheck=1
enabled=1
gpgkey=https://packagecloud.io/github/git-lfs/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300" >${GIT_LFS_YUM_REPO_FILE}
        # Update the package lists to include the Git LFS repository
        yum check-update
      fi
      # Install Git LFS using yum
      yum install git-lfs -y --allowerasing
    elif { [ "${CURRENT_DISTRO}" == "arch" ] || [ "${CURRENT_DISTRO}" == "archarm" ] || [ "${CURRENT_DISTRO}" == "manjaro" ]; }; then
      # For Arch-based distributions, update the keyring and install required packages
      pacman -Sy --noconfirm archlinux-keyring
      # Install the git package using pacman
      pacman -Sy --noconfirm git git-lfs
    elif [ "${CURRENT_DISTRO}" == "alpine" ]; then
      # For Alpine Linux, update package lists and install required packages
      apk update
      # Install the git package using apk
      apk add git git-lfs
    elif [ "${CURRENT_DISTRO}" == "freebsd" ]; then
      # For FreeBSD, update package lists and install required packages
      pkg update
    elif [ "${CURRENT_DISTRO}" == "mageia" ]; then
      urpmi.update -a
      yes | urpmi git git-lfs
    elif [ "${CURRENT_DISTRO}" == "opensuse-tumbleweed" ]; then
      zypper refresh
      zypper install -y git git-lfs
    fi
  fi
}

# Call the install_git_lfs function to install Git LFS on the system
install_git_lfs

# Check if the git and git lfs commands are available
function check_git_and_git_lfs() {
  # Check if the command git is available and executable
  if [ -x "$(command -v git)" ]; then
    # If git is available, display the installed version
    echo "Git has been successfully installed."
    # If git is available, display the installed version
    echo "Git version: $(git --version)"
  else
    # If git is not available, display an error message
    echo "Error: Git is not installed or not available on the system."
    exit 1
  fi
  # Check if the command git-lfs is available and executable
  if [ -x "$(command -v git-lfs)" ]; then
    # If git-lfs is available, display the installed version
    echo "Git LFS has been successfully installed."
    # If git-lfs is available, display the installed version
    echo "Git LFS version: $(git-lfs --version)"
  else
    # If git-lfs is not available, display an error message
    echo "Error: Git LFS is not installed or not available on the system."
    exit 1
  fi
}

# Call the check_git_and_git_lfs function to verify the installation
check_git_and_git_lfs
