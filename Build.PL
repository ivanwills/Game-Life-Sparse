package ReturnValue;

use strict;
use warnings;
use Module::Build;

my %config = (
    module_name       => 'Game::Life::Sparse',
    license           => 'perl',
    dist_author       => 'Ivan Wills <ivan.wills@gmail.com>',
    dist_version_from => 'lib/Game/Life/Sparse.pm',
    requires          => {
        'perl'                     => '5.006',
        'List::Util'               => 0,
        'Moose'                    => 0,
        'namespace::autoclean'     => 0,
        'Scalar::Util'             => 0,
        'Test::Class::Moose'       => 0,
        'Test::Class::Moose::Load' => 0,
        'version'                  => 0,
    },
    build_requires => {
        'Test::More'       => '0.88',
        'Test::NoWarnings' => 0,
    },
    add_to_cleanup     => [ 'Game-Life-Sparse-*' ],
    create_makefile_pl => 'traditional',
    create_license     => 1,
    meta_merge => {
        resources => {
            repository => 'git://github.com/ivanwills/Game-Life-Sparse.git',
            bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Game::Life::Sparse',
        },
    },
);

sub config { %config };

do_it() unless caller;

sub do_it {
    my $builder = Module::Build->new(%config);
    $builder->create_build_script();
}

1;
