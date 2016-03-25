use strict;
use warnings;


my @mario;
@mario = ( 'd5mi', 'c5mi', 'c5mi', 'd5do', 'c5mi', 'd5sol', 'c--.', 'd4sol', 'c--.', 'd5do', 'c---', 'd4sol', 'c---', 'd4mi', 'c---', 'c4la', 'c4si', 'd4la', 'c4la', 'd4sol.', 'd5do.', 'd5mi.', 'c5la', 'd5fa', 'c5sol', 'c5mi', 'c5do', 'd5re', 'c4si', 'd5do', 'c---', 'd4sol', 'c---', 'd4mi', 'c---', 'c4la', 'c4si', 'd4la', 'c4la', 'd4sol.', 'd5do.', 'd5mi.', 'c5la', 'd5fa', 'c5sol', 'c5mi', 'c5do', 'd5re', 'd4si', 'd---', 'c---', 'd5sol', 'd5fa', 'd5fa', 'c5re', 'c5mi', 'd4sol', 'd4la', 'c5do', 'd4la', 'd5do', 'd5re', 'c---', 'd5sol', 'd5fa', 'd5fa', 'c5re', 'c5mi', 'c5do', 'd5do', 'd5do', 'c--.', 'c---', 'd5sol', 'd5fa', 'd5fa', 'c5re', 'c5mi', 'd4sol', 'd4la', 'c5do', 'd4la', 'd5do', 'd5re', 'c---', 'd5re', 'c---', 'd5re', 'c---', 'd5do', 'n--.', 'd---', 'c---', 'd5sol', 'd5fa', 'd5fa', 'c5re', 'c5mi', 'd4sol', 'd4la', 'c5do', 'd4la', 'd5do', 'd5re', 'c---', 'd5sol', 'd5fa', 'd5fa', 'c5re', 'c5mi', 'c5do', 'd5do', 'd5do', 'c--.', 'c---', 'd5sol', 'd5fa', 'd5fa', 'c5re', 'c5mi', 'd4sol', 'd4la', 'c5do', 'd4la', 'd5do', 'd5re', 'c---', 'd5re', 'c---', 'd5re', 'c---', 'd5do', 'n--.', 'd---', 'd5do', 'c5do', 'c5do', 'd5do', 'c5re', 'd5mi', 'c5do', 'd4la', 'n4sol', 'd5do', 'c5do', 'c5do', 'd5do', 'c5re', 'd5mi', 'n--.', 'd---', 'd5do', 'c5do', 'c5do', 'd5do', 'c5re', 'd5mi', 'c5do', 'd4la', 'n4sol', 'd5mi', 'c5mi', 'c5mi', 'd5do', 'c5mi', 'd5sol', 'n--.', 'd---', 'd5do', 'c---', 'd4sol', 'c---', 'd4mi', 'c---', 'c4la', 'c4si', 'd4la', 'c4la', 'd4sol.', 'd5do.', 'd5mi.', 'c5la', 'd5fa', 'c5sol', 'c5mi', 'c5do', 'd5re', 'c4si', 'd5do', 'c---', 'd4sol', 'c---', 'd4mi', 'c---', 'c4la', 'c4si', 'd4la', 'c4la', 'd4sol.', 'd5do.', 'd5mi.', 'c5la', 'd5fa', 'c5sol', 'c5mi', 'c5do', 'd5re', 'c4si', 'd5mi', 'c5do', 'd4sol', 'c---', 'c4sol', 'd4la', 'c5fa', 'd5fa', 'd4la', 'c--.', 'd4si', 'c5la', 'd4si', 'd5la', 'c5mi', 'd5fa', 'd5mi', 'c5do', 'd4la', 'd4sol', 'c--.', 'd5mi', 'c5do', 'd4sol', 'c---', 'c4sol', 'd4la', 'c5fa', 'd5fa', 'd4la', 'c--.', 'd4si', 'c5fa', 'd5fa', 'd5fa', 'c5mi', 'd5re', 'd5do', 'c4sol', 'd4mi', 'd4do', 'c--.', 'd5do', 'c5do', 'd4mi', 'c---', 'c4sol', 'd4la', 'c5fa', 'd5fa', 'd4la', 'c--.', 'd4si', 'c5la', 'd5la', 'd5la', 'c5mi', 'd5fa', 'd5do', 'c4sol', 'd4la', 'd4sol', 'c--.', 'd5mi', 'c5do', 'd4sol', 'c---', 'c4sol', 'd4la', 'c5fa', 'd5do', 'd4la', 'c--.', 'd4si', 'c4si', 'd5fa', 'd5fa', 'c5mi', 'd5re', 'd5do', 'c4sol', 'd4mi', 'd4do', 'c--.', 'd5do', 'c5do', 'c5do', 'd5do', 'c5re', 'd5mi', 'c5do', 'd4la', 'n4sol', 'd5do', 'c5do', 'c5do', 'd5do', 'c5re', 'd5mi', 'n--.', 'd---', 'd5do', 'c5do', 'c5do', 'd5do', 'c5re', 'd5mi', 'c5do', 'd4la', 'n4sol', 'd5mi', 'c5mi', 'c5mi', 'd5do', 'c5mi', 'd5sol', 'n--.', 'd---', 'd5do', 'c5do', 'd4sol', 'c---', 'c4mi', 'd4la', 'c5do', 'd5do', 'd4la', 'c--.', 'd4sol', 'c5la', 'd4si', 'd5la', 'c5mi', 'd5fa', 'd5mi', 'c5do', 'd4la', 'd4sol', 'c--.', 'd5mi', 'c5do', 'd4sol', 'c---', 'c4mi', 'd4la', 'c5do', 'd5do', 'd4fa', 'c--.', 'd4si', 'c4si', 'd5fa', 'd5fa', 'c5do', 'd4si', 'd5do', 'c4sol', 'd4do', 'r---', 'fin');

