#!/usr/bin/env perl
use strict;
use warnings;
use Inline 'C';

print "Give me a number: ";
my $num_a = <STDIN>;

print "Give me another number: ";
my $num_b = <STDIN>;

# coerce to numbers
$num_a += 0;
$num_b += 0;

printf "The sum is: %s\n", add( $num_a, $num_b );


__END__

__C__

SV *add( SV *a, SV *b ) { 

    if ( SvIOK( a ) && SvIOK( b ) ) { 
        return newSViv( SvIVX( a ) + SvIVX( b ) );
    } else if ( SvNOK( a ) && SvNOK( b ) ) { 
        return newSVnv( SvNVX( a ) + SvNVX( b ) );
    } else { 
        croak( "I don't know what to do!" );
    }
}

