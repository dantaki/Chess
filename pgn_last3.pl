#!/usr/bin/perl -w
use strict;
use Chess::PGN::Parse;

#####
#
#	6/30/2014
#	Author: Danny Antaki
#
#	Version 1.0
#	
#	Improved pgn parser. 
#
#	Requires 
#		
#		-Chess::PGN::Parse package
#
#		-Input file: name_of_player.pgn
#
#	That's it!
#
#####
 
my $filename = "/Users/dantaki/Desktop/kasparov/Kasparov.pgn" || die "filename required\n"; #Change this 
 
my $pgn = new Chess::PGN::Parse $filename or die "can't open [$filename]\n";
 
my @blackWin;
my @blackDraw;
my @blackLoss;

my @whiteWin;
my @whiteDraw;
my @whiteLoss;

my @blackWinTemp;
my @blackDrawTemp;
my @blackLossTemp;

my @whiteWinTemp;
my @whiteDrawTemp;
my @whiteLossTemp;


my @name = split /\//, $filename;
my $id = pop(@name);
$id =~ s/\.pgn$//;

while ($pgn->read_game()) {
	
	if($pgn->black =~ /$id/ig){
        
        undef @blackWinTemp;
        undef @blackDrawTemp;
        undef @blackLossTemp;
        	
    	if($pgn->result eq "0-1"){
        	if ($pgn->parse_game() ) { 
            	for(my $i=1; $i<scalar(@{$pgn->moves}); $i+=2){
					push @blackWinTemp, ${$pgn->moves}[$i];           		
            	}
       		 }
       		
       		for(my $i=(scalar(@blackWinTemp)-4); $i<scalar(@blackWinTemp); $i++){
       			push @blackWin, $blackWinTemp[$i]; 
       		}	
        }
        	
        if($pgn->result eq "1/2-1/2"){
        	if ($pgn->parse_game() ) { 
            	for(my $i=1; $i<scalar(@{$pgn->moves}); $i+=2){
					push @blackDrawTemp, ${$pgn->moves}[$i];           		
            	}
       		}
       		
       		for(my $i=(scalar(@blackDrawTemp)-4); $i<scalar(@blackDrawTemp); $i++){
       			push @blackDraw, $blackDrawTemp[$i]; 
       		}		
        }
        	
        if($pgn->result eq "1-0"){
        	if ($pgn->parse_game() ) { 
           		for(my $i=1; $i<scalar(@{$pgn->moves}); $i+=2){
					push @blackLossTemp, ${$pgn->moves}[$i];           		
            	}
       		 }
       		 
       		 for(my $i=(scalar(@blackLossTemp)-4); $i<scalar(@blackLossTemp); $i++){
       			push @blackLoss, $blackLossTemp[$i]; 
       		}		
        }
    }
    
        
    if($pgn->white =~ /$id/ig){
        
        undef @whiteWinTemp;
        undef @whiteDrawTemp;
        undef @whiteLossTemp;
        
        if($pgn->result eq "1-0"){
        	if ($pgn->parse_game() ) { 
            	for(my $i=0; $i<scalar(@{$pgn->moves}); $i+=2){
					push @whiteWinTemp, ${$pgn->moves}[$i];           		
            	}
       		}
       		
       		for(my $i=(scalar(@whiteWinTemp)-4); $i<scalar(@whiteWinTemp); $i++){
       			push @whiteWin, $whiteWinTemp[$i]; 
       		}	
        }
        	
    	if($pgn->result eq "1/2-1/2"){
        	if ($pgn->parse_game() ) { 
            	for(my $i=0; $i<scalar(@{$pgn->moves}); $i+=2){
					push @whiteDrawTemp, ${$pgn->moves}[$i];           		
            	}
       		}
       		
       		for(my $i=(scalar(@whiteDrawTemp)-4); $i<scalar(@whiteDrawTemp); $i++){
       			push @whiteDraw, $whiteDrawTemp[$i]; 
       		}	
    	}
        	
        if($pgn->result eq "0-1"){
        	if ($pgn->parse_game() ) { 
            	for(my $i=0; $i<scalar(@{$pgn->moves}); $i+=2){
					push @whiteLossTemp, ${$pgn->moves}[$i];           		
            	}
       		 }
       		 
       		 for(my $i=(scalar(@whiteLossTemp)-4); $i<scalar(@whiteLossTemp); $i++){
       			push @whiteLoss, $whiteLossTemp[$i]; 
       		}	
        }
     }    
}

&black(\@blackWin,\@blackDraw,\@blackLoss,$filename);
&white(\@whiteWin,\@whiteDraw,\@whiteLoss,$filename);

########## SUBROUTINES ########

sub black {

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

my @blackWin = @{$_[0]};
my @blackDraw = @{$_[1]};
my @blackLoss = @{$_[2]};
my $filename = $_[3];

my @name = split /\//, $filename;
my $id = pop(@name);
$id =~ s/\.pgn$//;
my $outdirect = join "/", @name;


	foreach(@blackWin){
		
		my $move = $_; 
				
		chomp $move;
		$move =~ s/ //g;
				
		if ($move eq 'O-O'){
			my $key = "f8";
				$rWin{$key}++;
		}
				
		if($move eq 'O-O-O'){
			my $key = "d8";
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

	foreach(@blackDraw){
		
		my $move = $_; 
				
		chomp $move;
		$move =~ s/ //g;
				
		if ($move eq 'O-O'){
			my $key = "f8";
				$rDraw{$key}++;
		}
				
		if($move eq 'O-O-O'){
			my $key = "d8";
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
	
	foreach(@blackLoss){
		
		my $move = $_; 
				
		chomp $move;
		$move =~ s/ //g;
				
		if ($move eq 'O-O'){
			my $key = "f8";
				$rLoss{$key}++;
		}
				
		if($move eq 'O-O-O'){
			my $key = "d8";
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
		
	
	open OUT, ">".$outdirect."/".$id."_black_win_last3.txt"; # 	change this for output
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
	
	open OUT, ">".$outdirect."/".$id."_black_loss_last3.txt"; 	
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
	
	open OUT, ">".$outdirect."/".$id."_black_draw_last3.txt"; 
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
	
}

sub white {

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

my @whiteWin = @{$_[0]};
my @whiteDraw = @{$_[1]};
my @whiteLoss = @{$_[2]};
my $filename = $_[3];

my @name = split /\//, $filename;
my $id = pop(@name);
$id =~ s/\.pgn$//;
my $outdirect = join "/", @name;


	foreach(@whiteWin){
		
		my $move = $_; 
				
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

	foreach(@whiteDraw){
		
		my $move = $_; 
				
		chomp $move;
		$move =~ s/ //g;
				
		if ($move eq 'O-O'){
			my $key = "f1";
				$rDraw{$key}++;
		}
				
		if($move eq 'O-O-O'){
			my $key = "d1";
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
	
	foreach(@whiteLoss){
		
		my $move = $_; 
				
		chomp $move;
		$move =~ s/ //g;
				
		if ($move eq 'O-O'){
			my $key = "f1";
				$rLoss{$key}++;
		}
				
		if($move eq 'O-O-O'){
			my $key = "d1";
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
		
	
	open OUT, ">".$outdirect."/".$id."_white_win_last3.txt"; # 	change this for output
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
	
	open OUT, ">".$outdirect."/".$id."_white_loss_last3.txt"; 	
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
	
	open OUT, ">".$outdirect."/".$id."_white_draw_last3.txt"; 
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
	
}