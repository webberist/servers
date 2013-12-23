#!/usr/bin/perl

print '
;RPZ generated by convert2bindrpz.pl
$TTL 10
@       IN SOA rpz.block.ls. rpz.ls. (
       201312231;
       3600;
       300;
       86400;
       60 )
       IN      NS      localhost.

';

open (FILE, "$ARGV[0]");
while (<FILE>) {
  chomp; 
  push(@list, lc($_)); #lc is lowercase
}
close (FILE);

sub uniq {
    return keys %{{ map { $_ => 1 } @_ }};
}

@uniquelist = uniq(@list);

foreach (@uniquelist) {
  $val = $_;
  if ($val =~ /^((([a-z]|[0-9]|\-)+)\.)+([a-z])+$/i)
  {
    #youtube.com             IN CNAME block.ls.
    print "$val IN CNAME .\n";
    print "*.$val IN CNAME .\n";
    #print "zone \"$val\" in { type master ; file \"/etc/bind/db.blocked\" ; } ;\n";
  } else {
    #print "; $val\n";
  }
}
exit;

