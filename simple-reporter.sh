#!/bin/bash

# Archivo de salida con el reporte
tmpfile=$(mktemp /tmp/beforeinstall-report.XXXXXX)
# Separador de conveniencia
separator="#######################################"

# Función que ejecuta, reporta, separa
execute_and_report () {
  # Se ejecuta dos veces por si acaso tee no está instalado

  # Separador visual
  echo $separator
  echo $separator >> $tmpfile 2>&1
  # Nombre del reporte
  echo $1
  echo $1 >> $tmpfile 2>&1
  # Ejecución del comando
  eval $2
  eval $2 >> $tmpfile 2>&1
}

# Llamadas a los comandos, nombre, comando
execute_and_report "Time report" "date"
execute_and_report "Kernel version" "uname -a"
execute_and_report "Distro report" "cat /etc/redhat-release"
execute_and_report "Memory report" "free"
execute_and_report "Storage report" "lsblk"
execute_and_report "Disks mount" "mount"
execute_and_report "Current Ip" "ip ad show"
execute_and_report "IPv4 listening ports report" "ss -l --ipv4 -n"
execute_and_report "IPv6 listening ports report" "ss -l --ipv6 -n"
execute_and_report "Checking firewall config" "firewall-cmd --list-all"
execute_and_report "Installed Packages" "rpm -qa | sort "
execute_and_report "RPMDB history report" "yum history"
execute_and_report "Last logged in users report" "last"
