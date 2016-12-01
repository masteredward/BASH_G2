#!/bin/bash

# Este script sincroniza arquivos ou diretórios recursivamente com o rsync ou os sobreescreve com o scp Configurações Padrão (Altere conforme necessidade!)
std_tool=rsync # Ferramenta Padrão
ssh_port=22 # Porta SSH Padrão
ssh_user=root # Usuário Padrão
local_path=~ # Caminho Local Padrão
remote_path=~ # Caminho Remoto Padrão
remote_host=localhost # Host Remoto Padrão

# Função do Cabeçalho do Menu
function fn_header {
	clear
	echo "Script Assistente de Cópia por RSYNC/SCP - Versão 0.1 - Para Fedora/RHEL/CentOS"
	echo "Autor: Eduardo Medeiros Silva"
	echo "http://www.profedumedeiros.net"
	echo
}

# Função de Seleção da Ferramenta
function fn_sel_tool {
	clear
	echo "Escolha a ferramenta:"
	echo "1- rsync (Sincroniza)"
	echo "2- scp (Sobrescreve)"
	echo
	echo -n "Digite a opção desejada: "
	read opt_tool
	if test $opt_tool -eq 1
	then
		std_tool=rsync
	elif test $opt_tool -eq 2
	then
		std_tool=scp
	else
		fn_sel_tool
	fi
	unset opt_tool
}

# Função de Seleção da Porta SSH
function fn_change_port {
	clear
	echo "Digite a porta SSH do servidor remoto:"
	echo "Padrão 22"
	echo "Atual $ssh_port"
	echo
	echo -n "Digite a porta desejada: "
	read ssh_port
}

# Função de Seleção de Host Remoto
function fn_change_host {
	clear
	echo "Digite o endereço do servidor remoto: (Padrão localhost, Atual $remote_host)"
	echo
	echo -n "Digite o IPv4, IPv6 ou Hostname do host remoto: "
	read remote_host
}



# Função de Exibição do Menu
function fn_show_menu {
	fn_header
	echo
	echo "-- Menu de Cópia --"
	PS3='Escolha uma das opções: '
	options=("Selecionar a ferramenta ($std_tool)" "Selecionar a porta destino SSH ($ssh_port)" "Selecionar o endereço do computador remoto ($remote_host)" "Selecionar o usuário do computador remoto ($ssh_user)" "Caminho absoluto de origem ($local_path)" "Caminho absoluto de destino ($remote_path)" "Efetuar a cópia!")
	select opt in "${options[@]}"
	do
		case $opt in
			"Selecionar a ferramenta ($std_tool)")
				fn_sel_tool
				fn_show_menu
				;;
			"Selecionar a porta destino SSH ($ssh_port)")
				fn_change_port
				fn_show_menu
				;;
			"Selecionar o endereço do computador remoto ($remote_host)")
				fn_change_host
				fn_show_menu
				;;
			"Selecionar o usuário do computador remoto ($ssh_user)")
				fn_show_menu
				;;
			"Caminho absoluto de origem ($local_path)")
				fn_show_menu
				;;
			"Caminho absoluto de destino ($remote_path)")
				fn_show_menu
				;;
			"Efetuar a cópia!")
				exit
				;;
			*) echo "Opção Inválida";;
		esac
	done
}
fn_show_menu
