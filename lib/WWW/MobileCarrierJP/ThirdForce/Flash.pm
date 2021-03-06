package WWW::MobileCarrierJP::ThirdForce::Flash;
use strict;
use warnings;
use utf8;
use charnames ':full';
use WWW::MobileCarrierJP::Declare;

my $url = 'http://creation.mb.softbank.jp/terminal/?lup=y&cat=flash';
my $xpath = '//div/table/tr/td/table[@bordercolor="#999999"]/tr[not(@bgcolor="#ee9abb") and not(@bgcolor="#cccccc") and count(child::td) != 1]';

parse_one(
    urls    => [$url],
    xpath   => $xpath,
    scraper => scraper {
        col 1 => 'model', 'TEXT';
        col 2 => 'flashlite' => [
            'TEXT',
            sub { s/^Flash Lite\N{TRADE MARK SIGN}// },
            sub { s/\s// },
            sub { $_ = undef if /\N{MULTIPLICATION SIGN}/ },    # `x' case.
        ];
        col 3 => 'support_flash9',          [ 'TEXT', \&_marubatsu ];
        col 4 => 'support_embedded_flv',    [ 'TEXT', \&_marubatsu ];
        col 5 => 'support_progressive_flv', [ 'TEXT', \&_marubatsu ];
    },
);

sub _marubatsu { $_ = $_ =~ /\N{WHITE CIRCLE}|\N{BULLSEYE}/ ? 1 : 0 }

1;
__END__

=head1 NAME

WWW::MobileCarrierJP::ThirdForce::Flash - get Flash informtation from ThirdForce site.

=head1 SYNOPSIS

    use WWW::MobileCarrierJP::ThirdForce::Flash;
    WWW::MobileCarrierJP::ThirdForce::Flash->scrape();

=head1 AUTHOR

Tokuhiro Matsuno < tokuhirom gmail com >

=head1 SEE ALSO

L<WWW::MobileCarrierJP>

