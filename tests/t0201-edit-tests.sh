#!/usr/bin/env bash

test_description='Test edit with spaces in $EDITOR'
cd "$(dirname "$0")"
. ./setup.sh

test_expect_success 'Test shell-parsing of $EDITOR' '
	"$PASS" init $KEY1 &&
	"$PASS" generate cred1 90 &&
	export PASSWORD_WITH_SPACE="Password with space" &&
	export EDITOR="sed -i -e \"1s,^.*\$,$PASSWORD_WITH_SPACE,\"" &&
	"$PASS" edit cred1 2> /tmp/cred1 &&
	"$PASS" show cred1 > /tmp/cred1 &&
	[[ $("$PASS" show cred1) == "$PASSWORD_WITH_SPACE" ]]
'

test_done
