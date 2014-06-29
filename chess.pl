#!/usr/bin/perl

######
#
#	6/29/2014
#	Author: Danny Antaki
#
#	Version 1.0
#
#	Parses PGN scripts and outputs position frequencies for queen, rook, bishop,and knight
#		pieces for each win, draw, or loss game playing as white or black.
#
#
######

use strict;

my $pgn = "/Users/dantaki/Desktop/kasparov/Kasparov.pgn"; #	change this directory. Input PGN

open IN, $pgn or die "Cannot open PGN file\n"; 

my @name = split /\//,$pgn;
my $name = pop(@name);
$name =~  s/\.pgn$//;

print $name."\n";

my $blackTest = "Black \"".$name;
my $whiteTest = "White \"".$name;

my @black;
my @white;
my $blackSwitch=0;
my $whiteSwitch=0;

my @tempBlack;
my @tempWhite;

while(<IN>){ # This while loop iterates line by line
	chomp $_;
	$_ =~ s/\R//g;
	
	
	if($blackSwitch == 1 && $_ =~ m /\[Event/ )   {
	
		$blackSwitch=0;
		
		my $temp = join "\n", @tempBlack;
		push @black, $temp;
		
		undef $temp;
		undef @tempBlack;
	
	}
	
	if($whiteSwitch == 1 && $_ =~ m /\[Event/ )   {
	
		$whiteSwitch=0;
		
		my $temp = join "\n", @tempWhite;
		push @white, $temp;
		
		undef $temp;
		undef @tempWhite;
	
	}
	
	if($blackSwitch==1){
		push @tempBlack,$_;		
	}
	
	if($whiteSwitch==1){
		push @tempWhite,$_;		
	}
	
	if ($blackSwitch == 0 && $_ =~ /$blackTest/g){ 
		$blackSwitch=1;
		push @tempBlack, $_;
	}
	
	if ($whiteSwitch == 0 && $_ =~ m/$whiteTest/){
		$whiteSwitch=1;
		push @tempWhite, $_;
	}  
	
}

&black(@black); #	This is how perl does OOP
&white(@white);

########## SUBROUTINE ##########

sub black {

my %gameCount;

my %qWin;
my %qDraw;
my %qLoss;

my %rWin;
my %rDraw;
my %rLoss;

my %bWin;
my %bDraw;
my %bLoss;

my %nWin;
my %nDraw;
my %nLoss;

my @game;
my $gameResult;

	foreach(@_){
	
		undef @game;
		my @temp = split /\n/, $_;
		
		$gameResult = $temp[1];
		
		for(my $i=6;$i<scalar(@temp);$i++){
			push @game, $temp[$i];
		}
		
		my $tempGame = join " ", @game;
		@game = split /\./,$tempGame;
					
		if($gameResult eq "[Result \"0-1\"]") { 
			#WIN 
			
			$gameCount{$gameResult}++;
			
			foreach(@game){
			
				my @tempGame = split / /, $_;
				my $move = $tempGame[1]; 
				
				chomp $move;
				$move =~ s/ //g;
				
				if ($move eq 'O-O'){
					my $key = "g7";
					$rWin{$key}++;
				}
				
				if($move eq 'O-O-O'){
					my $key = "c7";
					$rWin{$key}++;
				}
				
				if (length($move) == 3){
					my @move = split //, $move;
					my $key = join "", $move[1],$move[2];
					
					if($move[0] eq "Q"){
						$qWin{$key}++;
					}
					
					if($move[0] eq "R"){
						$rWin{$key}++;
					}
					
					if($move[0] eq "B"){
						$bWin{$key}++;
					}
					
					if($move[0] eq "N"){
						$nWin{$key}++;
					}
					
				}
				
				
				if(length($move) > 3){
					my @move = split //, $move;
					
					
					if ($move !~ m/x/g){
						if($move[scalar(@move)-1] eq "+"){
							my $key = join "", $move[scalar(@move)-3],$move[scalar(@move)-2];
								
							if($move[0] eq "Q"){
								$qWin{$key}++;
							}
					
							if($move[0] eq "R"){
								$rWin{$key}++;
							}
				
							if($move[0] eq "B"){
								$bWin{$key}++;
							}
				
							if($move[0] eq "N"){
								$nWin{$key}++;
							}
								
						} else {
							my $key = join "", $move[scalar(@move)-2],$move[scalar(@move)-1];
						
							if($move[0] eq "Q"){
								$qWin{$key}++;
							}
					
							if($move[0] eq "R"){
								$rWin{$key}++;
							}
					
							if($move[0] eq "B"){
								$bWin{$key}++;
							}
					
							if($move[0] eq "N"){
								$nWin{$key}++;
							}
						
						
						}
						
					}
					
					for (my $k=0; $k<scalar(@move); $k++){
						
						if($move[$k] eq "x"){
							my $key = join "", $move[$k+1],$move[$k+2];
							
							if($move[0] eq "Q"){
								$qWin{$key}++;
							}
					
							if($move[0] eq "R"){
								$rWin{$key}++;
							}
					
							if($move[0] eq "B"){
								$bWin{$key}++;
							}
					
							if($move[0] eq "N"){
								$nWin{$key}++;
							}
							
						}
						
						
					}
				}
			}
		}
		
		if($gameResult eq "[Result \"1-0\"]") { 
			#LOSS
			
			$gameCount{$gameResult}++;
			
			foreach(@game){
			
				my @tempGame = split / /, $_;
				my $move = $tempGame[1]; 
				
				chomp $move;
				$move =~ s/ //g;
				
				if ($move eq 'O-O'){
					my $key = "g7";
					$rLoss{$key}++;
				}
				
				if($move eq 'O-O-O'){
					my $key = "c7";
					$rLoss{$key}++;
				}
				
				if (length($move) == 3){
					my @move = split //, $move;
					my $key = join "", $move[1],$move[2];
					
					if($move[0] eq "Q"){
						$qLoss{$key}++;
					}
					
					if($move[0] eq "R"){
						$rLoss{$key}++;
					}
					
					if($move[0] eq "B"){
						$bLoss{$key}++;
					}
					
					if($move[0] eq "N"){
						$nLoss{$key}++;
					}
					
				}
				
				
				if(length($move) > 3){
					my @move = split //, $move;
					
					
					if ($move !~ m/x/g){
						if($move[scalar(@move)-1] eq "+"){
							my $key = join "", $move[scalar(@move)-3],$move[scalar(@move)-2];
								
							if($move[0] eq "Q"){
								$qLoss{$key}++;
							}
					
							if($move[0] eq "R"){
								$rLoss{$key}++;
							}
				
							if($move[0] eq "B"){
								$bLoss{$key}++;
							}
				
							if($move[0] eq "N"){
								$nLoss{$key}++;
							}
								
						} else {
							my $key = join "", $move[scalar(@move)-2],$move[scalar(@move)-1];
						
							if($move[0] eq "Q"){
								$qLoss{$key}++;
							}
					
							if($move[0] eq "R"){
								$rLoss{$key}++;
							}
					
							if($move[0] eq "B"){
								$bLoss{$key}++;
							}
					
							if($move[0] eq "N"){
								$nLoss{$key}++;
							}
						
						
						}
						
					}
					
					for (my $k=0; $k<scalar(@move); $k++){
						
						if($move[$k] eq "x"){
							my $key = join "", $move[$k+1],$move[$k+2];
							
							if($move[0] eq "Q"){
								$qLoss{$key}++;
							}
					
							if($move[0] eq "R"){
								$rLoss{$key}++;
							}
					
							if($move[0] eq "B"){
								$bLoss{$key}++;
							}
					
							if($move[0] eq "N"){
								$nLoss{$key}++;
							}
							
						}
						
						
					}
				}
			}
			
		}
		
		if($gameResult eq "[Result \"1/2-1/2\"]") { 
			#DRAW
			
			$gameCount{$gameResult}++;
			
			foreach(@game){
			
				my @tempGame = split / /, $_;
				my $move = $tempGame[1]; 
				
				chomp $move;
				$move =~ s/ //g;
				
				if ($move eq 'O-O'){
					my $key = "g7";
					$rDraw{$key}++;
				}
				
				if($move eq 'O-O-O'){
					my $key = "c7";
					$rDraw{$key}++;
				}
				
				if (length($move) == 3){
					my @move = split //, $move;
					my $key = join "", $move[1],$move[2];
					
					if($move[0] eq "Q"){
						$qDraw{$key}++;
					}
					
					if($move[0] eq "R"){
						$rDraw{$key}++;
					}
					
					if($move[0] eq "B"){
						$bDraw{$key}++;
					}
					
					if($move[0] eq "N"){
						$nDraw{$key}++;
					}
					
				}
				
				
				if(length($move) > 3){
					my @move = split //, $move;
					
					
					if ($move !~ m/x/g){
						if($move[scalar(@move)-1] eq "+"){
							my $key = join "", $move[scalar(@move)-3],$move[scalar(@move)-2];
								
							if($move[0] eq "Q"){
								$qDraw{$key}++;
							}
					
							if($move[0] eq "R"){
								$rDraw{$key}++;
							}
				
							if($move[0] eq "B"){
								$bDraw{$key}++;
							}
				
							if($move[0] eq "N"){
								$nDraw{$key}++;
							}
								
						} else {
							my $key = join "", $move[scalar(@move)-2],$move[scalar(@move)-1];
						
							if($move[0] eq "Q"){
								$qDraw{$key}++;
							}
					
							if($move[0] eq "R"){
								$rDraw{$key}++;
							}
					
							if($move[0] eq "B"){
								$bDraw{$key}++;
							}
					
							if($move[0] eq "N"){
								$nDraw{$key}++;
							}
						
						
						}
						
					}
					
					for (my $k=0; $k<scalar(@move); $k++){
						
						if($move[$k] eq "x"){
							my $key = join "", $move[$k+1],$move[$k+2];
							
							if($move[0] eq "Q"){
								$qDraw{$key}++;
							}
					
							if($move[0] eq "R"){
								$rDraw{$key}++;
							}
					
							if($move[0] eq "B"){
								$bDraw{$key}++;
							}
					
							if($move[0] eq "N"){
								$nDraw{$key}++;
							}
							
						}
						
						
					}
				}
			}
			
		}
		
	}
	
	
	open OUT, ">/Users/dantaki/Desktop/kasparov_black_wins.txt"; # 	change this for output
	print OUT "position\tQueen\tRook\tBishop\tKnight\n";
	
	for (my $file=1; $file<=8; $file++){
		my $outfile;
		
		if ($file == 1) { $outfile = "a"; }
		if ($file == 2) { $outfile = "b"; }
		if ($file == 3) { $outfile = "c"; }
		if ($file == 4) { $outfile = "d"; }
		if ($file == 5) { $outfile = "e"; }
		if ($file == 6) { $outfile = "f"; }
		if ($file == 7) { $outfile = "g"; }
		if ($file == 8) { $outfile = "h"; }
		
		for (my $rank=1; $rank<=8; $rank++){
			
			my $key = join "", $outfile,$rank;
			
			print OUT $key."\t";
			
			if ( exists($qWin{$key})){
				
				print OUT $qWin{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			if ( exists($rWin{$key})){
				
				print OUT $rWin{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			if ( exists($bWin{$key})){
				
				print OUT $bWin{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			if ( exists($nWin{$key})){
				
				print OUT $nWin{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			print OUT "\n";
		
		
		}
		
		 
	} 
	
	close(OUT);
	
	open OUT, ">/Users/dantaki/Desktop/kasparov_black_loss.txt"; # 	change this for output
	print OUT "position\tQueen\tRook\tBishop\tKnight\n";
	
	for (my $file=1; $file<=8; $file++){
		my $outfile;
		
		if ($file == 1) { $outfile = "a"; }
		if ($file == 2) { $outfile = "b"; }
		if ($file == 3) { $outfile = "c"; }
		if ($file == 4) { $outfile = "d"; }
		if ($file == 5) { $outfile = "e"; }
		if ($file == 6) { $outfile = "f"; }
		if ($file == 7) { $outfile = "g"; }
		if ($file == 8) { $outfile = "h"; }
		
		for (my $rank=1; $rank<=8; $rank++){
			
			my $key = join "", $outfile,$rank;
			
			print OUT $key."\t";
			
			if ( exists($qLoss{$key})){
				
				print OUT $qLoss{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			if ( exists($rLoss{$key})){
				
				print OUT $rLoss{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			if ( exists($bLoss{$key})){
				
				print OUT $bLoss{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			if ( exists($nLoss{$key})){
				
				print OUT $nLoss{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			print OUT "\n";
		
		
		}
		
		 
	} 
	
	close(OUT);
	
	open OUT, ">/Users/dantaki/Desktop/kasparov_black_draw.txt"; # 	change this for output
	print OUT "position\tQueen\tRook\tBishop\tKnight\n";
	
	for (my $file=1; $file<=8; $file++){
		my $outfile;
		
		if ($file == 1) { $outfile = "a"; }
		if ($file == 2) { $outfile = "b"; }
		if ($file == 3) { $outfile = "c"; }
		if ($file == 4) { $outfile = "d"; }
		if ($file == 5) { $outfile = "e"; }
		if ($file == 6) { $outfile = "f"; }
		if ($file == 7) { $outfile = "g"; }
		if ($file == 8) { $outfile = "h"; }
		
		for (my $rank=1; $rank<=8; $rank++){
			
			my $key = join "", $outfile,$rank;
			
			print OUT $key."\t";
			
			if ( exists($qDraw{$key})){
				
				print OUT $qDraw{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			if ( exists($rDraw{$key})){
				
				print OUT $rDraw{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			if ( exists($bDraw{$key})){
				
				print OUT $bDraw{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			if ( exists($nDraw{$key})){
				
				print OUT $nDraw{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			print OUT "\n";
		
		
		}
		
		 
	} 
	
	close(OUT);
	
	open OUT, ">/Users/dantaki/Desktop/kasparov_black_game_count.txt"; # 	change this for output
	
	foreach my $key (sort keys %gameCount){
		print OUT $key."\t".$gameCount{$key}."\n";
	}
	close (OUT);
	
}

sub white {

my %gameCount; 

my %qWin;
my %qDraw;
my %qLoss;

my %rWin;
my %rDraw;
my %rLoss;

my %bWin;
my %bDraw;
my %bLoss;

my %nWin;
my %nDraw;
my %nLoss;

my @game;
my $gameResult;

	foreach(@_){
	
		undef @game;
		my @temp = split /\n/, $_;
		
		$gameResult = $temp[2];
		
		for(my $i=6;$i<scalar(@temp);$i++){
			push @game, $temp[$i];
		}
		
		my $tempGame = join " ", @game;
		@game = split /\./,$tempGame;
					
		if($gameResult eq "[Result \"0-1\"]") { 
			#WIN 
			
			$gameCount{$gameResult}++;

			foreach(@game){
			
				my @tempGame = split / /, $_;
				my $move = $tempGame[0]; 
				
				chomp $move;
				$move =~ s/ //g;
				
				if ($move eq 'O-O'){
					my $key = "g1";
					$rWin{$key}++;
				}
				
				if($move eq 'O-O-O'){
					my $key = "c1";
					$rWin{$key}++;
				}
				
				if (length($move) == 3){
					my @move = split //, $move;
					my $key = join "", $move[1],$move[2];
					
					if($move[0] eq "Q"){
						$qWin{$key}++;

					}
					
					if($move[0] eq "R"){
						$rWin{$key}++;
					}
					
					if($move[0] eq "B"){
						$bWin{$key}++;
					}
					
					if($move[0] eq "N"){
						$nWin{$key}++;
					}
					
				}
				
				
				if(length($move) > 3){
					my @move = split //, $move;
					
					
					if ($move !~ m/x/g){
						if($move[scalar(@move)-1] eq "+"){
							my $key = join "", $move[scalar(@move)-3],$move[scalar(@move)-2];
								
							if($move[0] eq "Q"){
								$qWin{$key}++;
							}
					
							if($move[0] eq "R"){
								$rWin{$key}++;
							}
				
							if($move[0] eq "B"){
								$bWin{$key}++;
							}
				
							if($move[0] eq "N"){
								$nWin{$key}++;
							}
								
						} else {
							my $key = join "", $move[scalar(@move)-2],$move[scalar(@move)-1];
						
							if($move[0] eq "Q"){
								$qWin{$key}++;
							}
					
							if($move[0] eq "R"){
								$rWin{$key}++;
							}
					
							if($move[0] eq "B"){
								$bWin{$key}++;
							}
					
							if($move[0] eq "N"){
								$nWin{$key}++;
							}
						
						
						}
						
					}
					
					for (my $k=0; $k<scalar(@move); $k++){
						
						if($move[$k] eq "x"){
							my $key = join "", $move[$k+1],$move[$k+2];
							
							if($move[0] eq "Q"){
								$qWin{$key}++;
							}
					
							if($move[0] eq "R"){
								$rWin{$key}++;
							}
					
							if($move[0] eq "B"){
								$bWin{$key}++;
							}
					
							if($move[0] eq "N"){
								$nWin{$key}++;
							}
							
						}
						
						
					}
				}
			}
		}
		
		if($gameResult eq "[Result \"1-0\"]") { 
			#LOSS
			
			$gameCount{$gameResult}++;

			foreach(@game){
			
				my @tempGame = split / /, $_;
				my $move = $tempGame[0]; 
				
				chomp $move;
				$move =~ s/ //g;
				
				if ($move eq 'O-O'){
					my $key = "g1";
					$rLoss{$key}++;
				}
				
				if($move eq 'O-O-O'){
					my $key = "c1";
					$rLoss{$key}++;
				}
				
				if (length($move) == 3){
					my @move = split //, $move;
					my $key = join "", $move[1],$move[2];
					
					if($move[0] eq "Q"){
						$qLoss{$key}++;
					}
					
					if($move[0] eq "R"){
						$rLoss{$key}++;
					}
					
					if($move[0] eq "B"){
						$bLoss{$key}++;
					}
					
					if($move[0] eq "N"){
						$nLoss{$key}++;
					}
					
				}
				
				
				if(length($move) > 3){
					my @move = split //, $move;
					
					
					if ($move !~ m/x/g){
						if($move[scalar(@move)-1] eq "+"){
							my $key = join "", $move[scalar(@move)-3],$move[scalar(@move)-2];
								
							if($move[0] eq "Q"){
								$qLoss{$key}++;
							}
					
							if($move[0] eq "R"){
								$rLoss{$key}++;
							}
				
							if($move[0] eq "B"){
								$bLoss{$key}++;
							}
				
							if($move[0] eq "N"){
								$nLoss{$key}++;
							}
								
						} else {
							my $key = join "", $move[scalar(@move)-2],$move[scalar(@move)-1];
						
							if($move[0] eq "Q"){
								$qLoss{$key}++;
							}
					
							if($move[0] eq "R"){
								$rLoss{$key}++;
							}
					
							if($move[0] eq "B"){
								$bLoss{$key}++;
							}
					
							if($move[0] eq "N"){
								$nLoss{$key}++;
							}
						
						
						}
						
					}
					
					for (my $k=0; $k<scalar(@move); $k++){
						
						if($move[$k] eq "x"){
							my $key = join "", $move[$k+1],$move[$k+2];
							
							if($move[0] eq "Q"){
								$qLoss{$key}++;
							}
					
							if($move[0] eq "R"){
								$rLoss{$key}++;
							}
					
							if($move[0] eq "B"){
								$bLoss{$key}++;
							}
					
							if($move[0] eq "N"){
								$nLoss{$key}++;
							}
							
						}
						
						
					}
				}
			}
			
		}
		
		if($gameResult eq "[Result \"1/2-1/2\"]") { 
			#DRAW
			
			$gameCount{$gameResult}++;

			
			foreach(@game){
			
				my @tempGame = split / /, $_;
				my $move = $tempGame[0]; 
				
				chomp $move;
				$move =~ s/ //g;
				
				if ($move eq 'O-O'){
					my $key = "g1";
					$rDraw{$key}++;
				}
				
				if($move eq 'O-O-O'){
					my $key = "c1";
					$rDraw{$key}++;
				}
				
				if (length($move) == 3){
					my @move = split //, $move;
					my $key = join "", $move[1],$move[2];
					
					if($move[0] eq "Q"){
						$qDraw{$key}++;
					}
					
					if($move[0] eq "R"){
						$rDraw{$key}++;
					}
					
					if($move[0] eq "B"){
						$bDraw{$key}++;
					}
					
					if($move[0] eq "N"){
						$nDraw{$key}++;
					}
					
				}
				
				
				if(length($move) > 3){
					my @move = split //, $move;
					
					
					if ($move !~ m/x/g){
						if($move[scalar(@move)-1] eq "+"){
							my $key = join "", $move[scalar(@move)-3],$move[scalar(@move)-2];
								
							if($move[0] eq "Q"){
								$qDraw{$key}++;
							}
					
							if($move[0] eq "R"){
								$rDraw{$key}++;
							}
				
							if($move[0] eq "B"){
								$bDraw{$key}++;
							}
				
							if($move[0] eq "N"){
								$nDraw{$key}++;
							}
								
						} else {
							my $key = join "", $move[scalar(@move)-2],$move[scalar(@move)-1];
						
							if($move[0] eq "Q"){
								$qDraw{$key}++;
							}
					
							if($move[0] eq "R"){
								$rDraw{$key}++;
							}
					
							if($move[0] eq "B"){
								$bDraw{$key}++;
							}
					
							if($move[0] eq "N"){
								$nDraw{$key}++;
							}
						
						
						}
						
					}
					
					for (my $k=0; $k<scalar(@move); $k++){
						
						if($move[$k] eq "x"){
							my $key = join "", $move[$k+1],$move[$k+2];
							
							if($move[0] eq "Q"){
								$qDraw{$key}++;
							}
					
							if($move[0] eq "R"){
								$rDraw{$key}++;
							}
					
							if($move[0] eq "B"){
								$bDraw{$key}++;
							}
					
							if($move[0] eq "N"){
								$nDraw{$key}++;
							}
							
						}
						
						
					}
				}
			}
			
		}
		
	}
	
	
	open OUT, ">/Users/dantaki/Desktop/kasparov_white_wins.txt"; # 	change this for output
	print OUT "position\tQueen\tRook\tBishop\tKnight\n";
	
	for (my $file=1; $file<=8; $file++){
		my $outfile;
		
		if ($file == 1) { $outfile = "a"; }
		if ($file == 2) { $outfile = "b"; }
		if ($file == 3) { $outfile = "c"; }
		if ($file == 4) { $outfile = "d"; }
		if ($file == 5) { $outfile = "e"; }
		if ($file == 6) { $outfile = "f"; }
		if ($file == 7) { $outfile = "g"; }
		if ($file == 8) { $outfile = "h"; }
		
		for (my $rank=1; $rank<=8; $rank++){
			
			my $key = join "", $outfile,$rank;
			
			print OUT $key."\t";
			
			if ( exists($qWin{$key})){
				
				print OUT $qWin{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			if ( exists($rWin{$key})){
				
				print OUT $rWin{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			if ( exists($bWin{$key})){
				
				print OUT $bWin{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			if ( exists($nWin{$key})){
				
				print OUT $nWin{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			print OUT "\n";
		
		
		}
		
		 
	} 
	
	close(OUT);
	
	open OUT, ">/Users/dantaki/Desktop/kasparov_white_loss.txt"; # 	change this for output
	print OUT "position\tQueen\tRook\tBishop\tKnight\n";
	
	for (my $file=1; $file<=8; $file++){
		my $outfile;
		
		if ($file == 1) { $outfile = "a"; }
		if ($file == 2) { $outfile = "b"; }
		if ($file == 3) { $outfile = "c"; }
		if ($file == 4) { $outfile = "d"; }
		if ($file == 5) { $outfile = "e"; }
		if ($file == 6) { $outfile = "f"; }
		if ($file == 7) { $outfile = "g"; }
		if ($file == 8) { $outfile = "h"; }
		
		for (my $rank=1; $rank<=8; $rank++){
			
			my $key = join "", $outfile,$rank;
			
			print OUT $key."\t";
			
			if ( exists($qLoss{$key})){
				
				print OUT $qLoss{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			if ( exists($rLoss{$key})){
				
				print OUT $rLoss{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			if ( exists($bLoss{$key})){
				
				print OUT $bLoss{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			if ( exists($nLoss{$key})){
				
				print OUT $nLoss{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			print OUT "\n";
		
		
		}
		
		 
	} 
	
	close(OUT);
	
	open OUT, ">/Users/dantaki/Desktop/kasparov_white_draw.txt"; # 	change this for output
	print OUT "position\tQueen\tRook\tBishop\tKnight\n";
	
	for (my $file=1; $file<=8; $file++){
		my $outfile;
		
		if ($file == 1) { $outfile = "a"; }
		if ($file == 2) { $outfile = "b"; }
		if ($file == 3) { $outfile = "c"; }
		if ($file == 4) { $outfile = "d"; }
		if ($file == 5) { $outfile = "e"; }
		if ($file == 6) { $outfile = "f"; }
		if ($file == 7) { $outfile = "g"; }
		if ($file == 8) { $outfile = "h"; }
		
		for (my $rank=1; $rank<=8; $rank++){
			
			my $key = join "", $outfile,$rank;
			
			print OUT $key."\t";
			
			if ( exists($qDraw{$key})){
				
				print OUT $qDraw{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			if ( exists($rDraw{$key})){
				
				print OUT $rDraw{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			if ( exists($bDraw{$key})){
				
				print OUT $bDraw{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			if ( exists($nDraw{$key})){
				
				print OUT $nDraw{$key}."\t";
				
			} else {
				print OUT "0\t";
			}
			
			print OUT "\n";
		
		
		}
		
		 
	} 
	
	close(OUT);
	
		
	open OUT, ">/Users/dantaki/Desktop/kasparov_white_game_count.txt"; # 	change this for output
	
	foreach my $key (sort keys %gameCount){
		print OUT $key."\t".$gameCount{$key}."\n";
	}
	close (OUT);
	
}