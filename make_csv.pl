#!/usr/bin/perl

use strict;
use warnings;

#####
#
# 6/29/2014
#	Author: Danny Antaki
#
#	Parses output files from chess.pl and makes CSVs of frequency matrices
#
#	This script takes two files, white and black. Change the directories to indicate game status 
#
#####


open IN, "/Users/dantaki/Desktop/kasparov/kasparov_white_wins.txt";

my $header = <IN>;

my @toHopper;

while(<IN>){
	chomp $_;
	push @toHopper,$_;
}
close(IN);

my ($queen,$rook,$bishop,$knight) = &positionHopper(@toHopper);

&whiteMatrix(\%$queen,\%$rook,\%$bishop,\%$knight);

open IN, "/Users/dantaki/Desktop/kasparov/kasparov_black_wins.txt";

$header = <IN>;

while(<IN>){
	chomp $_;
	push @toHopper,$_;
}
close(IN);

($queen,$rook,$bishop,$knight) = &positionHopper(@toHopper);

&blackMatrix(\%$queen,\%$rook,\%$bishop,\%$knight);


########## subroutine ########

sub positionHopper {

	my %queen;
	my %rook;
	my %bishop;
	my %knight;
		
	foreach (@_){
		my @pos = split /\t/, $_;
		
		$queen{$pos[0]}=$pos[1];
		$rook{$pos[0]}=$pos[2];
		$bishop{$pos[0]}=$pos[3];
		$knight{$pos[0]}=$pos[4];
		
	}
	
	return (\%queen,\%rook,\%bishop,\%knight); 
}

sub whiteMatrix {

	my ($queen,$rook,$bishop,$knight) = @_;
	
	my %queen = %$queen;
	my %rook = %$rook;
	my %bishop = %$bishop;
	my %knight = %$knight;
	
	open OUT1, ">/Users/dantaki/Desktop/kasparov/white_queen_win_matrix.csv";
	open OUT2, ">/Users/dantaki/Desktop/kasparov/white_rook_win_matrix.csv";
	open OUT3, ">/Users/dantaki/Desktop/kasparov/white_bishop_win_matrix.csv";
	open OUT4, ">/Users/dantaki/Desktop/kasparov/white_knight_win_matrix.csv";

	print OUT1 "rank,a,b,c,d,e,f,g,h\n";
	print OUT2 "rank,a,b,c,d,e,f,g,h\n";
	print OUT3 "rank,a,b,c,d,e,f,g,h\n";
	print OUT4 "rank,a,b,c,d,e,f,g,h\n";
	
	my $outk; 
	
	for(my $i=8;$i>0;$i--){
		
		print OUT1 $i.",";
		print OUT2 $i.",";
		print OUT3 $i.",";
		print OUT4 $i.",";

		for(my $k=1;$k<9;$k++){
	
		if ($k == 1) { $outk = "a"; }
		if ($k == 2) { $outk = "b"; }
		if ($k == 3) { $outk = "c"; }
		if ($k == 4) { $outk = "d"; }
		if ($k == 5) { $outk = "e"; }
		if ($k == 6) { $outk = "f"; }
		if ($k == 7) { $outk = "g"; }
		if ($k == 8) { $outk = "h"; }
			my $key = join "", $outk,$i;
			
			print OUT1 $queen{$key}.",";
			print OUT2 $rook{$key}.",";
			print OUT3 $bishop{$key}.",";
			print OUT4 $knight{$key}.",";
		}
		print OUT1 "\n";
		print OUT2 "\n";
		print OUT3 "\n";
		print OUT4 "\n";
	}
	close(OUT1);
	close(OUT2);
	close(OUT3);
	close(OUT4);
}

sub blackMatrix {

	my ($queen,$rook,$bishop,$knight) = @_;
	
	my %queen = %$queen;
	my %rook = %$rook;
	my %bishop = %$bishop;
	my %knight = %$knight;
	
	open OUT1, ">/Users/dantaki/Desktop/kasparov/black_queen_win_matrix.csv";
	open OUT2, ">/Users/dantaki/Desktop/kasparov/black_rook_win_matrix.csv";
	open OUT3, ">/Users/dantaki/Desktop/kasparov/black_bishop_win_matrix.csv";
	open OUT4, ">/Users/dantaki/Desktop/kasparov/black_knight_win_matrix.csv";

	print OUT1 "rank,a,b,c,d,e,f,g,h\n";
	print OUT2 "rank,a,b,c,d,e,f,g,h\n";
	print OUT3 "rank,a,b,c,d,e,f,g,h\n";
	print OUT4 "rank,a,b,c,d,e,f,g,h\n";
	
	my $outk; 
	
	for(my $i=1;$i<9;$i++){
		
		print OUT1 $i.",";
		print OUT2 $i.",";
		print OUT3 $i.",";
		print OUT4 $i.",";

		for(my $k=1;$k<9;$k++){
	
		if ($k == 1) { $outk = "a"; }
		if ($k == 2) { $outk = "b"; }
		if ($k == 3) { $outk = "c"; }
		if ($k == 4) { $outk = "d"; }
		if ($k == 5) { $outk = "e"; }
		if ($k == 6) { $outk = "f"; }
		if ($k == 7) { $outk = "g"; }
		if ($k == 8) { $outk = "h"; }
			my $key = join "", $outk,$i;
						
			print OUT1 $queen{$key}.",";
			print OUT2 $rook{$key}.",";
			print OUT3 $bishop{$key}.",";
			print OUT4 $knight{$key}.",";
		}
		print OUT1 "\n";
		print OUT2 "\n";
		print OUT3 "\n";
		print OUT4 "\n";
	}
	close(OUT1);
	close(OUT2);
	close(OUT3);
	close(OUT4);
}