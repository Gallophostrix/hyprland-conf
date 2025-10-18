{ pkgs, ... }:
pkgs.writeShellScriptBin "ex" ''
  #!/usr/bin/env bash
  set -euo pipefail

  if [ $# -eq 0 ]; then
    echo "Usage: ex <file>...  (pwd-protected: EX_PASSWORD=secret ex file.rar)"
    exit 1
  fi

  for n in "$@"; do
    if [ ! -f "$n" ]; then
      echo "'$n' - file does not exist"
      exit 1
    fi

    case "${n%,}" in
      *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
        "${pkgs.gnutar}/bin/tar" xvf "$n" ;;
      *.tar.zst)
        "${pkgs.gnutar}/bin/tar" --zstd -xvf "$n" ;;
      *.lzma)
        "${pkgs.xz}/bin/unlzma" "$n" ;;
      *.bz2)
        "${pkgs.bzip2}/bin/bunzip2" "$n" ;;
      *.cbr|*.rar)
        if [ -n "${EX_PASSWORD-}" ]; then
          "${pkgs.unrar}/bin/unrar" x -ad -p"$EX_PASSWORD" "$n"
        else
          "${pkgs.unrar}/bin/unrar" x -ad "$n"
        fi ;;
      *.gz)
        "${pkgs.gzip}/bin/gunzip" "$n" ;;
      *.cbz|*.epub|*.zip)
        if [ -n "${EX_PASSWORD-}" ]; then
          "${pkgs.unzip}/bin/unzip" -P "$EX_PASSWORD" "$n"
        else
          "${pkgs.unzip}/bin/unzip" "$n"
        fi ;;
      *.z)
        "${pkgs.ncompress}/bin/uncompress" "$n" ;;
      *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
        if [ -n "${EX_PASSWORD-}" ]; then
          "${pkgs.p7zip}/bin/7z" x -p"$EX_PASSWORD" "$n"
        else
          "${pkgs.p7zip}/bin/7z" x "$n"
        fi ;;
      *.xz)
        "${pkgs.xz}/bin/unxz" "$n" ;;
      *.zst)
        "${pkgs.zstd}/bin/unzstd" "$n" ;;
      *.exe)
        "${pkgs.cabextract}/bin/cabextract" "$n" || true ;;
      *.cpio)
        "${pkgs.cpio}/bin/cpio" -id < "$n" ;;
      *.cba|*.ace)
            "${pkgs.unace}/bin/unace" x "$n" ;;
      *)
        echo "Unsupported format: $n"
        exit 1 ;;
    esac
  done
''