my @mortal;
@mortal = ( 'c4la', 'c4la', 'c5do', 'c4la', 'c5re', 'c4la', 'c5mi', 'c5re', 'c5do', 'c5do', 'c5mi', 'c5do', 'c5sol', 'c5do', 'c5mi', 'c5do', 'c4sol', 'c4sol', 'c4si', 'c4sol', 'c5do', 'c4sol', 'c5re', 'c5do', 'c4fa', 'c4fa', 'c4la', 'c4fa', 'c5do', 'c4fa', 'c5do', 'c4si', 'c4la', 'c4la', 'c5do', 'c4la', 'c5re', 'c4la', 'c5mi', 'c5re', 'c5do', 'c5do', 'c5mi', 'c5do', 'c5sol', 'c5do', 'c5mi', 'c5do', 'c4sol', 'c4sol', 'c4si', 'c4sol', 'c5do', 'c4sol', 'c5re', 'c5do', 'c4fa', 'c4fa', 'c4la', 'c4fa', 'c5do', 'c4fa', 'c5do', 'c4si', 'c4la.', 'c4la.', 'c4la.', 'c4la.', 'c4sol', 'c5do', 'c4la.', 'c4la.', 'c4la.', 'c4la.', 'c4sol', 'c4mi', 'c4la.', 'c4la.', 'c4la.', 'c4la.', 'c4sol', 'c5do', 'c4la.', 'c4la.', 'c4la', 'd4la', 'c4la', 'd4la', 'd4la', 'c--.', 'c4la.', 'c4la.', 'c4la.', 'c4la.', 'c4sol', 'c5do', 'c4la.', 'c4la.', 'c4la.', 'c4la.', 'c4sol', 'c4mi', 'c4la.', 'c4la.', 'c4la.', 'c4la.', 'c4sol', 'c5do', 'c4la.', 'c4la.', 'c4la', 'd4la', 'c4la', 'd4la', 'd4la', 'c--.', 'd4la', 'c5mi', 'd4la', 'c5do', 'd4la', 'c4si', 'd4la', 'c5do', 'd4la', 'd4si', 'c4sol', 'd4la', 'c5mi', 'd4la', 'c5do', 'd4la', 'c4si', 'd4la', 'c5do', 'd4la', 'd4si', 'c4sol', 'd4la', 'c5mi', 'd4la', 'c5do', 'd4la', 'c4si', 'd4la', 'c5do', 'd4la', 'd4si', 'c4sol', 'd4la', 'c5mi', 'd4la', 'c5do', 'd4sol', 'c4sol', 'd4sol', 'c4la', 'd4la', 'c--.', 'd4la', 'c5mi', 'd4la', 'c5do', 'd4la', 'c4si', 'd4la', 'c5do', 'd4la', 'd4si', 'c4sol', 'd4la', 'c5mi', 'd4la', 'c5do', 'd4la', 'c4si', 'd4la', 'c5do', 'd4la', 'd4si', 'c4sol', 'd4la', 'c5mi', 'd4la', 'c5do', 'd4la', 'c4si', 'd4la', 'c5do', 'd4la', 'd4si', 'c4sol', 'r---', 'fin' );

