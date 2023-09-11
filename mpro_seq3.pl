#!/usr/bin/perl
#

use POSIX ;

sub translate {
  my($dna,$prot,$codon, $aa, $i, $l) ;
  $dna = lc($_[0]) ;
  $prot = "" ;
  $l=floor( length($dna)/3 ) ;
  for ($i=0; $i<$l; $i++) {
    $codon = substr( $dna, $i*3, 3 ) ;
    $aa = &codontoaa( $codon ) ;
    $prot = $prot . $aa ;
  }
  $prot ;
}

sub codontoaa {
  my($q,$aa,$codon) ;
  $codon = lc($_[0]) ;
  $codon = substr($codon,0,3) ;
  if ($codon eq "aaa") {$aa = "K"} ;
  if ($codon eq "aac") {$aa = "N"} ;
  if ($codon eq "aag") {$aa = "K"} ;
  if ($codon eq "aat") {$aa = "N"} ;
  if ($codon eq "aca") {$aa = "T"} ;
  if ($codon eq "acc") {$aa = "T"} ;
  if ($codon eq "acg") {$aa = "T"} ;
  if ($codon eq "act") {$aa = "T"} ;
  if ($codon eq "aga") {$aa = "R"} ;
  if ($codon eq "agc") {$aa = "S"} ;
  if ($codon eq "agg") {$aa = "R"} ;
  if ($codon eq "agt") {$aa = "S"} ;
  if ($codon eq "ata") {$aa = "I"} ;
  if ($codon eq "atc") {$aa = "I"} ;
  if ($codon eq "atg") {$aa = "M"} ;
  if ($codon eq "att") {$aa = "I"} ;
  if ($codon eq "caa") {$aa = "Q"} ;
  if ($codon eq "cac") {$aa = "H"} ;
  if ($codon eq "cag") {$aa = "Q"} ;
  if ($codon eq "cat") {$aa = "H"} ;
  if ($codon eq "cca") {$aa = "P"} ;
  if ($codon eq "ccc") {$aa = "P"} ;
  if ($codon eq "ccg") {$aa = "P"} ;
  if ($codon eq "cct") {$aa = "P"} ;
  if ($codon eq "cga") {$aa = "R"} ;
  if ($codon eq "cgc") {$aa = "R"} ;
  if ($codon eq "cgg") {$aa = "R"} ;
  if ($codon eq "cgt") {$aa = "R"} ;
  if ($codon eq "cta") {$aa = "L"} ;
  if ($codon eq "ctc") {$aa = "L"} ;
  if ($codon eq "ctg") {$aa = "L"} ;
  if ($codon eq "ctt") {$aa = "L"} ;
  if ($codon eq "gaa") {$aa = "E"} ;
  if ($codon eq "gac") {$aa = "D"} ;
  if ($codon eq "gag") {$aa = "E"} ;
  if ($codon eq "gat") {$aa = "D"} ;
  if ($codon eq "gca") {$aa = "A"} ;
  if ($codon eq "gcc") {$aa = "A"} ;
  if ($codon eq "gcg") {$aa = "A"} ;
  if ($codon eq "gct") {$aa = "A"} ;
  if ($codon eq "gga") {$aa = "G"} ;
  if ($codon eq "ggc") {$aa = "G"} ;
  if ($codon eq "ggg") {$aa = "G"} ;
  if ($codon eq "ggt") {$aa = "G"} ;
  if ($codon eq "gta") {$aa = "V"} ;
  if ($codon eq "gtc") {$aa = "V"} ;
  if ($codon eq "gtg") {$aa = "V"} ;
  if ($codon eq "gtt") {$aa = "V"} ;
  if ($codon eq "taa") {$aa = "*"} ;
  if ($codon eq "tac") {$aa = "Y"} ;
  if ($codon eq "tag") {$aa = "*"} ;
  if ($codon eq "tat") {$aa = "Y"} ;
  if ($codon eq "tca") {$aa = "S"} ;
  if ($codon eq "tcc") {$aa = "S"} ;
  if ($codon eq "tcg") {$aa = "S"} ;
  if ($codon eq "tct") {$aa = "S"} ;
  if ($codon eq "tga") {$aa = "*"} ;
  if ($codon eq "tgc") {$aa = "C"} ;
  if ($codon eq "tgg") {$aa = "W"} ;
  if ($codon eq "tgt") {$aa = "C"} ;
  if ($codon eq "tta") {$aa = "L"} ;
  if ($codon eq "ttc") {$aa = "F"} ;
  if ($codon eq "ttg") {$aa = "L"} ;
  if ($codon eq "ttt") {$aa = "F"} ;
  $aa ;
}

