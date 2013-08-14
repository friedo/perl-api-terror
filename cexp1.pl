#!/usr/bin/env perl
use strict;
use warnings;
use Inline 'C';

print "Give me a number: ";
my $num_a = <STDIN>;

print "Give me another number: ";
my $num_b = <STDIN>;

printf "The sum is: %s\n", add( $num_a, $num_b );


__END__

__C__

int add( int a, int b ) { 
    return a + b;
}

