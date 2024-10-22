# Arch Linux Install Shell Script

Esse é um script de instalação do Arch Linux.

### Antes de usar:

- TOTALMENTE RECOMENDADO LER a [wiki](https://wiki.archlinux.org/title/Installation_guide)
- Essa é uma configuração MINHA, então pode não ser boa para você.
- LEIA o script antes de executa-lo.
- NÃO me responsabilizo por danos.
- Fique a vontade para editar o script ao seu gosto/uso.

### Configuração:

Uso UEFI/EFI e [BTRFS](https://btrfs.readthedocs.io/en/latest/) como filesystem com snapshots, você pode não gostar dessa configuração, então recomendo a edição do script.

### Download/Execução:

- ATENÇÃO - LEIA O SCRIPT ANTES DE EXECUTA-LO.

- Esse script roda fora do chroot, assim que bootar a archiso execute esses comandos:

  ```sh
  loadkeys br-abnt2
  curl https://raw.githubusercontent.com/frannks/arch-install/main/arch-install.sh |bash
  ```

  

### Contatos:

[Email](mailto:fraank@riseup.net)
