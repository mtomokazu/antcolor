#!/usr/bin/perl -w

use strict;
use warnings;

use Term::ANSIColor qw(:constants);

$Term::ANSIColor::AUTORESET = 1;

#print BOLD RED   "RED\n";
#print RED   "RED\n";
#print BOLD GREEN "GREEN\n";
#print BOLD BLUE  "BLUE\n";

colorize();
system('ant');

sub colorize {
    return if (my $pid = open(STDOUT, "|-"));
    die "Can't fork: $!" unless defined $pid;

    while (<STDIN>) {
	my $style = RESET;
	my $color = RESET;
	
      SWITCH: {
	  $style = RESET;
	  $color = RESET;
	  
	  #$color = RED,  $style = BOLD, last SWITCH if (/^\S+:/);
	  $color = GREEN, $style = BOLD, last SWITCH if (/^\S+:/);
	  $color = BLUE, $style = BOLD,  last SWITCH if (/Errors: (\d+)/ && 0 < $1);
	  $color = BLUE,                 last SWITCH if (/\[junit\]/);
      }
	
	print $style, $color, $_;
    }

    exit;
}

## eof