my @chocobo;
@chocobo = ( 'n5re', 'c4si', 'c4sol', 'c4mi', 'c5re', 'c4si', 'c4sol', 'd4si', 'c--.', 'c4sol', 'c---', 'n4si.', 'c4la', 'c4sol', 'd4sol', 'd4la', 'c4sol', 'c4fa', 'n4sol.', 'c4fa', 'c4sol', 'd4sol', 'd4si', 'c5re', 'c5mi', 'n5fa.', 'c---', 'n5re', 'c4si', 'c4sol', 'c4mi', 'c5re', 'c4si', 'c4sol', 'd4si', 'c--.', 'c4sol', 'c---', 'n4si.', 'c4la', 'c4sol', 'd4sol', 'd4la', 'c4sol', 'c4fa', 'n4sol.', 'c4fa', 'c4sol', 'd4sol', 'd4si', 'c5re', 'c5mi', 'n5fa.', 'c---', 'd5mi', 'c--.', 'c5do', 'c4la', 'c4fa', 'c4la', 'c5do', 'c5mi', 'd5re', 'c--.', 'd5sol', 'c--.', 'n5re.', 'c4si', 'd5do', 'c--.', 'c4la', 'c4fa', 'c4re', 'c4fa', 'c4la', 'c5do', 'c4si', 'd4si', 'd5do', 'c4si', 'c4la', 'n4si.', 'c---', 'd5mi', 'c--.', 'c5do', 'c4la', 'c4fa', 'c4la', 'c5do', 'c5mi', 'd5re', 'c--.', 'd5sol', 'c--.', 'n5re.', 'c4si', 'c4la', 'd4la', 'd4si', 'c4la', 'c4sol', 'n4la.', 'c4sol', 'c4la', 'd4la', 'd4si', 'c5do', 'c5re', 'n5mi', 'n5fa', 'd5sol', 'r---', 'fin');

my @tetris;
@tetris = ( 'n5mi', 'c4si', 'c5do', 'c5re', 'd5mi', 'd5re', 'c5do', 'c4si', 'n4la', 'c4la', 'c5do', 'n5mi', 'c5re', 'c5do', 'n4si.', 'c5do', 'n5re', 'n5mi', 'n5do', 'n4la', 'b4la', 'c---', 'n5re', 'c5fa', 'n5la', 'c5sol', 'c5fa', 'n5mi.', 'c5do', 'n5mi', 'c5re', 'c5do', 'n4si', 'c4si', 'c5do', 'n5re', 'n5mi', 'n5do', 'n4la', 'n4la', 'n---', 'n5mi', 'c4si', 'c5do', 'c5re', 'd5mi', 'd5re', 'c5do', 'c4si', 'n4la', 'c4la', 'c5do', 'n5mi', 'c5re', 'c5do', 'n4si.', 'c5do', 'n5re', 'n5mi', 'n5do', 'n4la', 'b4la', 'c---', 'n5re', 'c5fa', 'n5la', 'c5sol', 'c5fa', 'n5mi.', 'c5do', 'n5mi', 'c5re', 'c5do', 'n4si', 'c4si', 'c5do', 'n5re', 'n5mi', 'n5do', 'n4la', 'n4la', 'n---', 'b4mi', 'b4do', 'b4re', 'b3si', 'b4do', 'b3la', 'b3sol', 'n3si', 'n---', 'b4mi', 'b4do', 'b4re', 'b3si', 'n4do', 'n4mi', 'b4la', 'b4sol', 'b---', 'n5mi', 'c4si', 'c5do', 'c5re', 'd5mi', 'd5re', 'c5do', 'c4si', 'n4la', 'c4la', 'c5do', 'n5mi', 'c5re', 'c5do', 'n4si.', 'c5do', 'n5re', 'n5mi', 'n5do', 'n4la', 'b4la', 'c---', 'n5mi.', 'c5do', 'n5mi', 'c5re', 'c5do', 'n4si', 'n5do', 'n4la', 'n4la', 'n---', 'n5mi', 'c4si', 'c5do', 'c5re', 'd5mi', 'd5re', 'c5do', 'c4si', 'n4la', 'c4la', 'c5do', 'n5mi', 'c5re', 'c5do', 'n4si.', 'n5do', 'n4la', 'b4la', 'c---', 'n5re', 'c5fa', 'n5la', 'c5sol', 'c5fa', 'n5mi.', 'c5do', 'n5mi', 'c5re', 'c5do', 'n4si', 'c4si', 'c5do', 'n5re', 'n5mi', 'n5do', 'n4la', 'n4la', 'r---', 'fin');

