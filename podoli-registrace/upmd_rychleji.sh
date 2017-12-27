#!/bin/bash -ex

# Script to auto-fill the registration form at https://www.upmd.cz/registrace/.
#
# - apt-get install xdotool
# - Put cursor inside "Termín porodu" box and execute the script.
# - Update configuration in the constants at the top.
# - Optionally tune code for Pojišťovna if not VZP.

TERMIN_PORODU='1970-01-01'
CISLO_POJISTENCE_RC='0000000000'
JMENO='Jméno'
PRIJMENI='Příjmení'
ADRESA='Adresa'
TELEFON='000000000'
EMAIL='email@email.cz'
# POJISTOVNA='' # Update positions where to click

SLEEP_BETWEEN_COMMANDS=0.03
SLEEP_BETWEEN_GROUPS=0

function move_click_type {
	x="${1}"
	y="${2}"
	text="${3}"

	xdotool mousemove_relative --sync -- "${x}" "${y}"
	sleep ${SLEEP_BETWEEN_COMMANDS}
	xdotool click 1
	sleep ${SLEEP_BETWEEN_COMMANDS}
	xdotool type "${text}"
	sleep ${SLEEP_BETWEEN_COMMANDS}

	sleep ${SLEEP_BETWEEN_GROUPS}
}

move_click_type 0 0 "${TERMIN_PORODU}"
move_click_type 0 58 "${CISLO_POJISTENCE_RC}"
move_click_type 0 58 "${JMENO}"
move_click_type 0 58 "${ADRESA}"
move_click_type 0 58 "${TELEFON}"
move_click_type 300 0 "${EMAIL}"
move_click_type 0 -116 "${PRIJMENI}"

# VZP
xdotool mousemove_relative --sync -- 0 -50
sleep ${SLEEP_BETWEEN_COMMANDS}
xdotool click 1
sleep ${SLEEP_BETWEEN_COMMANDS}
xdotool mousemove_relative --sync -- 0 35
sleep ${SLEEP_BETWEEN_COMMANDS}
xdotool click 1
sleep ${SLEEP_BETWEEN_COMMANDS}
sleep ${SLEEP_BETWEEN_GROUPS}

# I'm not a robot :-P
xdotool mousemove_relative --sync -- -230 200
sleep ${SLEEP_BETWEEN_COMMANDS}
xdotool click 1
