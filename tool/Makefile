all: helptbl_tutcode.vim

helptbl_tutcode.vim: idxtbl.tmp mkscript.awk
	LANG=C ./mkscript.awk idxtbl.tmp >helptbl_tutcode.vim

idxtbl.tmp: mktbl.sh mktable.awk tutcode.2m tutcode.3
	./mktbl.sh >idxtbl.tmp

tutcode.2m: tutcode.2 mid-t mid-y mid-g mid-h mid-v mid-m mid-b mid-n
	cat mid-t mid-y mid-g mid-h mid-v mid-m mid-b mid-n tutcode.2 >tutcode.2m

clean:
	-rm -f helptbl_tutcode.vim idxtbl.tmp mid-t mid-y mid-g mid-h mid-v mid-m mid-b mid-n tutcode.2m

mid-t: tutcode.3
	grep '^.t' tutcode.3|cut -c 1|sort -u|sed -e 's/$$/t	-/'>mid-t

mid-y: tutcode.3
	grep '^.y' tutcode.3|cut -c 1|sort -u|sed -e 's/$$/y	-/'>mid-y

mid-g: tutcode.3
	grep '^.g' tutcode.3|cut -c 1|sort -u|sed -e 's/$$/g	-/'>mid-g

mid-h: tutcode.3
	grep '^.h' tutcode.3|cut -c 1|sort -u|sed -e 's/$$/h	-/'>mid-h

mid-v: tutcode.3
	grep '^.v' tutcode.3|cut -c 1|sort -u|sed -e 's/$$/v	-/'>mid-v

mid-m: tutcode.3
	grep '^.m' tutcode.3|cut -c 1|sort -u|sed -e 's/$$/m	-/'>mid-m

mid-b: tutcode.3
	grep '^.b' tutcode.3|cut -c 1|sort -u|sed -e 's/$$/b	-/'>mid-b

mid-n: tutcode.3
	grep '^.n' tutcode.3|cut -c 1|sort -u|sed -e 's/$$/n	-/'>mid-n
