#!/usr/bin/perl
use strict;
use warnings;

my %table = (
' ' => "00",
'A' => "41",
'B' => "42",
'C' => "43",
'D' => "44",
'E' => "45",
'F' => "46",
'G' => "47",
'H' => "48",
'I' => "49",
'J' => "4A",
'K' => "4B",
'L' => "4C",
'M' => "4D",
'N' => "4E",
'O' => "4F",
'P' => "50",
'Q' => "51",
'R' => "52",
'S' => "53",
'T' => "54",
'U' => "55",
'V' => "56",
'W' => "57",
'X' => "58",
'Y' => "59",
'Z' => "5A",
'a' => "61",
'b' => "62",
'c' => "63",
'd' => "64",
'e' => "65",
'f' => "66",
'g' => "67",
'h' => "68",
'i' => "69",
'j' => "6A",
'k' => "6B",
'l' => "6C",
'm' => "6D",
'n' => "6E",
'o' => "6F",
'p' => "70",
'q' => "71",
'r' => "72",
's' => "73",
't' => "74",
'u' => "75",
'v' => "76",
'w' => "77",
'x' => "78",
'y' => "79",
'z' => "7A",
'*' => "2A",
'+' => "2B",
'-' => "2D",
'=' => "3D",
'0' => "30",
'1' => "31",
'2' => "32",
'3' => "33",
'4' => "34",
'5' => "35",
'6' => "36",
'7' => "37",
'8' => "38",
'9' => "39",
'.' => "2E"
 );

for my $str (@ARGV) 
{
	if ( length($str) > 39 )
	{
		print "$str = TROP GRAND\n"
	}
	else
	{
		my $i = 39;
		my $cmd = "00"; # On commence avec un vide.
		for (split (//, $str))
		{
			$i = $i-1;
			$cmd = $cmd . $table{$_}; 
		}
		while($i>0)
		{
			$cmd = $cmd . "00";
			$i= $i-1;
		}
		my $cadre = "";
		while($i<length($str)+6)
		{
			$cadre = $cadre . '-';
			$i = $i+1;
		}
		print "$cadre\n-- $str --\n$cadre\nwhen X\"$cmd\" =>\n";
	}
}