#!/usr/bin/perl

use strict;
use warnings;

open B, "/mnt/p/o_drive/Homes/jearl/tight_skinned_mouse/filtering_program/101B.txt" or die "Can't open the 101B file: $!\n";
open E, "/mnt/p/o_drive/Homes/jearl/tight_skinned_mouse/filtering_program/101E.txt" or die "Can't open the 101E file: $!\n";
open FOUR, "/mnt/p/o_drive/Homes/jearl/tight_skinned_mouse/filtering_program/2044.txt" or die "Can't open the 2044 file: $!\n";
open FIVE, "/mnt/p/o_drive/Homes/jearl/tight_skinned_mouse/filtering_program/2045.txt" or die "Can't open the 2045 file: $!\n";

#my @B = <B>;
#my @E = <E>;
#my @FOUR = <FOUR>;
#my @FIVE = <FIVE>;

my (%sB, %sE, %sFOUR, %sFIVE);


while (<B>){
    next if $. == 1;
    my @a = split('\s', $_);
    if ($a[1]<44676000 || $a[1]>47212000){next}
    $sB{$a[1]} = join("\t", @a[2..6]);
}

while (<E>){
    next if $. == 1;
    my @a = split('\s', $_);
    if ($a[1]<44676000 || $a[1]>47212000){next}
    $sE{$a[1]} = join("\t", @a[2..6]);
}

while (<FOUR>){
    next if $. == 1;
    my @a = split('\s', $_);
    if ($a[1]<44676000 || $a[1]>47212000){next}
    $sFOUR{$a[1]} = join("\t", @a[2..6]);
}

while (<FIVE>){
    next if $. == 1;
    my @a = split('\s', $_);
    if ($a[1]<44676000 || $a[1]>47212000){next}
    $sFIVE{$a[1]} = join("\t", @a[2..6]);
}

my $count = 0;
#print "Both 101B and 101E different from both 2044 and 2045\n";
#for my $i (keys %sB){
 #   if (exists $sE{$i} && exists $sFOUR{$i} && exists $sFIVE{$i}){
#	$count++;
#	print "$i\n";
#	print "101B $sB{$i}\n";
#	print "101E $sE{$i}\n";
#	print "2044 $sFOUR{$i}\n";
#	print "2045 $sFIVE{$i}\n";
#    }
#}

#print "Total: $count\n";
#$count = 0;
print "Both 101B and 101E different from both 2044 and 2045\n";
for my $i (keys %sFOUR){
    if (exists $sE{$i} && !exists $sB{$i} && exists $sFIVE{$i}){
	$count++;
	print "$i\n";
	print "2044 $sFOUR{$i}\n";
	print "2045 $sFIVE{$i}\n";
    }
}
print "Total: $count\n";
die;

print "101B but not 101E different from both 2044 and 2045\n";
for my $i (keys %sB){
    if (!exists $sE{$i} && exists $sFOUR{$i} && exists $sFIVE{$i}){
	print "$i\n";
	print "101B $sB{$i}\n";
	print "2044 $sFOUR{$i}\n";
	print "2045 $sFIVE{$i}\n";
    }
}

print "101B but not 101E different from 2044 but not 2045\n";
for my $i (keys %sB){
    if (!exists $sE{$i} && exists $sFOUR{$i} && !exists $sFIVE{$i}){
	print "$i\n";
	print "101B $sB{$i}\n";
	print "2044 $sFOUR{$i}\n";
    }
}

print "101B but not 101E different from 2045 but not 2044\n";
for my $i (keys %sB){
    if (!exists $sE{$i} && !exists $sFOUR{$i} && exists $sFIVE{$i}){
	print "$i\n";
	print "101B $sB{$i}\n";
	print "2045 $sFIVE{$i}\n";
    }
}

print "101B and 101E different from 2044 but not 2045\n";
for my $i (keys %sB){
    if (exists $sE{$i} && exists $sFOUR{$i} && !exists $sFIVE{$i}){
	print "$i\n";
	print "101B $sB{$i}\n";
	print "101E $sE{$i}\n";
	print "2044 $sFOUR{$i}\n";
    }
}

print "101B and 101E different from 2045 but not 2044\n";
for my $i (keys %sB){
    if (exists $sE{$i} && !exists $sFOUR{$i} && exists $sFIVE{$i}){
	print "$i\n";
	print "101B $sB{$i}\n";
	print "101E $sE{$i}\n";
	print "2045 $sFIVE{$i}\n";
    }
}

print "101E but not 101B different from both 2044 and 2045\n";
for my $i (keys %sE){
    if (!exists $sB{$i} && exists $sFOUR{$i} && exists $sFIVE{$i}){
	print "$i\n";
	print "101E $sE{$i}\n";
	print "2044 $sFOUR{$i}\n";
	print "2045 $sFIVE{$i}\n";
    }
}

print "101E but not 101B different from 2044 but not 2045\n";
for my $i (keys %sE){
    if (!exists $sB{$i} && !exists $sFOUR{$i} && exists $sFIVE{$i}){
	print "$i\n";
	print "101E $sE{$i}\n";
	print "2044 $sFOUR{$i}\n";
    }
}

print "101E but not 101B different from 2045 but not 2044\n";
for my $i (keys %sE){
    if (!exists $sB{$i} && exists $sFOUR{$i} && !exists $sFIVE{$i}){
	print "$i\n";
	print "101E $sE{$i}\n";
	print "2045 $sFIVE{$i}\n";
    }
}



#print "$sB{45616340}\n";
