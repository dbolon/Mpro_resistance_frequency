#!/usr/bin/perl
#

if ($#ARGV!=1) {
  print "usage: script.pl infile outfile\n" ;
  exit ;
}

$infile = $ARGV[0] ;
$outfile = $ARGV[1] ;

open (INF, $infile) ;
open (OUTF, ">$outfile") ;

#read in vcf file
$line = <INF> ;
@spline = split ("=", $line) ;
chomp($spline[1]) ;
$version = $spline[1] ;
print "$version\n" ;
$line = <INF> ;
@spline = split ("\t", $line) ;
if ($spline[0] ne "#CHROM") {
  print "missing #CHROM at line 2 of vcf file\n" ;
  exit ;
} else {
  for ($i=0; $i<10; $i++) {
    $cname[$i] = $spline[$i] ; 
  }
  $nsamples = @spline - 9 ;
  print "N samples = $nsamples\n" ;
  $nodate = 0 ;
  for ($i=0; $i<$nsamples; $i++) {
    $sname = $spline[$i+9] ;
    $snm[$i] = $sname ;
    $sl = length($sname);
    $d = substr($sname, $sl-8, 8) ;
    if ( (substr($d,2,1) eq "-") and (substr($d,5,1) eq "-") ) {
      $sdate[$i]= substr($d,0,2) . substr($d,3,2) . substr($d,6,2) ;
    } else {
      $sdate[$i] = "" ;
      $nodate++ ;
    }
    @sn = split ("\/", $sname) ;
    $sloc[$i] = $sn[0] ;
  }
#count samples in each year
  for ($i=20; $i<24; $i++) {
    $nyear[$i] = 0;
    for ($j=1; $j<13; $j++) {
      $ym[$i][$j] = 0 ;
    }
  }
  for ($i=0; $i<$nsamples; $i++) {
    $yr = substr($sdate[$i], 0, 2) ;
    $nyear[$yr]++ ;
    $month = substr($sdate[$i], 2, 2) ;
    $ym[$yr][$month]++ ;
  }
  for ($i=20; $i<24; $i++) {
    print "$i $nyear[$i]\n" ;
  }
  print "nodate $nodate\n" ;
  for ($i=20; $i<24; $i++) {
    for ($j=1; $j<13; $j++) {
      print "$i\,$j\,$ym[$i][$j]\n" ;
    }
  }
# record mutations for each sample
  for ($i=0; $i<$nsamples; $i++) {
    $mutations[$i]="";
  }
  @flist = () ;
  $n=0;
  while($line=<INF>) {
    $n++ ;
    print "$n\n" ;
    if ($n%1000 eq 0) {print "$n\n"} ;
    chomp($line) ;
    @spline = split("\t", $line) ;
    $npos = $spline[1] ;
    $mutlist = $spline[2] ;
    @mut = split(",", $mutlist) ;
    for ($i=0; $i<$nsamples; $i++) {
      $variant = $spline[$i+9] ;
      if( $variant > 0 ) {
        $mutations[$i] = $mutations[$i] . $mut[$variant-1] . "," ;
      }
    }
  }
  for ($i=0; $i<$nsamples; $i++) {
    if ($mutations[$i] ne "") {
      print OUTF "$snm[$i]\;$sdate[$i]\;$sloc[$i]\;$mutations[$i]\n" ;
    }
  }
}

close(INF) ;
close(OUTF) ;
