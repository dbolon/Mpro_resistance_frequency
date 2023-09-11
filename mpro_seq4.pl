#!/usr/bin/perl
#

if ($#ARGV!=2) {
  print "usage: script.pl inmutantfile inDRlistfile outfile\n" ;
  exit ;
}

$inmut = $ARGV[0] ;
$indr = $ARGV[1] ;
$outfile = $ARGV[2] ;

open (INM, $inmut) ;
open (IND, $indr) ;
open (OUTF, ">$outfile") ;

#read in mutation list file
$n=0 ;
while( $line=<INM> ) {
  chomp($line) ;
  @spline = split( ";", $line ) ;
  $name[$n] = $spline[0] ;
  $date[$n] = $spline[1] ;
  $loc[$n] = $spline[2] ;
  $mutnuke[$n] = $spline[3] ;
  $temp = $spline[4] ;
  $t[$n] = $temp ;
  $mutlist = substr($temp,0,length($temp)-1) ;
  @mlist = split( ",", $mutlist ) ;
  $nmuts[$n]=@mlist ;
  for ($i=0; $i<$nmuts[$n]; $i++) {
    $muts[$n][$i]=$mlist[$i]; 
  }
  $n++ ;
}

# distribution of the number of mutations seen in Mpro
for ($j=0; $j<11; $j++) {
  $count[$j]=0;
}
for ($i=0; $i<$n; $i++) {
  if ($nmuts[$n] > 9) {
    $count[10]++ ;
  } else {
    $count[($nmuts[$i])]++ ;
  }
}
print "Number of Mutations in Mpro, Count\n" ;
for ($j=0; $j<10; $j++) {
  print "$j\,$count[$j]\n" ;
}
print "10+\,$count[10]\n" ;

#determine prevalence of drug resistance mutations
$ndr = 0 ;
while( $line = <IND> ) {
  chomp( $line ) ;
  @spline = split( ";", $line ) ;
  $dr[$ndr] = $spline[0] ;
  $inhlist[$ndr] = $spline[1] ;
  $ndr++ ;
}

print "Number of variants in DR list: $ndr\n" ;

# pull out DR entries in sequence data
for( $i=0 ; $i<$n ; $i++ ) {
  $drcheck = 0 ;
  $drfound = "" ;
  $inhl = "" ;
  for( $j=0 ; $j<$nmuts[$i] ; $j++) {
    $aachange = $muts[$i][$j] ;
    for( $k=0 ; $k<$ndr ; $k++ ) {
      if( $aachange eq $dr[$k] ) {
        $drcheck = 1 ;
        $drfound = $drfound . $aachange . "," ;
        $inhl = $inhl . $inhlist[$k] . "," ;
      }
    }
  }
  if( $drcheck > 0 ) {
    print OUTF "$name[$i]\;" ;
    print OUTF "$date[$i]\;" ;
    print OUTF "$loc[$i]\;" ;
    print OUTF "$mutnuke[$i]\;" ;
    print OUTF "$t[$i]\;" ;
    print OUTF "\,$drfound" ;
    print OUTF "\;$inhl\n" ;
  }
}

close(INM) ;
close(IND) ;
close(OUTF) ;