my @marseillaise;
@marseillaise = (
'c4re', 'c4re', 'c4re', 'n4sol', 'n4sol', 'n4la', 'n4la', 'n5re.', 'c4si', 'c4sol', 'c4sol', 'c4si', 'c4sol',
'n4mi', 'b5do', 'c4la', 'd4fa', 'b4sol', 'n---', 'c4sol', 'c4la', 'n4si', 'n4si', 'n4si', 'c5do', 'c4si', 'c4si', 'c4la', 'n4la', 'n---', 'c4la', 'c4si',
'n5do', 'n5do', 'n5do', 'c5re', 'c5do', 'b4si', 'n---', 'c5re', 'c5re', 'n5re', 'c4si', 'c4sol', 'n5re', 'c4si', 'c4sol', 'b4re', 'c---', 'c4re', 'c4re', 'c4re',
'b4la', 'n5do', 'c4la', 'c4fa', 'n4sol', 'n4sol', 'b4fa', 'n4mi', 'c4sol', 'c4sol', 'n4sol', 'c4fa', 'c4sol', 'b4la', 'n---', 'c---',
'n4si.', 'c4si', 'c4la', 'c4si', 'c5do', 'c4si', 'b4la', 'n---', 'c4si', 'c4la', 'n4sol.', 'c4sol', 'c4sol', 'c4si', 'c4la', 'c4sol', 'c4sol', 'c4fa', 'n4fa', 'fin'
); 

open(COE, ">melody.coe");
print COE "memory_initialization_radix=16;\nmemory_initialization_vector=\n";


my $note;
my $temps;
my $place = 1;
foreach((@chocobo, @mortal, @tetris, @mario, @marseillaise))
{
	$temps = 0;
	$temps = 1 if substr($_, 0, 1) eq 'd';
	$temps = 2 if substr($_, 0, 1) eq 'c';
	$temps = 4 if substr($_, 0, 1) eq 'n';
	$temps = 8 if substr($_, 0, 1) eq 'b';
	$temps = 16 if substr($_, 0, 1) eq 'r';
	$temps = $temps*3/2 if substr($_,-1) eq '.';
	
	   if ($_ eq 'fin') { printf (" - %012b\n", $place);$temps =1; $note = '08'} # Cas de fin de morceaux
	elsif (substr($_,1,3) eq '2do')	{ $note = '01'; }
	elsif (substr($_,1,3) eq '2re')	{ $note = '02'; }
	elsif (substr($_,1,3) eq '2mi')	{ $note = '03'; }
	elsif (substr($_,1,3) eq '2fa')	{ $note = '04'; }
	elsif (substr($_,1,3) eq '2so')	{ $note = '05'; }
	elsif (substr($_,1,3) eq '2la')	{ $note = '06'; }
	elsif (substr($_,1,3) eq '2si')	{ $note = '07'; }
	elsif (substr($_,1,3) eq '3do')	{ $note = '09'; }
	elsif (substr($_,1,3) eq '3re')	{ $note = '0A'; }
	elsif (substr($_,1,3) eq '3mi') { $note = '0B'; }
	elsif (substr($_,1,3) eq '3fa')	{ $note = '0C'; }
	elsif (substr($_,1,3) eq '3so')	{ $note = '0D'; }
	elsif (substr($_,1,3) eq '3la')	{ $note = '0E'; }
	elsif (substr($_,1,3) eq '3si')	{ $note = '0F'; }
	elsif (substr($_,1,3) eq '4do')	{ $note = '11'; }
	elsif (substr($_,1,3) eq '4re')	{ $note = '12'; }
	elsif (substr($_,1,3) eq '4mi')	{ $note = '13'; }
	elsif (substr($_,1,3) eq '4fa')	{ $note = '14'; }
	elsif (substr($_,1,3) eq '4so')	{ $note = '15'; }
	elsif (substr($_,1,3) eq '4la')	{ $note = '16'; }
	elsif (substr($_,1,3) eq '4si')	{ $note = '17'; }
	elsif (substr($_,1,3) eq '5do')	{ $note = '19'; }
	elsif (substr($_,1,3) eq '5re')	{ $note = '1A'; }
	elsif (substr($_,1,3) eq '5mi')	{ $note = '1B'; }
	elsif (substr($_,1,3) eq '5fa')	{ $note = '1C'; }
	elsif (substr($_,1,3) eq '5so')	{ $note = '1D'; }
	elsif (substr($_,1,3) eq '5la')	{ $note = '1E'; }
	elsif (substr($_,1,3) eq '5si')	{ $note = '1F'; }
	else							{ $note = '00'; }
	
	for(my $i=0; $i<$temps; $i++)
	{
		print COE $note . ",\n";
		$place++;
	}
	print COE "00,\n";
	$place++;
}
print COE "10,"; # Flag de restart

close(COE);


