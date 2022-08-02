#!/usr/bin/env perl

use strict;
use warnings;
use autodie;
use Net::SSH::Perl;

our $VERSION = '0.1';

my $i            = 0;
my @user_at_host = ();

open my $fh, '<', $ARGV[0];

while (<$fh>) {
    chomp;
    @user_at_host[$i] = $_;
    $i++;
}
close $fh;

my $command = 'echo "hello from $USER"';
my $key     = "$ENV{HOME}/cmdhostmux";

foreach my $user_at_host (@user_at_host) {
    my @conn = split /@/, $user_at_host;
    my $user = $conn[0];
    my $host = $conn[1];
    my $ssh  = Net::SSH::Perl->new ($host, identity_files => [$key]);
    $ssh->login ($user);
    my ($out, $err, $exit) = $ssh->cmd ($command);
    print "Result = $out \n";
}
