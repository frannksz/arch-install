#!/usr/bin/env bash

# ============================================================================
# Arch Linux Installation Script
# Franklin Souza - @frannksz
# ============================================================================

set -euo pipefail

# === VARIÁVEIS ===
DISCO="/dev/sda"
BOOT="${DISCO}1"
SWAP="${DISCO}2"
ROOT="${DISCO}3"
MNT="/mnt"

# === CORES ===
RED="\e[31m"
GREEN="\e[32m"
CYAN="\e[36m"
RESET="\e[0m"

msg() {
  echo -e "${CYAN}[!]${RESET} $1"
}

erro() {
  echo -e "${RED}[ERRO]${RESET} $1" >&2
  exit 1
}

keyboard() {
  clear
  msg "Configurando layout do teclado (br-abnt2)"
  loadkeys br-abnt2 || erro "Falha ao carregar layout de teclado"
}

format_disk() {
  clear
  msg "Formatando os discos"
  sleep 1
  mkfs.vfat -F32 "$BOOT"
  mkswap "$SWAP"
  swapon "$SWAP"
  mkfs.btrfs -f "$ROOT"
}

subvolumes() {
  clear
  msg "Criando subvolumes Btrfs"
  sleep 1
  mount "$ROOT" "$MNT"
  for vol in @ @home @snapshots; do
    btrfs su cr "$MNT/$vol"
  done
  umount "$MNT"
}

mount_partitions() {
  clear
  msg "Montando as partições"
  sleep 1
  mount -o defaults,noatime,compress-force=zstd:3,autodefrag,subvol=@ "$ROOT" "$MNT"
  mkdir -p "$MNT"/{boot/efi,home,.snapshots}
  mount -o defaults,noatime,compress-force=zstd:3,autodefrag,subvol=@home "$ROOT" "$MNT/home"
  mount -o defaults,noatime,compress-force=zstd:3,autodefrag,subvol=@snapshots "$ROOT" "$MNT/.snapshots"
  mount "$BOOT" "$MNT/boot/efi"
}

pacstrap_arch() {
  clear
  msg "Instalando pacotes base do Arch Linux"
  sleep 1
  pacman -Sy --noconfirm archlinux-keyring
  pacstrap "$MNT" base base-devel linux-firmware dhcpcd neovim wget
}

fstab_gen() {
  clear
  msg "Gerando fstab"
  sleep 1
  genfstab -U "$MNT" >> "$MNT/etc/fstab"
}

arch_chroot_enter() {
  clear
  msg "Instalação básica concluída!"
  echo -e "${GREEN}Digite: arch-chroot /mnt${RESET} para continuar a instalação."
}

# === EXECUÇÃO ===
keyboard
format_disk
subvolumes
mount_partitions
pacstrap_arch
fstab_gen
arch_chroot_enter
