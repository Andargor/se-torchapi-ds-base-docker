FROM archlinux:latest
RUN \
  sed '/#\[multilib\]/{N;s/#//g}' -i /etc/pacman.conf && \
  pacman -Sy --noconfirm tar lib32-glibc wine winetricks grep awk nano sudo unzip xorg-server-xvfb x11vnc openbox && \
  useradd -m -G wheel user && \
  echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
USER user
RUN \
  WINEARCH=win64 xvfb-run -s '-screen 0 1280x720x24' -n 99 -l -- sh -c 'WINEDLLOVERRIDES="mscoree,mshtml=" wineboot -u && winetricks -q corefonts dotnet20 dotnet40 dotnet461 xna40 d3dx9 directplay'
