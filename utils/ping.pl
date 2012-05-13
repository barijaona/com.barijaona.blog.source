#!/usr/bin/perl

package xml_ping_weblogs;

# --- Configurable variables -----

# What URL should this plugin ping?
require LWP::UserAgent;
use FileHandle;
use File::stat;
use Data::Dumper;


# Okay, so we can't encode the values, we have to leave the slashes in and all.
	my $blog_name = '&amp;Eacute;tonnements rapides et durable';
	my $blog_url  = "http://homepage.mac.com/barijaona/";
	
	my $content = <<EOF;
<?xml version="1.0"?>
<methodCall>
  <methodName>weblogUpdates.ping</methodName>
  <params>
     <param><value>$blog_name</value></param>
     <param><value>$blog_url</value></param>
  </params>
</methodCall>
EOF

	$header = new HTTP::Headers;


# weblogues.com
	$header->header( User_Agent => 'blosxom ping',
					 Host => 'www.weblogues.com',
					 Content_Type => 'text/xml',
					 Content_Length => length ($content));
	
	$request = HTTP::Request->new( 'POST' ,'http://www.weblogues.com/RPC/',
								  $header,
								  $content);
	
	$ua = LWP::UserAgent->new;
	$response = $ua->request($request);

	my $result = $response->{_content};

	$result =~ /Merci pour la notification/ and print "Ok pour weblogues.com\n";



# weblogs.com
	$header->header( User_Agent => 'blosxom ping',
					 Host => 'rpc.weblogs.com',
					 Content_Type => 'text/xml',
					 Content_Length => length ($content));
	
	$request = HTTP::Request->new( 'POST' ,'http://rpc.weblogs.com/RPC2',
								  $header,
								  $content);
	
	$ua = LWP::UserAgent->new;
	$response = $ua->request($request);

	$result = $response->{_content};

	$result =~ /Thanks for the ping/ and print "Ok pour weblogs.com\n";

# http://ping.blo.gs/
	$header->header( User_Agent => 'blosxom ping',
					 Host => 'ping.blo.gs',
					 Content_Type => 'text/xml',
					 Content_Length => length ($content));
	
	$request = HTTP::Request->new( 'POST' ,'http://ping.blo.gs',
								  $header,
								  $content);
	
	$ua = LWP::UserAgent->new;
	$response = $ua->request($request);

	$result = $response->{_content};
	$result =~ /Succeeded/ and print "Ok pour blo.gs\n";

# Technorati
	$header->header( User_Agent => 'blosxom ping',
					 Host => 'rpc.technorati.com',
					 Content_Type => 'text/xml',
					 Content_Length => length ($content));
	
	$request = HTTP::Request->new( 'POST' ,'http://rpc.technorati.com/rpc/ping',
								  $header,
								  $content);
	
	$ua = LWP::UserAgent->new;
	$response = $ua->request($request);

	$result = $response->{_content};

	$result =~ /Thanks for the ping/ and print "Ok pour Technorati\n";



1;

__END__

=head1 NAME

Blosxom Plug-in: xml_weblogs_com

=head1 SYNOPSIS

Purpose: Notifies weblogs.com [http://www.weblogs.com] that your weblog
has been updated upon encountering any new story. 

Maintains a touch-file ($blosxom::plugin_state_dir/.ping_weblogs_com.output)
to which to compare the newest story's creation date.  Fills the
touch-file with the HTML results of the latest ping.

=head1 VERSION

2.0b3

Version number coincides with the version of Blosxom with which the 
current version was first bundled.

=head1 AUTHOR

Bob Schumaker <cobblers@pobox.com>, http://www.cobblers.net/blog/

=head1 SEE ALSO

Blosxom Home/Docs/Licensing: http://www.raelity.org/apps/blosxom/

Blosxom Plugin Docs: http://www.raelity.org/apps/blosxom/plugin.shtml

=head1 BUGS

Address bug reports and comments to the Blosxom mailing list 
[http://www.yahoogroups.com/group/blosxom].

=head1 LICENSE

Blosxom and this Blosxom Plug-in
Copyright 2003, Rael Dornfest 

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
