use strict;
use warnings;

use Image::Magick;
my $folder = "abc"; 

my $p = new Image::Magick;
my @pixels;

open(COE, ">keyboard.coe");
print COE "memory_initialization_radix=2;\nmemory_initialization_vector=\n";

foreach my $i(0..77)
{
	$p = new Image::Magick;
	$p->Read("$folder/$i.jpg");
	@pixels = $p->GetPixels(
		width     => 7,
		height    => 7,
		x         => 0,
		y         => 0,
		map       => 'I',
		#normalize => 1
	);
	
	foreach(@pixels)
	{
		printf COE ("0,\n") if $_<30000;
		printf COE ("1,\n") if $_>30000;
	}
}

close(COE);