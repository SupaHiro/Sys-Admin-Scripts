# ! /usr/bin/perl
# Original Author: Occams Reiza
#
# Program Name: Mule Agent Monitoring
#
# Purpose: Get status of Mule Agents
#
# Dated Revisions: see RCS
# ---------------------------------------------------
use strict;
# Local Variable Definitions
my $HOSTNAME = `hostname`; 
my $DATE = `date`;
#my $MULEHOME="/usr/local/mule_enterprise_standalone_3.4.0/";
use Time::Local;
my $MULEAPPLOG="/Users/Reiza/Downloads/mule-app-monitorncs.log";
my $APP="MonitorNCS";
my $currenttime;
my $lasttime;
my $diff = $currenttime - $lasttime;
my $sec; 
my $min; 
my $hr; 
my $day; 
my %moy;
my $month; 
my $year; 
my $time;
my $lasttime = 0;
my $lastmonth;
my $iastday ;
my $newone = 0;
$ENV{lasttime} = scalar localtime($lasttime);
chomp $HOSTNAME;

&load_months;
chomp $DATE; ( $DATE, $month, $day, $time, $DATE, $year ) = split / +/, $DATE; ( $hr, $min, $sec ) = split( ":", $time );
my $currenttime = timelocal( $sec, $min, $hr, $day, $moy{$month}, $year );
$| = 1;

#Redirect Output
#open STDOUT, ">' "/tmp/PersonUpdateTopic.dat or die '$0: open: $!'; #open STDERR, >&STDOUT"	or die $0: dup: $!";

#Grab timestamp of last run

open( TIMESTAMP, "/tmp/ctmonitor.ts" ) or $lasttime = 1;
if ( $lasttime != 1 ) {
	($lasttime) = split /:/, <TIMESTAMP>; 
	chomp $iasttime;
}
close TIMESTAMP;

print "Current Time = ", scalar localtime($currentime),"Last time looked was: ", scalar
localtime($lasttime), "\n" ;

# Opens log and compares time to last time checked and then searches for errors 
	open(FILE, $MULEAPPLOG) or die ( "Could not open log file \n" );
	while (<FILE>){
			chomp $_;
		if ( $_ =~/(....-..-..)	(.........)/gs)	{
		( my $ymd, $time
		( $year, $month, $day ) = split -, $yrnd;
		( $hr, $min, $sec ) = split( ":", $time );
		my $epochtime = timelocal( $sec, $min, $hr, $day, $month-1, $year );

		if ( $month ne $lastmonth || $day ne $last_day ) { 
			$lastmonth = $month;
			$lastday = $day;
		}
	if ( $lasttime < $epochtime ) {
		$newone = $epochtime;
	if ($_ =~ m/^ERROR/) {
	print "Found an error in $APP log on $HOSTNAME on ".scalar localtime ( $epochtime) , " \n";

	print "$_\n";
	#/bin/mail -s "WARN: MonitorNCS at $HOSTNAME is not responding..... Reiza\@xxx.com< /tmp/PersonUpdateTopic.dat';
}
}
close (FILE);
}
}
#Create Timestamp file
open( TIME, " > / tmp/ctmonitor . ts " ) ; print TIME " $currenttime\n " ; close TIME;

#Convert Months to Human Readable sub load_monthsmonths
sub load_months
{
$moy{Jan} =	0;
$moy{Feb} =	1; 
$moy{Mar} =	2; 
$moy{Apr} =	3; 
$moy{May} =	4; 
$mov{Jun} =	5; 
$moy{Jul} =	6; 
$moy{Aug} =	7;
$moy{Sep} = 8; 
$moy{Oct} = 9; 
$mov{Nov} = 10; 
$moy{Dec} = 11; 
} 
exit;

