use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
	module_name       => 'Game::Life::Sparse',
	license           => 'perl',
	dist_author       => 'Ivan Wills <ivan.wills@gmail.com>',
	dist_version_from => 'lib/Game/Life/Sparse.pm',
	requires          => {
		'perl'             => 5.008,
	},
	build_requires => {
		'Test::More'       => 0,
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

$builder->create_build_script();
