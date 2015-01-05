use Moops -strict;

class Game::Life::Sparse 0.0.1 {
    use List::Util qw/reduce/;

    has dimentions => (
        is       => 'ro',
        isa      => Int,
        required => 1,
    );
    has initial_length => (
        is       => 'ro',
        isa      => Int,
        default  => 10,
        required => 1,
    );
    has cells => (
        is       => 'ro',
        isa      => Int,
        default  => 10,
        required => 1,
    );
    has board => (
        is         => 'rw',
        isa        => HashRef[Bool],
        builder    => '_board',
        required   => 1,
        lazy_build => 1,
    );

    sub init {
        my ($self, $board) = @_;
        my $new_board = {};
        for my $i ( 0 .. @{$board} - 1 ) {
            my $row = $board->[$i];
            my @cells = split //, $row;
            for my $j ( 0 .. @cells - 1 ) {
                next if $cells[$j] eq ' ';
                $new_board->{"$i,$j"} = 1;
            }
        }

        $self->board($new_board);

        return $self;
    }

    sub volume {
        my ($self) = @_;
        my @max;
        for my $cell (keys %{ $self->board }) {
            my @points = split /,/, $cell;
            for my $i (0 .. $#points) {
                $max[$i] = $points[$i] if !$max[$i] || $points[$i] > $max[$i];
            }
        }

        return reduce {$a * $b} @max;
    }

    sub is_alive {
        my ($self, $cell) = @_;

        return !!$self->board->{ join ',', @$cell };
    }

    sub next_state {
        my ($self, $cell) = @_;

        my $neighbours = $self->neighbours($cell);
        my $count = reduce {$a + $b} map {$_ ? 1 : 0} @$neighbours;

        if ( $self->is_alive($cell) ) {
            return $count == 2 || $count == 3;
        }

        return $count == 2;
    }

    sub neighbours {
        my ($self, $cell) = @_;
        my $offsets = [];
        for (1 .. $self->dimentions) {
            $offsets = _expander($offsets);
        }
        my @neighbours;
        for my $offset (@{$offsets}) {
            # skip the 0 offset position
            next if !reduce {$a + $b} map {abs $_} @$offset;
            push @neighbours, $self->board->{ join ',', @{ _array_sum($cell, $offset) } };
        }

        return \@neighbours;
    }

    sub size {
        my ($self) = @_;
        return scalar keys %{$self->board};
    }

    sub _board {
        my ($self) = @_;
        my $board = {};

        while (keys %{$board} < $self->cells) {
            my @pos;
            while (@pos < $self->dimentions) {
                push @pos, int rand $self->initial_length;
            }
            $board->{ join ',', @pos } = 1;
        }

        return $board;
    }

    sub _expander {
        my ($array) = @_;
        $array ||= [];
        my $dims = @$array ? @$array : 1;
        my @new;

        for my $offset (-1,0,1) {
            for my $dim (0 .. $dims -1) {
                push @new, [ @{ $array->[$dim] || [] }, $offset ];
            }
        }

        return \@new;
    }

    sub _array_sum {
        my ($array1, $array2) = @_;
        my @new;
        for my $i ( 0 .. $#$array1 ) {
            $new[$i] = $array1->[$i] + $array2->[$i];
        }

        return \@new;
    }

};

1;

__END__

=head1 NAME

Game::Life::Sparse - Conway's game of life; sparse version

=head1 VERSION

This documentation refers to Game::Life::Sparse version 0.0.1

=head1 SYNOPSIS

   use Game::Life::Sparse;

   # Brief but working code example(s) here showing the most common usage(s)
   # This section will be as far as many users bother reading, so make it as
   # educational and exemplary as possible.


=head1 DESCRIPTION

=head1 SUBROUTINES/METHODS

=over 4

=item C<init ($self, $board)>

Initialise the board of size C<$board>

=item C<volume ($self)>

Find the boards volume

=item C<is_alive ($self, $cell)>

Determine if the cell C<$cell> is a alive or dead

=item C<next_state ($self, $cell)>

Determine the next state of a cell

=item C<neighbours ($self, $cell)>

Find all the neighbouts of the cell C<$cell>

=item C<size ($self)>

The dimention of the board

=item C<_board ($self)>

=item C<_expander ($array)>

=item C<_array_sum ($array1, $array2)>

=back

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

There are no known bugs in this module.

Please report problems to Ivan Wills (ivan.wills@gmail.com).

Patches are welcome.

=head1 AUTHOR

Ivan Wills - (ivan.wills@gmail.com)

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2014 Ivan Wills (14 Mullion Close, Hornsby Heights, NSW Australia 2077).
All rights reserved.

This module is free software; you can redistribute it and/or modify it under
the same terms as Perl itself. See L<perlartistic>.  This program is
distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

=cut
