use strict;
use warnings;

use Lecstor::Shop::Catalyst;

my $app = Lecstor::Shop::Catalyst->apply_default_middlewares(Lecstor::Shop::Catalyst->psgi_app);
$app;

