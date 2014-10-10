package Test::BoardInternals;

use strict;
use warnings;
use Test::Class::Moose;
use Game::Life::Sparse;
use Data::Dumper qw/Dumper/;

my $offset_1d = [
    [-1],[ 0],[ 1]
];
my $offset_2d = [
    [-1,-1], [ 0,-1], [ 1,-1],
    [-1, 0], [ 0, 0], [ 1, 0],
    [-1, 1], [ 0, 1], [ 1, 1]
];
my $offset_3d = [
    [-1,-1,-1], [ 0,-1,-1], [ 1,-1,-1],
    [-1, 0,-1], [ 0, 0,-1], [ 1, 0,-1],
    [-1, 1,-1], [ 0, 1,-1], [ 1, 1,-1],
    [-1,-1, 0], [ 0,-1, 0], [ 1,-1, 0],
    [-1, 0, 0], [ 0, 0, 0], [ 1, 0, 0],
    [-1, 1, 0], [ 0, 1, 0], [ 1, 1, 0],
    [-1,-1, 1], [ 0,-1, 1], [ 1,-1, 1],
    [-1, 0, 1], [ 0, 0, 1], [ 1, 0, 1],
    [-1, 1, 1], [ 0, 1, 1], [ 1, 1, 1]
];


sub test_expanded_offsets : Tests {
   my $test = shift;
   is_deeply(
       $offset_1d,
       Game::Life::Sparse::_expander(),
       'expanded 0D offsets to 1D'
   );
   is_deeply(
       $offset_2d,
       Game::Life::Sparse::_expander($offset_1d),
       'expanded 1D offsets to 2D'
   );
   is_deeply(
       $offset_3d,
       Game::Life::Sparse::_expander($offset_2d),
       'expanded 2D offsets to 3D'
   );
}

sub test_array_sum : Tests {
   my $test = shift;
   is_deeply [1,1,1], Game::Life::Sparse::_array_sum([0,0,0], [1,1,1]), 'null array + unit array = unit array';
}

1;
