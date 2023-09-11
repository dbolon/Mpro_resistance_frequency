#!/usr/bin/perl
#

sub date2months {
  my($months,$date,$year,$dyear,$m) ;
  $date = $_[0] ;
  if( length($date) ne 6 ) {
    $months = 0 ;
  } else {
    $year = substr( $date, 0, 2 ) ;
    $dyear = $year - 20 ;
    $m = substr( $date, 2, 2 ) ;
    $months = ($dyear*12)+$m ;
  }
  $months ;
}

if ($#ARGV!=2) {
  print "usage: script.pl inmutantfile inDRlistfile outfile\n" ;
  exit ;
}

$inmut = $ARGV[0] ;
$indr = $ARGV[1] ;
$outfile = $ARGV[2] ;

#update this every year
$months = 48 ;

open (INM, $inmut) ;
open (IND, $indr) ;
open (OUTF, ">$outfile") ;

#input drug resistance mutations
$ndr = 0 ;
while( $line = <IND> ) {
  chomp( $line ) ;
  @spline = split( ";", $line ) ;
  $dr[$ndr] = $spline[0] ;
  $inhlist[$ndr] = $spline[1] ;
  $nbases[$ndr] = $spline[2] ;
  $fs[$ndr] = $spline[3] ;
  $nirms[$ndr] = $spline[4] ;
  $ensits[$ndr] = $spline[5] ;
  $ndr++ ;
}

print "Number of variants in DR list: $ndr\n" ;

# assess DR entries in sequence data
for ($i=0 ; $i<$ndr ; $i++) {
  for ($j=0 ; $j<$months ; $j++) {
    $count[$i][$j] = 0 ;
  }
}

$n=0;
while( $line=<INM> ) {
  chomp($line) ;
  @spline = split( ";", $line ) ;
  $name = $spline[0] ;
  $date = $spline[1] ;
  $loc = $spline[2] ;
  $mutnuke = $spline[3] ;
  $mutlist = $spline[4] ;
  $drmutlist = $spline[5] ;
  $drlabels = $spline[6] ;
  $m = &date2months( $date ) ;
  for ($j=0 ; $j<$ndr ; $j++) {
    if (index($mutlist,$dr[$j]) != -1) {
      $count[$j][$m]++ ;
    }
  $dr[$ndr] = $spline[0] ;
  }
  $n++ ;
  print "$n " ;
}

for ($i=0 ; $i<$n ; $i++) {
}

# print out dr mutants per month
print OUTF "AA change\;DR Concerns\;Base changes\;Funct. Score\;Nirm score\;Ensit score\;Months since Jan 2020 - " ;
for ($i=1 ; $i<$months; $i++) {
  print OUTF "$i\;" ;
}
print OUTF "\n" ;
for ($i=0 ; $i<$ndr ; $i++) {
  print OUTF "$dr[$i]\;$inhlist[$i]\;$nbases[$i]\;$fs[$i]\;$nirms[$i]\;$ensits[$i]\;" ;
  for ($j=1 ; $j<$months ; $j++) {
    print OUTF "$count[$i][$j]\;" ;
  }
  print OUTF "\n" ;
}

close(INM) ;
close(IND) ;
close(OUTF) ;
