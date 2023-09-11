#!/usr/bin/perl
#

if ($#ARGV!=1) {
  print "usage: script.pl infile outfile \n" ;
  exit ;
}

$infile = $ARGV[0] ;
$outfile = $ARGV[1] ;

# being nuke and end nuke for Mpro
$begin = 266 + (3 * 3263) ;
$end = $begin + (306 * 3) ;

print "begin $begin\, end $end\n" ;

open (INF, $infile) ;
open (OUTF, ">$outfile") ;

#read in vcf file
$line = <INF> ;
print OUTF $line ;
@spline = split ("=", $line) ;
chomp($spline[1]) ;
$version = $spline[1] ;
print "$version\n" ;
$line = <INF> ;
print OUTF $line ;
@spline = split ("\t", $line) ;
if ($spline[0] ne "#CHROM") {
  print "missing #CHROM at line 2 of vcf file\n" ;
  exit ;
} else {
  $n=0;
  while($line=<INF>) {
    chomp($line) ;
    @spline = split("\t", $line) ;
    $npos = $spline[1] ;
    print "$npos\n" ;
    if ( ($npos>=$begin) and ($npos<=$end) ) {
      print OUTF "$line\n" ;
    }
  }
}

close(INF) ;
close(OUTF) ;
