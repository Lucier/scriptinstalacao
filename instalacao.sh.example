#!/usr/bin/env bash

#------------------Variaveis------------------#
DIRETORIO_DOWNLOADS="$HOME/Downloads/Programas"

URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_VSCODE="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
URL_INSOMNIA="https://updates.insomnia.rest/downloads/ubuntu/latest?&app=com.insomnia.app&source=website"
URL_STARUML="https://staruml.io/download/releases-v4/StarUML_4.1.6_amd64.deb"
URL_ONLYOFFICE="https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb?_ga=2.157166136.2022471375.1643256358-778961413.1639538450"

PROGRAMAS_PARA_INSTALAR=(
  curl
  wget
  apt-transport-https
  git
  vlc
  gnome-tweaks
  openjdk-18-jdk
  openjdk-18-jre
  python3
  python-pip
  docker.io
  build-essential
  libssl-dev
  gnome-boxes
  synaptic
)

#------------------Resolvendo possiveis dependencias quebadas------------------#
sudo apt check
sudo apt install -f -y

#------------------Instalar programas do APT------------------#
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

## Removendo travas eventuais do apt ##
echo Removendo eventuais travas criadas pelo APT
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock
echo Remocao realizda com sucesso

## Adicionando/Confirmando arquitetura de 32 bits ##
echo Adicionando/Confirmando suporte para arquitetura de 32 bits
sudo dpkg --add-architecture i386
echo Adicao/Confirmacao realizada com sucesso

## Atualizando os repositorios ##
echo Atualizando repositorios
sudo apt update
sudo apt full-upgrade
sudo apt dist-upgrade
echo Repositorios atualizados com sucesso

#---------------------Instalacao de programas utilitarios------------------#
echo Instalando programas utilitarios
sudo apt install ubuntu-restricted-extras -y

#-------------------Instalando programas com adicao de PPA------------------#
echo Instalando brave-browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-
browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] 
https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee 
/etc/apt/sources.list.d/brave-browser-release.list

sudo apt update && sudo apt install brave-browser -y

echo Instalando beekeeper
wget --quiet -O - https://deb.beekeeperstudio.io/beekeeper.key | sudo apt-key add -
echo "deb https://deb.beekeeperstudio.io stable main" | sudo tee /etc/apt/sources.list.d/beekeeper-studio-app.list

sudo apt update && sudo apt install beekeeper-studio -y

echo Instalando docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

echo Instalando Spotify
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update && sudo apt install spotify-client -y

echo Programas com adicao de PPA instalados com sucesso

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | zsh

#------------------Instalacao de programas com downloads externos------------------#
mkdir "$DIRETORIO_DOWNLOADS"

wget -c "$URL_GOOGLE_CHROME"  -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_VSCODE"         -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_INSOMNIA"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_STARUML"        -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_ONLYOFFICE"     -P "$DIRETORIO_DOWNLOADS"

#------------------Instalando pacotes .deb baixados--------------------#
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

#------------------Pos instalacao------------------#
echo Finalizacao, atualizacoes e limpeza
sudo apt update
sudo apt full-upgrade
sudo apt dist-upgrade
sudo apt autoclean
sudo apt autoremove -y