package Lecstor::Shop::Catalyst;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    ConfigLoader
    Static::Simple
    Session
    Session::Store::Lecstor
    Session::State::Cookie
    Authentication
    RunAfterRequest
    Unicode::Encoding
/;

extends 'Catalyst';

with 'Lecstor::Role::Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in lecstor_shop_catalyst.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'Lecstor::Shop::Catalyst',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header => 1, # Send X-Catalyst header

    'Plugin::Authentication' => {
        use_session => 1,
        default => {
            credential => {
                class => 'Password',
                password_type => 'self_check',
            },
            store => {
                class => 'Lecstor',
            },
        },
    },

    'View::TT' => {
        include_paths => [qw! bootstrap plain !],
    },

);

# Start the application
__PACKAGE__->setup();


=head1 NAME

Lecstor::Shop::Catalyst - Catalyst based application

=head1 SYNOPSIS

    script/lecstor_shop_catalyst_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Lecstor::Shop::Catalyst::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Jason Galea <lecstor@cpan.org>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
