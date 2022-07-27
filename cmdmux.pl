#!/usr/bin/env perl

use strict;
use warnings;
use autodie;

our $VERSION = '0.1';

my $i            = 0;
my @user_at_host = ();

open my $fh, '<', $ARGV[0];

while (<$fh>) {
    chomp ($_);
    @user_at_host[$i] = $_;
    $i++;
}

my $command = 'echo "hello from \$USER"';
my $key     = "$ENV{HOME}/cmdhostmux";

foreach my $user_at_host (@user_at_host) {
    my $out = `ssh -i $key $user_at_host $command`;
    print "Result = $out\n";
}
