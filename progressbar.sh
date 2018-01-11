#!/usr/bin/env bash
# progressbar - A pacman like progress bar in bash
# Copyright (C) 2016 - 2018 Alexandre PUJOL <alexandre@pujol.io>.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

readonly green='\e[0;32m'
readonly yellow='\e[0;33m'
readonly magenta='\e[0;35m'
readonly Bold='\e[1m'
readonly Bred='\e[1;31m'
readonly Bgreen='\e[1;32m'
readonly Byellow='\e[1;33m'
readonly Bblue='\e[1;34m'
readonly Bmagenta='\e[1;35m'
readonly reset='\e[0m'

__die() { echo -e " ${Bred}[x]${reset} ${Bold}Error :${reset} ${*}" >&2 && exit 1; }

__progressbar_error() {
	echo "A valid ${*} must be supplied to initialise 'progressbar'."
}

__progressbar_theme() {
	[[ -z "${ILoveCandy}" ]] && ILoveCandy=false
	[[ -z "${Braket_in}" ]]  && Braket_in="["
	[[ -z "${Braket_out}" ]] && Braket_out="]"

	# Definition of the diferent cursors
	if [[ "${ILoveCandy}" == true ]]; then
		[[ -z "${Cursor_done}" ]]     && Cursor_done="-"
		[[ -z "${Cursor_not_done}" ]] && Cursor_not_done="o  "
		[[ -z "${Cursor}" ]]          && Cursor="${Byellow}C${reset}"
		[[ -z "${Cursor_small}" ]]    && Cursor_small="${Byellow}c${reset}"
	else
		[[ -z "${Cursor_done}" ]]     && Cursor_done="#"
		[[ -z "${Cursor_not_done}" ]] && Cursor_not_done="-"
	fi
}

progressbar() {
	[[ -z "${1}" ]] && __die "$(__progressbar_error bar title)"
	[[ -z "${2}" ]] && __die "$(__progressbar_error curent position)"
	[[ -z "${3}" ]] && __die "$(__progressbar_error total)"
	local title="${1}" current="${2}" total="${3}"
	local msg1="${4}" msg2="${5}" msg3="${6}"
	__progressbar_theme

	cols=$(tput cols)
	let block=${cols}/3-${cols}/20
	let _title=${block}-${#title}-1
	let _msg=${block}-${#msg1}-${#msg2}-${#msg3}-3

	_title=$(printf "%${_title}s")
	_msg=$(printf "%${_msg}s")

	let _pbar_size=${cols}-2*${block}-8
	let _progress=${current}*100/${total}
	let _current=${current}*${_pbar_size}
	let _current=${_current}/${total}
	let _total=${_pbar_size}-${_current}

	if [[ "${ILoveCandy}" == true ]]; then
		# First print <_dummy_block> [ o  o  o  o  o ] _progress%
		let _motif=${_pbar_size}/3
		let _dummy_block=2*${block}+1
		_dummy_block=$(printf "%${_dummy_block}s")
		_motif=$(printf "%${_motif}s")
		printf "\r${_dummy_block}${Braket_in} ${_motif// /${Cursor_not_done}}${Braket_out} ${_progress}%%"

		# Second print <title> <msg> [-----C
		_current_pair=${_current}
		let _current=${_current}-1
		let _total=${_total}
		_current=$(printf "%${_current}s")
		_total=$(printf "%${_total}s")

		printf "\r ${title}${_title} ${_msg}${msg1} ${msg2} ${msg3} "
		printf "${Braket_in}${_current// /${Cursor_done}}"
		if [[ "$(expr ${_current_pair} % 2)" -eq 0 ]]; then
			printf "${Cursor}"
		else
			printf "${Cursor_small}"
		fi

		# Transform the last "C" in "-"
		if [[ "${_progress}" -eq 100 ]]; then
			printf "\r ${title}${_title} ${_msg}${msg1} ${msg2} ${msg3} ${Braket_in}${_current// /${Cursor_done}}${Cursor_done}${Braket_out}\n"
		fi
	else
		_current=$(printf "%${_current}s")
		_total=$(printf "%${_total}s")
		printf "\r ${title}${_title} ${_msg}${msg1} ${msg2} ${msg3} "
		printf "${Braket_in}${_current// /${Cursor_done}}${_total// /${Cursor_not_done}}${Braket_out} ${_progress}%%"
	fi
}
