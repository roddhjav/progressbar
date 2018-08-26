#!/usr/bin/env bash
# shellcheck disable=SC2016,SC1091

export test_description="pacman progressbar tests"

source ./setup


ILoveCandy=false
test_expect_success 'Testing Default Theme' '
	test_progressbar "Default" "1" &&
	test_progressbar "Default" "2"
    '

test_cleantheme
export ILoveCandy=true
test_expect_success 'Testing ILoveCandy Theme' '
	test_progressbar "ILoveCandy" "1" &&
	test_progressbar "ILoveCandy" "2"
    '

test_cleantheme
test_expect_success 'Testing special theme' '
	Braket_in="(" Braket_out=")" Cursor_done=">" Cursor_not_done="|" &&
	ILoveCandy=false test_progressbar "Special theme 1" "Default"
	'

test_cleantheme
test_expect_success 'Testing special theme' '
	Braket_in="(" Braket_out=")" Cursor="c" Cursor_small="C" Cursor_not_done="<" &&
	ILoveCandy=false test_progressbar "Special theme 2" "Default"
    '

test_cleantheme
test_expect_success 'Testing special theme' '
	Braket_in="(" Braket_out=")" Cursor="x" Cursor_small=" " Cursor_done="-" Cursor_not_done="---" &&
	ILoveCandy=true test_progressbar "Special theme 3" "ILoveCandy"
    '

test_done
