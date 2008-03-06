package App::MadEye::Plugin::Agent::POP3S;
use strict;
use warnings;
use App::MadEye::Plugin::Agent::Base;
use IO::Socket qw(SOCK_STREAM);
use IO::Socket::SSL;

sub is_dead {
    my ($self, $host) = @_;

    my $conf = $self->config->{config};
    my $port    = $conf->{port}    or die "missing port";
    my $timeout = $conf->{timeout} || 10;

    eval {
        my $sock = IO::Socket::SSL->new(
            PeerAddr  => $host,
            PeerPort  => $port,
            Proto     => 'tcp',
            Type      => SOCK_STREAM,
            Timeout   => $timeout,
        ) or die "can't connect pop3s $host:$port $!\n";
    };

    if ( $@ ) {
        return "pop3d is dead $@";
    } else {
        return 0;
    }
}

1;

