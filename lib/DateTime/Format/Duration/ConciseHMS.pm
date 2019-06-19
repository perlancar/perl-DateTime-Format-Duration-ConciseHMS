package DateTime::Format::Duration::ConciseHMS;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

sub new {
    my ($class, %args) = @_;

    return bless \%args, $class;
}

sub format_duration {
    my ($self, $dtdur) = @_;

    unless (eval { $dtdur->isa('DateTime::Duration') }) {
        die "'$dtdur' not a DateTime::Duration instance";
    }

    my ($y, $m, $w, $d, $H, $M, $S, $ns) = (
        $dtdur->years,
        $dtdur->months,
        $dtdur->weeks,
        $dtdur->days,
        $dtdur->hours,
        $dtdur->minutes,
        $dtdur->seconds,
        $dtdur->nanoseconds,
    );

    $d += $w * 7;

    join(
        " ",
        ("${y}y") x !!$y,
        ("${m}mo") x !!$m,
        ("${d}d") x !!$d,
        sprintf("%02d:%02d:%02d%s", $H, $M, $S,
                $ns ? sprintf(".%03d", $ns/1e6) : "")
    );
}

1;
# ABSTRACT: Format DateTime::Duration object as concise HMS format

=head1 SYNOPSIS

 use DateTime::Format::Duration::ConciseHMS;

 my $format = DateTime::Format::Duration::ConciseHMS->new;
 say $format->format_duration(
     DateTime::Duration->new(years=>3, months=>5, seconds=>10),
 ); # => "3y 5mo 00:00:10"


=head1 DESCRIPTION

This module formats L<DateTime::Duration> objects as "concise HMS" format.
Duration of days and larger will be represented like "1y" (1 year), "2mo" (2
months), "3d" (3 days) while duration of hours/minutes/seconds will be
represented using hh:mm:ss e.g. 04:05:06. Examples:

 00:00:00
 3y 5mo 00:00:10.123


=head1 METHODS

=head2 new

=head2 format_duration


=head1 SEE ALSO

L<DateTime::Duration>

=cut
