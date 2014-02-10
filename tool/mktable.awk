#!/usr/bin/awk -f
BEGIN {
	tblidx[0] = "q";
	tblidx[1] = "w";
	tblidx[2] = "e";
	tblidx[3] = "r";
	tblidx[4] = "t";
	tblidx[5] = "y";
	tblidx[6] = "u";
	tblidx[7] = "i";
	tblidx[8] = "o";
	tblidx[9] = "p";

	tblidx[10] = "a";
	tblidx[11] = "s";
	tblidx[12] = "d";
	tblidx[13] = "f";
	tblidx[14] = "g";
	tblidx[15] = "h";
	tblidx[16] = "j";
	tblidx[17] = "k";
	tblidx[18] = "l";
	tblidx[19] = ";";

	tblidx[20] = "z";
	tblidx[21] = "x";
	tblidx[22] = "c";
	tblidx[23] = "v";
	tblidx[24] = "b";
	tblidx[25] = "n";
	tblidx[26] = "m";
	tblidx[27] = ",";
	tblidx[28] = ".";
	tblidx[29] = "/";
}
{
	len = length($1); 
	firstkey = substr($1, 1, 1);
	lastkey = substr($1, len, 1);
	if (len == 3) {
		midkey = substr($1, 2, 1);
		st3 = 1;

		midleft = "<";
		midright = ">";
		switch (midkey) {
		case "v":
		case "m":
			midleft = ">";
			midright = "<";
			midrk = "v";
			midlk = "m";
			mididx = 2;
			break;
		case "t":
		case "y":
			mididx = 0;
			midrk = "t";
			midlk = "y";
			break;
		case "g":
		case "h":
			mididx = 1;
			midrk = "g";
			midlk = "h";
			break;
		case "b":
		case "n":
			mididx = 2;
			midrk = "b";
			midlk = "n";
			break;
		}
	}
	tbl[lastkey firstkey] = $2;
	if (len == 3) {
		if (tbl[lastkey lastkey] == "") {
			tbl[lastkey lastkey] = "△";
		}
	}
}
END {
	for (oj = 0; oj < 3; oj++) {
		for (oi = 0; oi < 10; oi++) {
			onr = oj * 10 + oi;
			if (midkey) {
				if (oi < 5) {
					midkey = midlk;
				} else {
					midkey = midrk;
				}
			}
			printf("'%s%s':", midkey, tblidx[onr]);
			printf("\"");
			for (j = 0; j < 3; j++) {
				for (i = 0; i < 10; i++) {
					nr = j * 10 + i;
					idx = tblidx[onr] tblidx[nr];
					kanji = tbl[idx];
					if (kanji == "") {
						kanji = "・";
					} else if (kanji == "-") {
						kanji = "＿";
					}
					if (nr == onr) {
						kanji = "$" kanji;
					} else if (i == oi) {
						kanji = " " kanji; # padding
					}
					printf("%s", kanji);
					if (i == 4) { # center
						if (st3 && j == mididx) {
							if (oi < 5) {
								printf(midleft);
							} else {
								printf(midright);
							}
						} else {
							printf("|");
						}
					}
				}
				printf("\\n");
			}
			printf("\",");
		}
		#printf("\n");
	}
	#printf("\n");
}
