#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use Test::Warnings;

BEGIN {
    use_ok( 'Game::Life::Sparse' );
}

diag( "Testing Game::Life::Sparse $Game::Life::Sparse::VERSION, Perl $], $^X" );
done_testing();
