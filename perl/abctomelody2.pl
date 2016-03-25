use strict;
use warnings;


my $abc = "e2 B c d e/2 d/2 c B |A2 A c e2 d c |B3 c d2 e2 |c2 A2 A4 |
z d2 f a2 g f |e3 c e2 d c |B2 B c d2 e2 |c2 A2 A2 z2 |e2 B c d e/2 d/2 c B |A2 A c e2 d c |
B3 c d2 e2 |c2 A2 A4 |z d2 f a2 g f |e3 c e2 d c |B2 B c d2 e2 |c2 A2 A2 z2 |
E4 C4 |D4 B,4 |C4 A,4 |^G,4 B,2 z2 |E4 C4 |D4 B,4 |C2 E2 A4 |^G4 z4 |e2 B c d e/2 d/2 c B |
A2 A c e2 d c |B3 c d2 e2 |c2 A2 A4 |z e3 c e2 d c |B2c2 A2 A2 z2 |e2 B c d e/2 d/2 c B |
A2 A c e2 d c |B3c2 A2 A4 |z d2 f a2 g f |e3 c e2 d c |B2 B c d2 e2 |c2 A2 A2 z2 |";

$abc =~ s/['\s\|\^=']//g;
my @abcd = split /(?=['abcdefgABCDEFGzZ'])['\s\|\^=']*/, $abc;

my $str = "(";

