#!/bin/sh
#
# Script de démarrage qui lance l'interface réseau internet,
# met en place un firewall basique et un partage de connexion
#
#

# interface
INTERFACE=eth0

#Protocole SSH Autorisée
SSH="yes"

#Protocole ICMP (i.e. le "ping")
ICMP="yes"

#Protocole FTP (pour le multicast)
FTP="yes"

#LOG dans dmesg
LOG="yes"

#Protocole DNS
DNS="yes"

#Protocole DHCP
DHCP="yes"

#Protocole NTP
NTP="yes"

#Protocole HTTP
HTTP="yes"

#Protocole NetBios-NS
NETBIOS_NS="yes"

#Protocole NetBios-DGM => exploration du réseau (basé sur SMB browser service)
NETBIOS_DGM="yes"

## On drop les scans XMAS et NULL.
XMAS="yes"

########################################################################################




start() {

	# Vider les tables actuelles
	iptables -t filter -F

	# Vider les règles personnelles
	iptables -t filter -X

	# On créé une règle pour loger
	if [ $LOG = "yes" ]
	then
		echo "LOG actif"	
		iptables -N LOG_DROP
		iptables -A LOG_DROP -j LOG --log-prefix '[IPTABLES DROP] : '
		iptables -A LOG_DROP -j DROP
	fi

	# Interdire toute connexion entrante et sortante
	iptables -t filter -P INPUT DROP
	iptables -t filter -P FORWARD DROP
	iptables -t filter -P OUTPUT DROP

	# ---
        ## On drop les scans XMAS et NULL.
	if [ $XMAS = "yes" ]
	then
		iptables -t filter -A INPUT -p tcp --tcp-flags FIN,URG,PSH FIN,URG,PSH -j DROP
		iptables -t filter -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
		iptables -t filter -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
		iptables -t filter -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
	fi

	# Ne pas casser les connexions etablies
	iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
	iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

	# Autoriser loopback
	iptables -t filter -A INPUT -i lo -j ACCEPT
	iptables -t filter -A OUTPUT -o lo -j ACCEPT

	# ICMP (Ping)
	if [ $ICMP = "yes" ]
	then
		iptables -t filter -A INPUT -p icmp -j ACCEPT
		iptables -t filter -A OUTPUT -p icmp -j ACCEPT
	fi
	# ---

	# DHCP
	if [ $DHCP = "yes" ]
	then
		iptables -A INPUT -p udp --dport 67:68 --sport 67:68 -j ACCEPT
	fi
	# ---


	if [ $SSH = "yes" ]
	then
		# SSH In (Preventing brute force attacks using iptables recent matching)
                iptables -N SSH_BF
                iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --name SSH --set --rsource -j SSH_BF
                iptables -A SSH_BF -m recent ! --rcheck --seconds 60 --hitcount 5 --name SSH --rsource -j RETURN
                iptables -A SSH_BF -j LOG --log-prefix "SSH Brute Force Attempt:  " --log-level warning
                iptables -A SSH_BF -p tcp -j DROP
		# Lorsque le paquet n'a pas ete droppe: 
                iptables -A INPUT -p tcp -i eth0 --dport 22 -j ACCEPT

		# SSH Out : on accept
		iptables -t filter -A OUTPUT -p tcp --dport 22 -j ACCEPT
	fi



	# DNS In/Out
	if [ $DNS = "yes" ]
	then
		iptables -t filter -A OUTPUT -p tcp --dport 53 -j ACCEPT
		iptables -t filter -A OUTPUT -p udp --dport 53 -j ACCEPT
		iptables -t filter -A INPUT -p tcp --dport 53 -j ACCEPT
		iptables -t filter -A INPUT -p udp --dport 53 -j ACCEPT
	fi

	if [ $NTP = "yes" ]
	then	
		# NTP Out
		iptables -t filter -A OUTPUT -p udp --dport 123 -j ACCEPT
	fi

	if [ $NETBIOS_NS = "yes" ]
	then	
		iptables -t filter -A INPUT -p TCP --dport 137 -j ACCEPT
		iptables -t filter -A INPUT -p UDP --dport 137 -j ACCEPT
	fi


	if [ $NETBIOS_DGM = "yes" ]
	then	
		iptables -t filter -A INPUT -p UDP --dport 138 -j ACCEPT
	fi

	if [ $HTTP = "yes" ]
	then	
		# HTTP + HTTPS Out
		iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT
		iptables -t filter -A OUTPUT -p tcp --dport 443 -j ACCEPT

		# HTTP + HTTPS In
		iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
		iptables -t filter -A INPUT -p tcp --dport 443 -j ACCEPT
		iptables -t filter -A INPUT -p tcp --dport 8443 -j ACCEPT
	fi

	# Règles par défaut pour INPUT
	if [ $LOG = "yes" ]
	then
		iptables -A INPUT -j LOG_DROP
	fi	

}

stop() {
	echo stop
	#vidage des chaines
	iptables -F
	#destruction des chaines personnelles
	iptables -X

	#stratégies par défaut 
	iptables -P INPUT ACCEPT	#les connexions entrantes sont acceptées par défaut
	iptables -P FORWARD ACCEPT	#les connexions destinées à être forwardées sont acceptées par défaut
	iptables -P OUTPUT ACCEPT	#les connexions sortantes sont acceptées par défaut
	# FIN des "politiques par défaut"


	# Acceptation de toutes les connexions en local (un process avec l'autre)
	iptables -A INPUT -i lo -j ACCEPT
	iptables -A OUTPUT -o lo -j ACCEPT

	#accepter toutes les connexions établies et reliées
	iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
}

case "$1" in
 start)
        start
        ;;

stop)
        stop
        ;;
restart)
        stop && start
        ;;
*)
        echo "Usage $0 {start|stop|restart}"
        exit 1
esac

exit 0

