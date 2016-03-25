use strict;
use warnings;

use Image::Magick;

my $p = new Image::Magick;
$p->Read("image.jpg");
 
my @pixels;
@pixels = $p->GetPixels(
    width     => 160,
    height    => 120,
    x         => 0,
    y         => 0,
    map       => 'RGB',
    #normalize => 1
);

open(COE, ">rom.coe");
print COE "memory_initialization_radix=2;\nmemory_initialization_vector=\n";
my $i = 1;
foreach(@pixels)
{
	if ($i%3 == 0)
	{
		printf COE ("%02b,\n", $_/16384);
	}
	else
	{
		printf COE ("%03b", $_/8192);
	}
	$i++;
}

close(COE);

