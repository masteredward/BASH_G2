#!/bin/bash

# Este script sincroniza arquivos ou diretórios recursivamente com o rsync ou os sobreescreve com o scp

### Configuração Inicial (Altere conforme necessidade!) ###
cp_mode=upload # Modo de operação. upload = Host Local -> Host Remoto, download = Host Remoto -> Host Local
cp_tool=rsync # Ferramenta
ssh_port=22 # Porta SSH do Host Remoto
ssh_user=root # Usuário do Host Remoto
src_path=~ # Caminho Absoluto Local
dest_path=~ # Caminho Absoluto Remoto
remote_host=localhost # Host Remoto Padrão

# Função do Cabeçalho do Menu
function fn_header {
	clear
	echo "Script Assistente de Cópia por RSYNC/SCP - Versão 0.2 - Para Fedora/RHEL/CentOS"
	echo "Autor: Eduardo Medeiros Silva"
	echo "http://www.profedumedeiros.net"
	echo
}

# Função de Seleção do Modo de Operação
function fn_change_mode {
	clear
	echo "Escolha a modo de operação:"
	echo
	echo "1- upload (Host Local -> Host Remoto)"
	echo "2- download (Host Remoto -> Host Local)"
	echo
	echo
	echo -n "Digite o número do modo desejado: "
	read opt_mode
	if test $opt_mode -eq 1
	then
		cp_mode=upload
	elif test $opt_mode -eq 2
	then
		cp_mode=download
	else
		fn_change_mode
	fi
	unset opt_mode
}

# Função de Seleção da Ferramenta
function fn_change_tool {
	clear
	echo "Escolha uma das ferramentas abaixo:"
	echo
	echo "1- rsync (Sincroniza)"
	echo "2- scp (Sobrescreve)"
	echo
	echo
	echo -n "Digite o número da ferramenta desejada: "
	read opt_tool
	if test $opt_tool -eq 1
	then
		cp_tool=rsync
	elif test $opt_tool -eq 2
	then
		cp_tool=scp
	else
		fn_change_tool
	fi
	unset opt_tool
}

# Função de Seleção da Porta SSH
function fn_change_port {
	clear
	echo "Escolha a porta SSH do host remoto:"
	echo
	echo "Atualmente: $ssh_port"
	echo
	echo
	echo -n "Digite a porta desejada: "
	read ssh_port
}

# Função de Seleção de Host Remoto
function fn_change_host {
	clear
	echo "Escolha o endereço do host remoto:"
	echo
	echo "Atualmente: $remote_host"
	echo
	echo
	echo -n "Digite o IPv4, IPv6 ou Hostname do host remoto desejado: "
	read remote_host
}

# Função de Seleção do Usuário do Host Remoto
function fn_change_user {
	clear
	echo "Escolha o nome do usuário do host remoto:"
	echo
	echo "Atualmente: $ssh_user"
	echo
	echo
	echo -n "Digite o nome do usuário do host remoto desejado: "
	read ssh_user
}

# Função de Seleção do Caminho de Origem
function fn_change_src_path {
	clear
	echo "Escolha o caminho absoluto do arquivo ou diretório a ser copiado:"
	echo
	echo "Atualmente: $src_path"
	echo
	echo
	echo -n "Digite o caminho de origem desejado: "
	read src_path
}

# Função de Seleção do Caminho de Destino
function fn_change_src_path {
	clear
	echo "Escolha o caminho absoluto do destino da cópia:"
	echo
	echo "Atualmente: $dest_path"
	echo
	echo
	echo -n "Digite o caminho de destino desejado: "
	read dest_path
}

# Função de Exibição do Menu
function fn_show_menu {
	fn_header
	echo
	echo "-- Menu de Cópia --"
	PS3='Escolha uma das opções: '
	options=("Selecionar o modo de operação ($cp_mode)" "Selecionar a ferramenta ($cp_tool)" "Selecionar a porta destino SSH ($ssh_port)" "Selecionar o endereço do host remoto ($remote_host)" "Selecionar o usuário do host remoto ($ssh_user)" "Caminho absoluto de origem ($src_path)" "Caminho absoluto de destino ($dest_path)" "Efetuar a cópia!" "Cancelar e sair do script")
	select opt in "${options[@]}"
	do
		case $opt in
			"Selecionar o modo de operação ($cp_mode)")
				fn_change_mode
				fn_show_menu
				;;
			"Selecionar a ferramenta ($cp_tool)")
				fn_change_tool
				fn_show_menu
				;;
			"Selecionar a porta destino SSH ($ssh_port)")
				fn_change_port
				fn_show_menu
				;;
			"Selecionar o endereço do host remoto ($remote_host)")
				fn_change_host
				fn_show_menu
				;;
			"Selecionar o usuário do host remoto ($ssh_user)")
				fn_change_user
				fn_show_menu
				;;
			"Caminho absoluto de origem ($src_path)")
				fn_change_src_path
				fn_show_menu
				;;
			"Caminho absoluto de destino ($dest_path)")
				fn_change_dest_path
				fn_show_menu
				;;
			"Efetuar a cópia!")
				clear
				exit
				;;
			"Cancelar e sair do script")
				clear
				echo "Script encerrado!"
				exit
				;;
			*) echo "Opção Inválida";;
		esac
	done
}
fn_show_menu
