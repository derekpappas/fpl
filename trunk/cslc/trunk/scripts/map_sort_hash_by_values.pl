#! /usr/bin/perl

%countries=('976','Mongolia','52','Mexico','212','Morocco','64','New Zealand','33','France');

foreach (sort { $countries{$a} cmp $countries{$b} } keys %countries) {
        print "$_ $countries{$_}\n";
}
