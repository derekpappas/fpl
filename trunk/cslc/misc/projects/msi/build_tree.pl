#! /usr/bin/perl -w

use Data::Dumper;

my @stack;
my %treeHash; # hierarchy tree
my %unitHash; # list of units

push @stack, \%treeHash; # initialize the stack
while(<>){
    chomp;
    s/^(\|*)//;
    splice @stack, length($1) + 1; # pop n elements off of the stack
    push   @stack, $stack[$#stack]->{$_} = {}; # add the current line element to the children at stack[stack.depth] and add the stack element to the stack
    $unitHash{$_} = 1;
}
print Dumper(\%treeHash);

foreach my $e (@stack) {
    print "e:: $e\n";
}

foreach my $k (keys %treeHash) {
    print "k:: $k v:: $treeHash{$k}\n";
    foreach my $kk (keys %{$treeHash{$k}}) {
        print "  kk:: $kk \n";
    }
}

foreach my $k (keys %unitHash) {
    print "UnitHash k:: $k\n";
}
