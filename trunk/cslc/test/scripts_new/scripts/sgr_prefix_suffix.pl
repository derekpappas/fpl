#!/usr/bin/perl

#Author Petronela
use strict;

my $path = "$ENV{WORK}/test/csl_test_gen/";
print "the path for generated tests is: $path"."sgr_prefix_suffix/ \n";

if(! defined $ENV{WORK}){
    die "[ERROR] The environment variable WORK is not set. Set it to point to TOT/se";
}

my $totDir     = $ENV{WORK};
&testDirExists($totDir);

sub testDirExists {
    my($execName) = @_;
    unless(-e "$execName") { die "[ERROR] The directory $execName does not exist!\n"; }
    
}

sub mkDir {
    my($dirName) = @_;
    unless(-e "$dirName")  { `mkdir $dirName`; }
}

for(my $i = 1;$i <= 20; $i++){
    &main($i);
}

sub main {
    my $i = $_[0];
    my $test_name = "sgr_prefix_suffix_".$i."_legal.csl";
    &createCslFile($test_name, $i);
}

sub word {
    my $val = $_[0];
    my @alpha = ('a'..'z','A'..'Z','_');
    my @alphanumeric = ('a'..'z','A'..'Z','0'..'9','$','_');
    my $ret = $alpha[rand @alpha];
    for(my $i=1;$i < $val; ++$i){
        $ret = $ret.$alphanumeric[rand @alphanumeric];
    }
    return $ret;
}

sub createCslFile {
    my($test_name, $i) = @_;
   
    my $val1 = int(rand(20)) + 1;
    my $val2 = $val1 + int(rand(20)) + 1;
    my $val3 = int(rand(30)) + 1;
    my $val4 = int(rand(50)) + 1;
    my $val5 = int(rand(80)) + 1;
    my $val6 = int(rand(100)) + 1;
    my $val7 = int(rand(10)) + 1;
    my $val8 = int(rand(10)) + 2;
    my $val9 = int(rand(10)) + 2;
    my $word = &word($val7);
    my $word1 = &word($val8);
    my $word2 = &word($val9);
    my $word3 = &word($val8);
    my $word4 = &word($val9);
    my $word5 = &word($val2);
    my $word6 = &word($val1);
    my $word7 = &word($val2);
    &mkDir("$path/sgr_prefix_suffix/");
    open(FH,">$path/sgr_prefix_suffix/$test_name");
    print FH "//Generated by Petronela\n";  
    print FH "//testing cmd. set_prefix, no_prefix and set_suffix in signal_groups \n\n";
    
    print FH "csl_signal_group sga{\n";
    print FH "  csl_signal s_sga($val3);\n";
    print FH "  csl_signal s_sg($val5);\n";
    print FH "  csl_signal s_sa($val2);\n";
    print FH "  sga(){\n";
    print FH "    set_prefix(\"$word2\");\n";
    print FH "  }\n";
    print FH "};\n\n";
    if($i > 5){
        print FH "csl_signal_group sgb{\n";
        print FH "  csl_signal s_sgb($val1);\n";
        print FH "  csl_signal s_sg($val4);\n";
        print FH "  sga sga0;\n";
        print FH "  sgb(){\n";
        print FH "    set_suffix(\"$word4\");\n";
        print FH "    no_prefix();\n";
        print FH "  }\n";
        print FH "};\n\n";
    }
    if($i > 10){
        print FH "csl_signal_group sgc{\n";
        print FH "  csl_signal s_sgc($val5);\n";
        print FH "  csl_signal s_sg($val2);\n";
        print FH "  sga sga3;\n";
        print FH "  sgc(){\n";
        print FH "  }\n";
        print FH "};\n\n";
        print FH "csl_signal_group sgd{\n";
        print FH "  csl_signal s_sgd($val2);\n";
        print FH "  csl_signal s_sg($val5);\n";
        print FH "  csl_signal s_sd($val3);\n";
        print FH "  sgc sgc0;\n";
        print FH "  sgc sgc1;\n";
        print FH "  sgc sgc2;\n";
        print FH "  sgb sgb2;\n";
        print FH "  sgd(){\n";
        print FH "    sgc0.set_suffix(\"$word6\");\n";
        print FH "    sgc2.set_prefix(\"$word7\");\n";
        print FH "    set_suffix(\"$word\");\n";
        print FH "  }\n";
        print FH "};\n\n";
    }
    if($i > 15) {
        print FH "csl_signal_group sge{\n";
        print FH "  csl_signal s_sge($val5);\n";
        print FH "  csl_signal s_sg($val2);\n";
        print FH "  sgd sgd1;\n";
        print FH "  sgc sgc4;\n";
        print FH "  sge(){\n";
        print FH "    sgd1.set_prefix(\"$word6\");\n";
        print FH "    sgc4.sga3.no_prefix();\n";
        print FH "    no_prefix();\n";
        print FH "    set_suffix(\""."_"."$word6\");\n";
        print FH "  }\n";
        print FH "};\n\n";
        print FH "csl_signal_group sgf{\n";
        print FH "  csl_signal s_sgf($val5);\n";
        print FH "  csl_signal s_sg($val2);\n";
        print FH "  sge sge0;\n";
        print FH "  sga sga4;\n";
        print FH "  sgf(){\n";
        print FH "    sga4.set_suffix(\"$word3\");\n";
        print FH "    sge0.sgd1.sgc0.sga3.set_suffix(\"$word6\");\n";
        print FH "  }\n";
        print FH "};\n\n";
    }
    print FH "csl_unit top {\n";
    print FH "  sga sga1;\n";
    print FH "  sga sga2;\n";
    if($i > 5){
        print FH "  sgb sgb0;\n";
        print FH "  sgb sgb1;\n";
    }
    if($i > 10){
        print FH "  sgc sgc3;\n";
        print FH "  sgd sgd0;\n";
    }
    if($i > 15){
        print FH "  sge sge1;\n";
        print FH "  sge sge2;\n";
        print FH "  sge sge3;\n";
        print FH "  sgf sgf0;\n";
        print FH "  sgf sgf1;\n";
        print FH "  sgf sgf2;\n";
    }
    print FH "  top(){\n";
    print FH "    sga1.set_suffix(\"$word5\");\n";
    print FH "    sga2.set_prefix(\"$word4\");\n";
    if($i > 5){
        print FH "    sgb0.set_prefix(\"$word\");\n";
        print FH "    sgb1.set_prefix(\"$word3"."_"."\");\n";
    }
    if($i > 10){
        print FH "    sgc3.no_prefix();\n";
        print FH "    sgd0.sgc2.set_suffix(\"$word1\");\n";
        print FH "    sgd0.sgc1.set_suffix(\"$word2\");\n";
        print FH "    sgd0.sgb2.set_prefix(\"$word3"."_"."\");\n";
    }
    if($i > 15){
        print FH "    sge1.set_prefix(\"$word2"."_"."\");\n";
        print FH "    sge2.set_suffix(\"$word3\");\n";
        print FH "    sge3.set_suffix(\"$word5\");\n";
        print FH "    sgf0.set_prefix(\"$word4\");\n";
        print FH "    sgf1.set_suffix(\"$word1\");\n";
        print FH "    sgf2.no_prefix();\n";
        print FH "    sgf2.sga4.no_prefix();\n";
    }
    print FH "  }\n";
    print FH "};\n";
    close(FH);
}    
