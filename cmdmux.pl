#!/usr/bin/env perl

use strict;
use warnings;

our $VERSION = '0.1';

my @user_at_host = ("$ENV{USER}\@localhost", 'example\@example.com');
my $command      = 'echo hello';
my $key          = "$ENV{HOME}/cmdhostmux";

foreach my $user_at_host (@user_at_host) {
    my $out = `ssh -i $key $user_at_host $command`;
    print "Result = $out\n";
}
