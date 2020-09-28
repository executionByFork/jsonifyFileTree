#! /usr/bin/perl

use JSON;
use Digest::MD5::File qw(file_md5_hex);

my $encoder = JSON->new->ascii->pretty;   # ascii character set, pretty format
my %tree;                                 # used to build the data structure

my $path = undef;
my $hash = 0;
for (my $i=0; $i < scalar @ARGV; $i++) {
    if ($ARGV[$i] eq "--hash") {
        $hash = 1;
    } else {
        if (! defined $path) {
            $path = $ARGV[$i];
        } else {
            print "ERROR: Unknown argument: $ARGV[$i]\n";
            die;
        }
    }
}
if (! defined $path) {
    $path = '.';    # use the command line arg or working dir
}

# print out the JSON encoding of this data structure
print $encoder->encode(parse_dir("$path"));

sub parse_dir {
    my $path = shift;    # the dir we're working on

    # Open the directory, read in the file list, grep out directories and skip '.' and '..'
    opendir(my $dh, $path) or die "can't opendir $path: $!";
    my @dirs = grep { ! /^[\.]{1,2}$/ && -d "$path/$_" } readdir($dh);
    rewinddir $dh;
    my @files = grep { ! /^[\.]{1,2}$/ && -f "$path/$_" } readdir($dh);
    closedir($dh);

    my %hash;
    foreach my $dir (@dirs) {
        my $res = parse_dir("$path/$dir");    # recurse down each path and get results
        $hash{$dir} = $res;
    }
    foreach my $file (@files) {
        $h = "";
        if ($hash) {
            $h = file_md5_hex("$path/$file");
        }
        $hash{$file} = $h;
    }

    return \%hash;  # return the recursed result
}
