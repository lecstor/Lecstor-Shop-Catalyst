#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use FindBin qw($Bin);
use lib "$Bin/lib";

BEGIN {
    $ENV{LECSTOR_DEPLOY} = 'test';
};

use Test::DBIx::Class {
    config_path => [ File::Spec->splitdir($Bin), qw(etc schema) ],
};

use Catalyst::Test 'Lecstor::Shop::Catalyst';


#Lecstor::Shop::Catalyst->model('Schema')->schema(Schema);

ok( request('/')->is_success, 'Request should succeed' );


#my $rs = ResultSet('Session');
#use Data::Dumper;
#while (my $session = $rs->next){
#    diag(Dumper({$session->get_columns}));
#}


done_testing();
