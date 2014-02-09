#!/usr/bin/awk -f
BEGIN {
	FS = "\t";
}
/^$/ {
	next;
}
{
	idx = idx "," $1;
	tbl = tbl "," $2;
}
END {
	printf("scriptencoding utf-8\n");
	printf("let tcvime#helptbl_tutcode#seq2tbl = {");
	printf("%s", substr(idx, 2));
	printf("}\n");
	printf("let tcvime#helptbl_tutcode#tbl = [");
	printf("%s", substr(tbl, 2));
	printf("]\n");
}
