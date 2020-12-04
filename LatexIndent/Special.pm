package LatexIndent::Special;
use strict;
use warnings;
use feature qw(say);
use LatexIndent::LogFile qw/$grammarLeadingSpace/;

sub explain {
    my ($self, $level) = @_;
    say $grammarLeadingSpace x $level, "Special";
    say $grammarLeadingSpace x ($level+1), "Begin: $self->{begin}";
    say $grammarLeadingSpace x ($level+1), "End:   $self->{end}";
    say $grammarLeadingSpace x $level, $_->explain($level+2) foreach @{$self->{Element}};
    return;
}

sub indent {
    my $self = shift;
    my $body = q();
    $body .= $_->indent foreach (@{$self->{Element}});

    # indentation of the body
    $body =~ s/^/\t/mg;

    # remove the first line of indentation, if appropriate
    $body =~ s/^\t//s if !$self->{linebreaksAtEndBegin};

    # assemble the body
    $body =  $self->{begin}                 # begin
            .$self->{leadingHorizontalSpace}
            .$self->{linebreaksAtEndBegin}
            .$body                          # body
            .$self->{end}                   # end
            .$self->{horizontalTrailingSpace}
            .$self->{linebreaksAtEndEnd};   
    return $body;
}
1;
