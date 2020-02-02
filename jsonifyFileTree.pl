#! /usr/bin/perl

use JSON;

my $encoder = JSON->new->ascii->pretty;   # ascii character set, pretty format
my %tree;                                 # used to build the data structure

my $path=$ARGV[0] || '.';                 # use the command line arg or working dir

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

    my %hash;                                 # set result to an empty hash
    foreach my $dir (@dirs) {                 # loop the sub directories         
        my $res = parse_dir("$path/$dir");    # recurse down each path and get results
        $hash{$dir} = $res;
    }
    foreach my $file (@files) {
        $hash{$file} = undef;
    }

    return \%hash;  # return the recursed result
}