$ancdna = "AGTGGTTTTAGAAAAATGGCATTCCCATCTGGTAAAGTTGAGGGTTGTATGGTACAAGTAACTTGTGGTACAACTACACTTAACGGTCTTTGGCTTGATGACGTAGTTTACTGTCCAAGACATGTGATCTGCACCTCTGAAGACATGCTTAACCCTAATTATGAAGATTTACTCATTCGTAAGTCTAATCATAATTTCTTGGTACAGGCTGGTAATGTTCAACTCAGGGTTATTGGACATTCTATGCAAAATTGTGTACTTAAGCTTAAGGTTGATACAGCCAATCCTAAGACACCTAAGTATAAGTTTGTTCGCATTCAACCAGGACAGACTTTTTCAGTGTTAGCTTGTTACAATGGTTCACCATCTGGTGTTTACCAATGTGCTATGAGGCCCAATTTCACTATTAAGGGTTCATTCCTTAATGGTTCATGTGGTAGTGTTGGTTTTAACATAGATTATGACTGTGTCTCTTTTTGTTACATGCACCATATGGAATTACCAACTGGAGTTCATGCTGGCACAGACTTAGAAGGTAACTTTTATGGACCTTTTGTTGACAGGCAAACAGCACAAGCAGCTGGTACGGACACAACTATTACAGTTAATGTTTTAGCTTGGTTGTACGCTGCTGTTATAAATGGAGACAGGTGGTTTCTCAATCGATTTACCACAACTCTTAATGACTTTAACCTTGTGGCTATGAAGTACAATTATGAACCTCTAACACAAGACCATGTTGACATACTAGGACCTCTTTCTGCTCAAACTGGAATTGCCGTTTTAGATATGTGTGCTTCATTAAAAGAATTACTGCAAAATGGTATGAATGGACGTACCATATTGGGTAGTGCTTTATTAGAAGATGAATTTACACCTTTTGATGTTGTTAGACAATGCTCAGGTGTTACTTTCCAA" ;

$ancprot = &translate( $ancdna ) ;
print "ancprot $ancprot\n" ;

if ($#ARGV!=1) {
  print "usage: script.pl infile outfile\n" ;
  exit ;
}

$infile = $ARGV[0] ;
$outfile = $ARGV[1] ;

open (INF, $infile) ;
open (OUTF, ">$outfile") ;

#read in mutation list file
$n=0 ;
while( $line=<INF> ) {
  chomp($line) ;
  @spline = split( ";", $line ) ;
  $name[$n] = $spline[0] ;
  $date[$n] = $spline[1] ;
  $loc[$n] = $spline[2] ;
  $temp = $spline[3] ;
  $t[$n] = $temp ;
  $mutlist = substr($temp,0,length($temp)-1) ;
  @mlist = split( ",", $mutlist ) ;
  $nmuts[$n]=@mlist ;
#  print "$mutlist $nmuts[$n]\n" ;
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

#determine aa changes
for ($i=0; $i<$n; $i++) {
  print OUTF "$name[$i]\;$date[$i]\;$loc[$i]\;$t[$i]\;" ;
  @changenuke = () ;
  for ($j=0; $j<$nmuts[$i]; $j++) {
    $pgenome = substr( $muts[$i][$j], 1, 5 ) ;
    $pmpro = $pgenome - 10055 ;
    $pcod = ceil((1+$pmpro)/3) ;
    $pnuke = 1 + $pmpro % 3 ;
    $base = substr( $muts[$i][$j], 6, 1 ) ;
    $basechange = $pcod . $base . $pnuke ;
    $changenuke[$j] = $basechange ;
    $curcod[$pcod] = substr( $ancdna,($pcod-1)*3 , 3 ) ;
  }
  for ( $j=0; $j<$nmuts[$i]; $j++) {
    $l = length( $changenuke[$j] ) ;
    $base = substr( $changenuke[$j], $l-2, 1 ) ;
    $pnuke = substr( $changenuke[$j], $l-1, 1 ) ;
    $pcod = substr( $changenuke[$j], 0, $l-2 ) ;
    if ($pnuke == 1) {
      $first = $base ;
    } else {
      $first = substr( $curcod[$pcod], 0, 1 ) ;
    }
    if ($pnuke == 2) {
      $second = $base ;
    } else {
      $second = substr( $curcod[$pcod], 1, 1 ) ;
    }
    if ($pnuke == 3) {
      $third = $base ;
    } else {
      $third = substr( $curcod[$pcod], 2, 1 ) ;
    }
    $curcod[$pcod] = $first . $second . $third ;
  }
  @list = () ;
  for ( $j=0; $j<$nmuts[$i]; $j++) {
    $pcod = substr( $changenuke[$j], 0, length($changenuke[$j])-2 ) ;
    $newaa = &codontoaa( $curcod[$pcod] ) ;
    $ancaa = substr( $ancprot, $pcod-1, 1 ) ;
    if( grep( /^$pcod$/, @list ) ) {
    } else {
      push( @list, $pcod );
      $aachange = $ancaa . $pcod . $newaa ;
      print OUTF "$aachange\," ;
    }
  }
  print OUTF "\n" ;
}


close(INF) ;
close(OUTF) ;
