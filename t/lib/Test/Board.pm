package Test::Board;

use strict;
use warnings;
use Test::Class::Moose;
use Game::Life::Sparse;
use Data::Dumper qw/Dumper/;

my $board_2d;
my $board_2d_next;
my $board_3d;

sub test_setup {
   my $test = shift;
   $test->next::method;

    $board_2d = Game::Life::Sparse->new({
        dimentions     => 2,
        initial_length => 10,
        cells          => 20,
    });

    $board_2d->init([
        '*          ',
        '           ',
        '   ***     ',
        '   *       ',
        '   *****   ',
        '   * * *   ',
        '  ****     ',
        '     *     ',
        '     *     ',
        '           ',
        '          *',
    ]);

    $board_2d_next = Game::Life::Sparse->new({
        dimentions     => 2,
        initial_length => 10,
        cells          => 20,
    });
    $board_2d_next->init([
        '           ',
        '    *      ',
        '   **      ',
        '  **       ',
        '  ** * *   ',
        '       *   ',
        '  ** *     ',
        '  *  *     ',
        '           ',
        '           ',
        '           ',
    ]);
}

sub test_board_creation : Tests {
   my $test = shift;

    is $board_2d->size, 20, "Board is created with correct size";

    $board_2d = Game::Life::Sparse->new(
        dimentions     => 3,
        initial_length => 10,
        cells          => 200,
    );

    is $board_2d->size, 200, "Board is created with correct size";

    $board_2d = Game::Life::Sparse->new(
        dimentions     => 4,
        initial_length => 10,
        cells          => 2000,
    );

    is $board_2d->size, 2000, "Board is created with correct size";

}

sub test_board_initialisation : Tests {
   my $test = shift;
   ok $board_2d->is_alive([0,0]), 'Cell is alive';
   ok !$board_2d->is_alive([1,1]), 'Cell is dead';
}

sub test_cell_with_empty_neighbours : Tests {
   my $test = shift;
   is_deeply(
       [(undef) x 8],
       $board_2d->neighbours([0,0]),
       'Cells neighbours'
   );
}

sub test_cell_with_one_neighbour : Tests {
   my $test = shift;
   is_deeply(
       [(undef) x 1, 1, (undef) x 6],
       $board_2d->neighbours([0,1]),
       'Cells neighbours'
   );
}

sub test_cell_with_two_neighbours : Tests {
   my $test = shift;
   is_deeply(
       [(undef) x 6, 1, 1],
       $board_2d->neighbours([2,2]),
       'Cells neighbours'
   );
}

sub test_board_evolution_lonely_cell : Tests {
   my $test = shift;
   ok !$board_2d->next_state([0,0]), 'Cell is dead';
}

sub test_board_evolution_empty_lonely_cell : Tests {
   my $test = shift;
   ok !$board_2d->next_state([10,0]), 'Cell stays dead';
}

sub test_board_evolution_alive_with_2_neighbours : Tests {
   my $test = shift;
   ok !!$board_2d->next_state([2,3]), 'Cell stays alive';
}

sub test_board_evolution_alive_with_3_neighbours : Tests {
   my $test = shift;
   ok !!$board_2d->next_state([2,4]), 'Cell stays alive';
}

sub test_board_volume : Tests {
   my $test = shift;
   is_deeply 100, $board_2d->volume, 'board volume';
}

1;
