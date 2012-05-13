#!/usr/bin/perl
##
## A blosxom-centric del.icio.us parser that
## creates blosxom entries of your daily
## del.icio.us links.
##
## Best if cron-ed to run daily.
##
## To Do:
##   - make it so it doesn't render blank entires
##     on dates with no new bookmarks
##
## By: Brett O'Connor (oconnorb@dogheadbone.com)
## Last Revision Date: 01/21/2004
#############################################################
require XML::Parser;

#your del.icio.us account info
$login = "barijaona";
$password = "prjilg";

#file name and location setup for ouputting to file 
$timestamp = time();
$outfile = "/Users/barijaon/blosxom/posts/musardages/".$timestamp.".txt";

#ouput header and footer
$header = "Liens sur del.icio.us\n\n";
$footer = "";

#get todays entries
($Second, $Minute, $Hour, $Day, $Month, $Year, $WeekDat, $DayOfYear, $IsDST) = localtime(time);
my $RealMonth = $Month + 1;
if ($RealMonth < 10)
{
    $RealMonth = "0" . $RealMonth;
}
if ($Day < 10)
{
    $Day = "0" . $Day;
}
$FixedYear = $Year + 1900;
$date = "$FixedYear-$RealMonth-$Day";
system ("curl -s -u $login:$password 'http://del.icio.us/api/posts/get?dt=$date' -o 'tmp.xml'");
#create the output
my $parser = new XML::Parser (Style=>'Subs', Pkg=>'SubHandlers', ErrorContext=>2);
$parser->setHandlers(Char => \&charData);

my $out;

$parser->parsefile("tmp.xml");

#write out entry if to file
#$outputTo = 'screen'; #debugging purposes
$outputTo = 'file';
if ($outputTo eq 'file') {
    open(FILE, ">$outfile");
    print FILE "$header";
    print FILE "$out";
    print FILE "$footer";
    close(FILE);
} else {
    printf($header);
    printf($out);
    printf($footer);
}

#delete temp file
system ("rm tmp.xml");

sub charData 
{
    #kill misc data
}
package SubHandlers;
sub post {
    my $expat = shift; my $element = shift;
    while (@_) {
        my $att = shift;
        my $val = shift;
        $attr{$att} = $val;
    }
    # here's where each entry is outputted - add formatting here
    $out .= "<a href=\"".$attr{'href'}."\" title=\"".$attr{'description'}."\">";
    if ($attr{'extended'}) {
        $out .= $attr{'extended'};
        undef $attr{'extended'};
    }
    $out .= "</a>";
}
sub post_ {
    $out .= "\n\n";
}
