#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
#use Test::NoWarnings;
use Game::Life::Sparse;

subtest board_creation => \&board_creation;

done_testing;

sub board_creation {
    plan tests => 3;

    my $board = Game::Life::Sparse->new({
        dimentions     => 2,
        initial_length => 10,
        cells          => 20,
    });

    is $board->size, 20, "Board is created with correct size";

    $board = Game::Life::Sparse->new(
        dimentions     => 3,
        initial_length => 10,
        cells          => 200,
    );

    is $board->size, 200, "Board is created with correct size";

    $board = Game::Life::Sparse->new(
        dimentions     => 4,
        initial_length => 10,
        cells          => 2000,
    );

    is $board->size, 2000, "Board is created with correct size";
}

