#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
#use Test::NoWarnings;
use Game::Life::Sparse;

subtest board_creation => \&board_creation;

done_testing;

sub board_creation {
    plan tests => 5;

    my $board = Game::Life::Sparse->new({
        dimentions     => 2,
        initial_length => 10,
        cells          => 20,
    });

    is 100, $board->volume, "Board is created with correct volume";

    $board = Game::Life::Sparse->new(
        dimentions     => 3,
        initial_length => 10,
        cells          => 20,
    );

    is 1000, $board->volume, "Board is created with correct volume";

    $board = Game::Life::Sparse->new(
        dimentions     => 4,
        initial_length => 10,
        cells          => 20,
    );

    is 10000, $board->volume, "Board is created with correct volume";
}

