#!/bin/sh
cat tutcode.2m | ./mktable.awk $*
grep '^.[ty]' tutcode.3 | ./mktable.awk IDXOFFSET=30 $*
grep '^.[gh]' tutcode.3 | ./mktable.awk IDXOFFSET=60 $*
grep '^.[vm]' tutcode.3 | ./mktable.awk IDXOFFSET=90 $*
grep '^.[bn]' tutcode.3 | ./mktable.awk IDXOFFSET=120 $*
