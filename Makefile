##-*- makefile -*-############################################################
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Robert Heller
#  Created       : Wed Apr 2 14:10:16 2025
#  Last Modified : <261122.1535>
#
#  Description	
#
#  Notes
#
#  History
#	
#  $Log$
#
##############################################################################
#
#    Copyright (C) 2025  Robert Heller D/B/A Deepwoods Software
#			51 Locke Hill Road
#			Wendell, MA 01379-9728
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# 
#
##############################################################################


all: TalkSlides.pdf TalkNotes.pdf

TalkSlides.pdf: TalkSlides.tex rphpartpage.sty TalkSlides.d 
	-rm -f TalkSlides.pdf TalkSlides.toc TalkSlides.snm TalkSlides.out TalkSlides.nav TalkSlides.aux TalkSlides.log
	pdflatex TalkSlides.tex
	pdflatex TalkSlides.tex
	pdflatex TalkSlides.tex


TalkSlides.d: ImageDeps.tcl TalkSlides.tex 
	echo "TalkSlides.pdf: \\" > TalkSlides.d
	tclsh ImageDeps.tcl TalkSlides.tex >> TalkSlides.d
	echo "" >> TalkSlides.d
	
-include TalkSlides.d

TalkNotes.pdf: TalkNotes.tex TalkNotes.d 
	-rm -f TalkNotes.pdf TalkNotes.toc TalkNotes.aux TalkNotes.log
	pdflatex TalkNotes.tex
	pdflatex TalkNotes.tex
	pdflatex TalkNotes.tex
	pdflatex TalkNotes.tex

TalkNotes.d: ImageDeps.tcl TalkNotes.tex
	echo "TalkNotes.pdf: \\" > TalkNotes.d
	tclsh ImageDeps.tcl TalkNotes.tex >> TalkNotes.d
	echo "" >> TalkNotes.d
	
-include TalkNotes.d

%.png: %.jpg
	convert $< $@

ClearNailPolish.png: ClearNailPolish.jpeg
	convert $< $@

Release: all
	zip LinuxTalkMaterials-`git rev-parse --short HEAD`.zip TalkSlides.pdf TalkNotes.pdf
