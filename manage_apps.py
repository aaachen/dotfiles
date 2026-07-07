#!/usr/bin/env python3
import json
import subprocess
import sys
import os

def get_distro_info():
    info = {"id": "unknown", "like": []}
    try:
        if os.path.exists("/etc/os-release"):
            with open("/etc/os-release") as f:
                for line in f:
                    if "=" in line:
                        k, v = line.split("=", 1)
                        v = v.strip().strip('"')
                        if k == "ID":
                            info["id"] = v.lower()
                        elif k == "ID_LIKE":
                            info["like"] = [x.lower() for x in v.split()]
    except Exception:
        pass
    return info

def run_command(command, use_sudo=False):
    if use_sudo and os.getuid() != 0:
        command = ["sudo"] + command
    print(f"--> Running: {' '.join(command)}")
    try:
        result = subprocess.run(command)
        if result.returncode != 0:
            print(f"Warning: Command failed with exit code {result.returncode}")
    except Exception as e:
        print(f"Error executing command: {e}")

def install_pm_packages(distro_info, packages_data):
    pm_data = packages_data.get("pm", {})
    
    # Collect packages from common, ID, and ID_LIKE
    keys_to_check = ["common", distro_info["id"]] + distro_info["like"]
    
    all_packages = []
    for key in keys_to_check:
        all_packages.extend(pm_data.get(key, []))
    
    # Deduplicate while preserving order
    all_packages = list(dict.fromkeys([p for p in all_packages if p]))
    
    if not all_packages:
        return

    print(f"Installing system packages for {distro_info['id']} (family: {', '.join(distro_info['like'])})...")
    
    # Determine which package manager to use
    family = ([distro_info["id"]] + distro_info["like"])
    
    if any(x in family for x in ["arch", "endeavouros", "manjaro"]):
        if subprocess.run(["which", "yay"], capture_output=True).returncode == 0:
            run_command(["yay", "-S", "--needed", "--noconfirm"] + all_packages)
        else:
            run_command(["pacman", "-S", "--needed", "--noconfirm"] + all_packages, use_sudo=True)
    
    elif any(x in family for x in ["debian", "ubuntu", "pop", "linuxmint"]):
        run_command(["apt-get", "update"], use_sudo=True)
        run_command(["apt-get", "install", "-y"] + all_packages, use_sudo=True)
    
    elif "fedora" in family:
        run_command(["dnf", "install", "-y"] + all_packages, use_sudo=True)
    
    else:
        print(f"Skipping native packages: Distro family not explicitly supported.")

def install_flatpak_packages(packages_data):
    flatpaks = packages_data.get("flatpak", [])
    if not flatpaks:
        return
    
    if subprocess.run(["which", "flatpak"], capture_output=True).returncode == 0:
        print("Installing flatpak packages...")
        # Try to add flathub just in case
        subprocess.run(["flatpak", "remote-add", "--if-not-exists", "flathub", "https://flathub.org/repo/flathub.flatpakrepo"], capture_output=True)
        run_command(["flatpak", "install", "-y", "flathub"] + flatpaks)
    else:
        print("flatpak not found. Skipping.")

def install_snap_packages(packages_data):
    snaps = packages_data.get("snap", [])
    if not snaps:
        return
    
    if subprocess.run(["which", "snap"], capture_output=True).returncode == 0:
        print("Installing snap packages...")
        for snap in snaps:
            run_command(["snap", "install", snap], use_sudo=True)
    else:
        print("snap not found. Skipping.")

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    json_path = os.path.join(script_dir, "apps.json")

    if not os.path.exists(json_path):
        print(f"apps.json not found at {json_path}")
        return

    try:
        with open(json_path, "r") as f:
            packages_data = json.load(f)
    except Exception as e:
        print(f"Error parsing apps.json: {e}")
        return

    distro_info = get_distro_info()
    print(f"Detected OS: {distro_info['id']} (family: {', '.join(distro_info['like'])})")

    install_pm_packages(distro_info, packages_data)
    install_flatpak_packages(packages_data)
    install_snap_packages(packages_data)

if __name__ == "__main__":
    main()
