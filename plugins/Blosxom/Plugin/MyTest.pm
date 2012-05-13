# Plugin name: MyTest
# Author: Barijaona Ramaholimihaso
# Version: 2007-08-19blosxom4
# Blosxom Home/Docs/Licensing: http://blosxom.sourceforge.net

# Documentation:
# This is a pretty simple plugin for testing Actions calls
# in Interpolate_fancy

package Blosxom::Plugin::MyTest;

# --- Configurable variables -----

# (none)

# --------------------------------

sub start {
    1;
}

# This action strips HTML from its content
sub strip_html {
  my($self, $attributes, $content) = @_;
  $content =~ s!</?.+?>!!g;
  return $content;
}

# This action foreshortens its content to a length specified in the call to
# action's length attribute
sub foreshorten {
  my($self, $attributes, $content) = @_;
  my $default_length = 144;
  return substr($content, 0, $attributes->{'length'}||$default_length);
}

1;

