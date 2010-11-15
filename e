#!/usr/bin/perl -w
#
# e: enter an OpenVZ container using a part of its domain name.
# (C) dkLab, http://en.dklab.ru/lib/dklab_vzenter/
# version 1.02
#

my $mask = $ARGV[0] or die "Usage:\n  $0 hostname_part\n";
my @hosts = map { s/^\s+|\s+$//sg; [ m/^(\S+).*?(\S+)$/ ] } split /\n/, `vzlist -H`;

my @ok = ();
my @best = ();
OUTER:
foreach my $info (@hosts) {
        if ($info->[1] =~ m/^\Q$mask/s || $info->[0] eq $mask) {
            push @best, $info;
        }
        my @name = split //, $info->[1];
        foreach my $c (split //, $mask) {
                shift @name while (@name && $name[0] ne $c);
                next OUTER if !@name;
                shift @name;
        }
        push @ok, $info;
}

if (!@ok && @best) {
        @ok = @best;
}

if (!@ok) {
        die "No matching hosts found: searched through\n" . join("\n", map { "  " . $_->[0] . "  " . $_->[1] } @hosts) . "\n";
}

if (@ok > 1) {
        if (@best == 1) {
                @ok = @best;
        } else {
                die "More than one match found, please disambiguate:\n" . join("\n", map { "  " . $_->[0] . "  " . $_->[1] } @ok) . "\n";
        }
}

print "Entering " . $ok[0][1] . "\n";
$cmd = "vzctl enter " . $ok[0][0];
exec $cmd;