foreach(@abcd)
{
	#Noires
	$str = $str . " 'c---'," if $_ eq "z";
	$str = $str . " 'c3sol'," if $_ eq "G,";
	$str = $str . " 'c3la'," if $_ eq "A,";
	$str = $str . " 'c3si'," if $_ eq "B,";
	$str = $str . " 'c4do'," if $_ eq "C";
	$str = $str . " 'c4re'," if $_ eq "D";
	$str = $str . " 'c4mi'," if $_ eq "E";
	$str = $str . " 'c4fa'," if $_ eq "F";
	$str = $str . " 'c4sol'," if $_ eq "G";
	$str = $str . " 'c4la'," if $_ eq "A";
	$str = $str . " 'c4si'," if $_ eq "B";
	$str = $str . " 'c5do'," if $_ eq "c";
	$str = $str . " 'c5re'," if $_ eq "d";
	$str = $str . " 'c5mi'," if $_ eq "e";
	$str = $str . " 'c5fa'," if $_ eq "f";
	$str = $str . " 'c5sol'," if $_ eq "g";
	$str = $str . " 'c5la'," if $_ eq "a";
	$str = $str . " 'c5si'," if $_ eq "b";
	$str = $str . " 'c5si'," if $_ eq "c'"; # Non géré par le vhdl (gamme 6)
	$str = $str . " 'c5si'," if $_ eq "d'";
	#Noires pointées
	$str = $str . " 'c--.'," if $_ eq "z3/2";
	$str = $str . " 'c3sol.'," if $_ eq "G,3/2";
	$str = $str . " 'c3la.'," if $_ eq "A,3/2";
	$str = $str . " 'c3si.'," if $_ eq "B,3/2";
	$str = $str . " 'c4do.'," if $_ eq "C3/2";
	$str = $str . " 'c4re.'," if $_ eq "D3/2";
	$str = $str . " 'c4mi.'," if $_ eq "E3/2";
	$str = $str . " 'c4fa.'," if $_ eq "F3/2";
	$str = $str . " 'c4sol.'," if $_ eq "G3/2";
	$str = $str . " 'c4la.'," if $_ eq "A3/2";
	$str = $str . " 'c4si.'," if $_ eq "B3/2";
	$str = $str . " 'c5do.'," if $_ eq "c3/2";
	$str = $str . " 'c5re.'," if $_ eq "d3/2";
	$str = $str . " 'c5mi.'," if $_ eq "e3/2";
	$str = $str . " 'c5fa.'," if $_ eq "f3/2";
	$str = $str . " 'c5sol.'," if $_ eq "g3/2";
	$str = $str . " 'c5la.'," if $_ eq "a3/2";
	$str = $str . " 'c5si.'," if $_ eq "b3/2";
	$str = $str . " 'c5si.'," if $_ eq "c'3/2"; # Non géré par le vhdl (gamme 6)
	$str = $str . " 'c5si.'," if $_ eq "d'3/2";
	#Croches
	$str = $str . " 'd---'," if $_ eq "z/2";
	$str = $str . " 'd3sol'," if $_ eq "G,/2";
	$str = $str . " 'd3la'," if $_ eq "A,/2";
	$str = $str . " 'd3si'," if $_ eq "B,/2";
	$str = $str . " 'd4do'," if $_ eq "C/2";
	$str = $str . " 'd4re'," if $_ eq "D/2";
	$str = $str . " 'd4mi'," if $_ eq "E/2";
	$str = $str . " 'd4fa'," if $_ eq "F/2";
	$str = $str . " 'd4sol'," if $_ eq "G/2";
	$str = $str . " 'd4la'," if $_ eq "A/2";
	$str = $str . " 'd4si'," if $_ eq "B/2";
	$str = $str . " 'd5do'," if $_ eq "c/2";
	$str = $str . " 'd5re'," if $_ eq "d/2";
	$str = $str . " 'd5mi'," if $_ eq "e/2";
	$str = $str . " 'd5fa'," if $_ eq "f/2";
	$str = $str . " 'd5sol'," if $_ eq "g/2";
	$str = $str . " 'd5la'," if $_ eq "a/2";
	$str = $str . " 'd5si'," if $_ eq "b/2";
	$str = $str . " 'd5si'," if $_ eq "c'/2"; # Non géré par le vhdl (gamme 6)
	$str = $str . " 'd5si'," if $_ eq "d'/2";
	#Croches pointées
	$str = $str . " 'd--.'," if $_ eq "z2/3";
	$str = $str . " 'd3sol.'," if $_ eq "G,2/3";
	$str = $str . " 'd3la.'," if $_ eq "A,2/3";
	$str = $str . " 'd3si.'," if $_ eq "B,2/3";
	$str = $str . " 'd4do.'," if $_ eq "C2/3";
	$str = $str . " 'd4re.'," if $_ eq "D2/3";
	$str = $str . " 'd4mi.'," if $_ eq "E2/3";
	$str = $str . " 'd4fa.'," if $_ eq "F2/3";
	$str = $str . " 'd4sol.'," if $_ eq "G2/3";
	$str = $str . " 'd4la.'," if $_ eq "A2/3";
	$str = $str . " 'd4si.'," if $_ eq "B2/3";
	$str = $str . " 'd5do.'," if $_ eq "c2/3";
	$str = $str . " 'd5re.'," if $_ eq "d2/3";
	$str = $str . " 'd5mi.'," if $_ eq "e2/3";
	$str = $str . " 'd5fa.'," if $_ eq "f2/3";
	$str = $str . " 'd5sol.'," if $_ eq "g2/3";
	$str = $str . " 'd5la.'," if $_ eq "a2/3";
	$str = $str . " 'd5si.'," if $_ eq "b2/3";
	$str = $str . " 'd5si.'," if $_ eq "c'2/3"; # Non géré par le vhdl (gamme 6)
	$str = $str . " 'd5si.'," if $_ eq "d'2/3";
	#Blanches
	$str = $str . " 'n---'," if $_ eq "z2";
	$str = $str . " 'n3sol'," if $_ eq "G,2";
	$str = $str . " 'n3la'," if $_ eq "A,2";
	$str = $str . " 'n3si'," if $_ eq "B,2";
	$str = $str . " 'n4do'," if $_ eq "C2";
	$str = $str . " 'n4re'," if $_ eq "D2";
	$str = $str . " 'n4mi'," if $_ eq "E2";
	$str = $str . " 'n4fa'," if $_ eq "F2";
	$str = $str . " 'n4sol'," if $_ eq "G2";
	$str = $str . " 'n4la'," if $_ eq "A2";
	$str = $str . " 'n4si'," if $_ eq "B2";
	$str = $str . " 'n5do'," if $_ eq "c2";
	$str = $str . " 'n5re'," if $_ eq "d2";
	$str = $str . " 'n5mi'," if $_ eq "e2";
	$str = $str . " 'n5fa'," if $_ eq "f2";
	$str = $str . " 'n5sol'," if $_ eq "g2";
	$str = $str . " 'n5la'," if $_ eq "a2";
	$str = $str . " 'n5si'," if $_ eq "b2";
	$str = $str . " 'n5si'," if $_ eq "c'2"; # Non géré par le vhdl (gamme 6)
	$str = $str . " 'n5si'," if $_ eq "d'2";
	#Blanches pointees
	$str = $str . " 'n--.'," if $_ eq "z3";
	$str = $str . " 'n3sol.'," if $_ eq "G,3";
	$str = $str . " 'n3la.'," if $_ eq "A,";
	$str = $str . " 'n3si.'," if $_ eq "B,3";
	$str = $str . " 'n4do.'," if $_ eq "C3";
	$str = $str . " 'n4re.'," if $_ eq "D3";
	$str = $str . " 'n4mi.'," if $_ eq "E3";
	$str = $str . " 'n4fa.'," if $_ eq "F3";
	$str = $str . " 'n4sol.'," if $_ eq "G3";
	$str = $str . " 'n4la.'," if $_ eq "A3";
	$str = $str . " 'n4si.'," if $_ eq "B3";
	$str = $str . " 'n5do.'," if $_ eq "c3";
	$str = $str . " 'n5re.'," if $_ eq "d3";
	$str = $str . " 'n5mi.'," if $_ eq "e3";
	$str = $str . " 'n5fa.'," if $_ eq "f3";
	$str = $str . " 'n5sol.'," if $_ eq "g3";
	$str = $str . " 'n5la.'," if $_ eq "a3";
	$str = $str . " 'n5si.'," if $_ eq "b3";
	$str = $str . " 'n5si.'," if $_ eq "c'3"; # Non géré par le vhdl (gamme 6)
	$str = $str . " 'n5si.'," if $_ eq "d'3";
	#Rondes
	$str = $str . " 'b---'," if $_ eq "z4";
	$str = $str . " 'b3sol'," if $_ eq "G,4";
	$str = $str . " 'b3la'," if $_ eq "A,4";
	$str = $str . " 'b3si'," if $_ eq "B,4";
	$str = $str . " 'b4do'," if $_ eq "C4";
	$str = $str . " 'b4re'," if $_ eq "D4";
	$str = $str . " 'b4mi'," if $_ eq "E4";
	$str = $str . " 'b4fa'," if $_ eq "F4";
	$str = $str . " 'b4sol'," if $_ eq "G4";
	$str = $str . " 'b4la'," if $_ eq "A4";
	$str = $str . " 'b4si'," if $_ eq "B4";
	$str = $str . " 'b5do'," if $_ eq "c4";
	$str = $str . " 'b5re'," if $_ eq "d4";
	$str = $str . " 'b5mi'," if $_ eq "e4";
	$str = $str . " 'b5fa'," if $_ eq "f4";
	$str = $str . " 'b5sol'," if $_ eq "g4";
	$str = $str . " 'b5la'," if $_ eq "a4";
	$str = $str . " 'b5si'," if $_ eq "b4";
	$str = $str . " 'b5si'," if $_ eq "c'4"; # Non géré par le vhdl (gamme 6)
	$str = $str . " 'b5si'," if $_ eq "d'4";
	#Rondes pointées
	$str = $str . " 'b---.'," if $_ eq "z6";
	$str = $str . " 'b3sol.'," if $_ eq "G,6";
	$str = $str . " 'b3la.'," if $_ eq "A,6";
	$str = $str . " 'b3si.'," if $_ eq "B,6";
	$str = $str . " 'b4do.'," if $_ eq "C6";
	$str = $str . " 'b4re.'," if $_ eq "D6";
	$str = $str . " 'b4mi.'," if $_ eq "E6";
	$str = $str . " 'b4fa.'," if $_ eq "F6";
	$str = $str . " 'b4sol.'," if $_ eq "G6";
	$str = $str . " 'b4la.'," if $_ eq "A6";
	$str = $str . " 'b4si.'," if $_ eq "B6";
	$str = $str . " 'b5do.'," if $_ eq "c6";
	$str = $str . " 'b5re.'," if $_ eq "d6";
	$str = $str . " 'b5mi.'," if $_ eq "e6";
	$str = $str . " 'b5fa.'," if $_ eq "f6";
	$str = $str . " 'b5sol.'," if $_ eq "g6";
	$str = $str . " 'b5la.'," if $_ eq "a6";
	$str = $str . " 'b5si.'," if $_ eq "b6";
	$str = $str . " 'b5si.'," if $_ eq "c'6"; # Non géré par le vhdl (gamme 6)
	$str = $str . " 'b5si.'," if $_ eq "d'6";
	#Rondes
	$str = $str . " 'r---'," if $_ eq "z8";
	$str = $str . " 'r3sol'," if $_ eq "G,8";
	$str = $str . " 'r3la'," if $_ eq "A,8";
	$str = $str . " 'r3si'," if $_ eq "B,8";
	$str = $str . " 'r4do'," if $_ eq "C8";
	$str = $str . " 'r4re'," if $_ eq "D8";
	$str = $str . " 'r4mi'," if $_ eq "E8";
	$str = $str . " 'r4fa'," if $_ eq "F8";
	$str = $str . " 'r4sol'," if $_ eq "G8";
	$str = $str . " 'r4la'," if $_ eq "A8";
	$str = $str . " 'r4si'," if $_ eq "B8";
	$str = $str . " 'r5do'," if $_ eq "c8";
	$str = $str . " 'r5re'," if $_ eq "d8";
	$str = $str . " 'r5mi'," if $_ eq "e8";
	$str = $str . " 'r5fa'," if $_ eq "f8";
	$str = $str . " 'r5sol'," if $_ eq "g8";
	$str = $str . " 'r5la'," if $_ eq "a8";
	$str = $str . " 'r5si'," if $_ eq "b8";
	$str = $str . " 'r5si'," if $_ eq "c'8"; # Non géré par le vhdl (gamme 6)
	$str = $str . " 'r5si'," if $_ eq "d'8";
}


print $str . "\n";
