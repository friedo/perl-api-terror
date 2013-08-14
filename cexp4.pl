#!/usr/bin/env perl
use strict;
use warnings;
use Inline 'C';

print "Give me some words: ";
my @words = split /,/, <STDIN>;
chomp @words;

my $result = uniques( \@words );
printf "The unique are: %s\n", join ", ", keys %$result;


__END__

__C__

SV *uniques( SV *words ) { 
    AV *array = (AV *)SvRV( words );
    HV *result = newHV();
    SV **tmp;

    int len = AvFILL( array );
    int i;
    char *val;

    for( i = 0; i <= len; i++ ) { 
        tmp = av_fetch( array, i, 1 );
        if( !SvPOK( *tmp ) ) { 
            croak( "Can't handle this value!" );
        }

        val = SvPV_nolen( *tmp );

        hv_store( result, val, strlen( val ), newSV(0), 0 );
    }

    return newRV_inc( (SV *)result );
}
