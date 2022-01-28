#!/usr/bin/env bash

## Atualizando repositorios ##
echo Atualizando repósitorios
sudo apt update

## Removendo possiveis travas criadas pelo APT ##
echo Removendo possíveis travas criadas pelo APT
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Atualizando pacotes e repositorios ##
echo Atualizando pacotes e repositórios
sudo apt update
sudo apt full-upgrade
sudo apt dist-upgrade

## Checando pacotes quebrados ##
echo Checando pacotes quebrados
sudo apt check
sudo apt install -f -y

## Adicionando arquitetura de 32 bits ##
echo Adicionando suporte para arquitetura de 32 bits
sudo dpkg --add-architecture i386

## Instalando codecs de audio ##
echo Instalando codecs de áudio
sudo apt install ubuntu-restricted-extras -y

## instalando git, curl, wget ##
echo Instalando git, curl e wget
sudo apt install git curl wget -y

## Instalando JVM ##
echo Instalando JVM
sudo apt install openjdk-18-jre -y
sudo apt install openjdk-18-jdk -y

## Instalando Python ##
echo Instalando python3
sudo apt install python3 -y
sudo apt install python-pip -y

## Instalando compilado gcc ##
echo Instalando compilador gcc
sudo apt install build-essential -y
sudo apt install libssl-dev -y

## Instalando navegadores Brave, Google chrome ##
echo Instalando navegadores Brave e Google chrome
sudo apt-get install -y libxss1 libappindicator1 libindicator7 -y

sudo apt install apt-transport-https curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
if ! sudo apt install brave-browser -y
then
exit 1
fi

sudo apt install -f -y
sudo apt update && sudo apt install brave-browser -y


cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
if ! sudo dpkg -i google-chrome*.deb
then
exit 1
fi

sudo apt install -f -y
sudo dpkg -i google-chrome*.deb
cd ~

## Instalando softwares de midia
echo Instalando softwares de mídia
sudo apt install vlc -y

curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
if ! sudo apt-get install spotify-client -y
then
exit 1
fi

sudo apt install -f -y
sudo apt-get install spotify-client -y

## Instalando onlyoffice ##
echo Instalando onlyoffice
cd ~/Downloads
wget https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb?_ga=2.164133692.2050226020.1643394064-778961413.1639538450
if ! sudo dpkg -i onlyoffice-desktopeditors*.deb
then
exit 1
fi

sudo apt install -f -y
sudo dpkg -i onlyoffice-desktopeditors*.deb
cd ~

## Instalando utilitarios do sistema ##
echo Instalando utilitários do sistema
sudo apt install synaptic -y
sudo apt install gnome-tweaks -y
sudo apt install gnome-boxes -y

## Configurando ambiente de desenvolvimento ##
echo Configurando ambiente de desenvolvimento
sudo apt update
sudo apt remove docker docker-engine docker.io -y
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
docker version

sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
if ! docker-compose --version
then
exit 1
fi

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version

cd ~/Downloads
wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
if ! sudo dpkg -i code*.deb
then
exit 1
fi

sudo apt install -f -y
sudo dpkg -i code*.deb

cd ~

wget --quiet -O - https://deb.beekeeperstudio.io/beekeeper.key | sudo apt-key add -
echo "deb https://deb.beekeeperstudio.io stable main" | sudo tee /etc/apt/sources.list.d/beekeeper-studio-app.list
sudo apt update
if ! sudo apt install beekeeper-studio
then
exit 1
fi

sudo apt install -f -y
sudo apt install beekeeper-studio

cd ~/Downloads
wget https://updates.insomnia.rest/downloads/ubuntu/latest?&app=com.insomnia.app&source=website
if sudo dpkg -i Insomnia.Core*.deb
then
exit 1
fi

sudo apt install -f -y
sudo dpkg -i Insomnia.Core*.deb

wget https://staruml.io/download/releases-v4/StarUML_4.1.6_amd64.deb
if ! sudo dpkg -i StarUML*.deb
then
exit 1
fi

sudo apt install -f -y
sudo dpkg -i StarUML*.deb

cd ~

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

source ~/.zshrc
nvm -v

nvm install --lts

node --version
npm --version

npm install --global --no-install-recommends yarn
yarn --version

npm install -g create-react-app
npm install -g react-native-cli
