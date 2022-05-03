#!/usr/bin/perl -n
#
# diffmaxmunge: normalise max patcher files in text format: remove all graphical stuff
#
# use with git:
# - in local or globar .gitconfig:
# [diff "max"]
#	textconv = /Users/schwarz/bin/diffmaxmunge.pl
#
# - in local .gitattributes
# *.maxpat diff=max
# *.maxhelp diff=max
# *.amxd -text diff=max
# 
# - when cachetextconv = true
#   clear cache: git update-ref -d refs/notes/textconv/max
#
#
# $Id: diffmaxmunge.pl,v 1.8 2019/06/18 14:51:16 schwarz Exp $
#
# $Log: diffmaxmunge.pl,v $
# Revision 1.8  2019/06/18 14:51:16  schwarz
# Summary: remove trailing commas, even more filters for M4L, now things start to make sense
#
# Revision 1.6  2019/04/08 11:13:15  schwarz
# Summary: 29.6.2016: new keywords to ignore for max 7
#
# Revision 1.5  2015/02/05 11:46:07  schwarz
# more filters,
# de-tab, use if
#
# Revision 1.4  2010/10/18 15:10:00  schwarz
# max5
#
# Revision 1.3  2010/07/30 14:06:20  schwarz
# 25.4.2009: remove ftm object ids
#
# Revision 1.2  2007/11/27 13:29:21  schwarz
# more obj
# fix user
# throw out all connections
#
# Revision 1.1  2007/06/20 13:36:53  schwarz
# 24.10.2007: created

BEGIN
{
    my @keys = (qw(rect defrect openrect patching_rect presentation_rect client_rect storage_rect devicewidth
		  fontname fontface fontsize default_fontsize default_fontname default_fontface 
		  frgb brgb 
		  ftm_scope ftm_objref_conv linecount presentation_linecount
		  midpoints hidden restore 
		  appversion architecture major minor revision disabled parameter_enable statusbarvisible tags globalpatchername description digest
		  opacityprogressive toptoolbarpinned useplaceholders), # new in max7
	       qw(patcherrelativepath bootpath implicit type
		  numinlets numoutlets box outlettype bang int float presentation
		  modernui bglocked bottomtoolbarpinned boxanimatetime boxes style parentstyle
		  \w*toolbar\w* grid\w* parameter_\w* index visible
		  color textcolor textcolor_inverse bgcolor bgmode selectioncolor elementcolor border 
		  clickthrough enablehscroll enablevscroll lockeddragscroll
		  id patchline patchlinecolor order destination source obj-\d+), # new in max8
	       qw(angle autogradient saved_object_attributes attr_comment)); # new in max8.3

    # build filter that matches "keyword" or decimal values arrays on separate lines 
    $filter = '^\s*("(' . join('|', @keys) . ')"|\d+\.?\d*,?|[\]\{\}],?)';

    # print STDERR "\n$0 @ARGV: filter = $filter\n";
}

# remove trailing commas to avoid differing lines at end of dict
s/,$//;

# drop filtered lines from file
if (!m/$filter/)
{
    s/\t/  /g;
    print;
}

###### max4 

if (0)
{
my $d = '-?\d+';

# remove coordinates and font for objects
s/^(\#P (hidden )?(newobj|newex|inlet|outlet|message|comment|button|bpatcher|number|flonum)) $d $d $d $d/$1 X X X X/;

# user objects
s/^(\#P (hidden )?user (ubumenu|dropfile|gain~|meter~|ezdac~|ftm\.object|ftm\.mess|ftm\.vecdisplay)) $d $d $d $d/$1 X X X X/;

# patcher coordinates
s/^(\#N vpatcher) $d $d $d $d/$1 X X X X/;
s/^(\#P origin) $d $d/$1 X X/;

# segmented patch cords: don't care at all
#s/^(\#P (hidden )?(fasten|connect)) .*$/$1 XXX/;

# throw out all connections
s/^(\#P )(hidden )?(fasten|connect) .*$/$1 CCC/;

# remove ftm object ids
s/^(\#T _\#obj) \d+/$1 OOO/;

}
