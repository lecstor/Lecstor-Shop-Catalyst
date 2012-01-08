#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use utf8;

use FindBin qw($Bin);

$ENV{LECSTOR_DEPLOY} ||= 'test';
$ENV{EMAIL_SENDER_TRANSPORT} = 'Test';


use Encode;
use HTTP::Request::Common;
use File::Path qw!rmtree!;
use Lecstor::Test::Content;

use Test::DBIx::Class {
    config_path => [ File::Spec->splitdir($Bin), qw(etc schema) ],
    resultsets => [ 'User' ],
};

use_ok 'Test::WWW::Mechanize::Catalyst', 'Lecstor::Shop::Catalyst';

Lecstor::Shop::Catalyst->model('Schema')->schema(Schema);

fixtures_ok 'basic'
    => 'installed the basic fixtures from configuration files';


my $mech = Test::WWW::Mechanize::Catalyst->new;

#-----------------------
$mech->post_ok(
    '/login_or_register',
    {
        email => 'jason@lecstor.com',
        username => '例えば',
        password => 'näytenäyte',
        action => 'Register',
    }
);

ok my $login = User->find({ email => 'jason@lecstor.com' })
  => 'login created' or diag($mech->content);

$mech->post_ok(
    '/login',
    {
        email => 'jason@lecstor.com',
        password => 'näytenäyte',
        action => 'Sign In',
    }
);
$mech->content_like( qr!uri: "/"!, 'is home page' )
    or diag(get_view_meta($mech->content));
$mech->content_like( qr!Logged in as!, 'logged in' );

my $encode_str = '例えば';
my $decode_str = Encode::encode('utf-8' => $encode_str);

$mech->content_like( qr!$decode_str!, 'account link ok' );


done_testing();



