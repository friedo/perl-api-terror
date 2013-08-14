#!/usr/bin/env perl
use strict;
use warnings;
use Inline 'C';

print "Give me some numbers: ";
my @numbers = map { $_ += 0 } split /,/, <STDIN>;

my $result = squares( \@numbers );
printf "The squares are: %s\n", join ", ", @$result;


__END__

__C__

SV *squares( SV *numbers ) { 
    AV *array = (AV *)SvRV( numbers );
    AV *return_array = newAV();
    SV **tmp;

    int len = AvFILL( array );
    int i, val;

    for( i = 0; i <= len; i++ ) { 
        tmp = av_fetch( array, i, 1 );
        if( !SvIOK( *tmp ) ) { 
            croak( "Can't handle this value!" );
        }
        val = SvIV( *tmp );
        val = val * val;

        av_push( return_array, newSViv( val ) );
    }

    return newRV_inc( (SV *)return_array );
}


