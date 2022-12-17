# 12 bit BCD adder
Simple 12 bit BCD adder using 4 modules.
Full adder cell does addition using bit logic.
Ripple carry adder references the FAC module 4 times, doing a 4 bit addition, a BCD digit in other words.
BCD2 applies correction by calling the RCA function two times and using a corrfactor in-between.
BCD Adder calls BCD2 4 times, 3 times for the first 3 digits, and one more time in case the 12th bit is 1.
