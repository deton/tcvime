#!/bin/sh
echo "scriptencoding utf-8"
echo -n "let tcvime#helptbl_tutcode#tbl = {"
cat tutcode.2m | ./mktable.awk $*
grep '^.[ty]' tutcode.3 | ./mktable.awk $*
grep '^.[gh]' tutcode.3 | ./mktable.awk $*
grep '^.[vm]' tutcode.3 | ./mktable.awk $*
grep '^.[bn]' tutcode.3 | ./mktable.awk $*
echo "}"
