# Makefile
# 
# Converts Markdown to other formats (HTML, PDF, DOCX, RTF, ODT, EPUB) using Pandoc
# <http://johnmacfarlane.net/pandoc/>
#
# Run "make" (or "make all") to convert to all other formats
#
# Run "make clean" to delete converted files


#
#  New stuff; use distinct variable names
#
MD_FILES = $(wildcard md/*.md)
PDF_FILES = $(patsubst md/%.md,pdf/%.pdf,$(MD_FILES))
HTML_FILES = $(patsubst md/%.md,html/%.html,$(MD_FILES))
OUTPUT_FILES = $HTML_FILES $PDF_FILES

html/%.html: md/%.md
	echo $@ "into" $<

pdf/%.pdf: md/%.md
	echo $@ "into" $<

.PHONY: newall newhtml newpdf

newall: html pdf
newhtml : $(HTML_DOCS)
newpdf : $(PDF_DOCS)



# Convert all files in the md subirectory that have a .md suffix
SOURCE_DOCS := $(wildcard *.md)

# I’d really prefer to keep outputs in their own subdirectories, but this is fine for now.

OUTPUT_DOCS=\
 $(SOURCE_DOCS:.md=.html) \
 $(SOURCE_DOCS:.md=.pdf) \
# $(SOURCE_DOCS:.md=.docx) \
# $(SOURCE_DOCS:.md=.rtf) \
# $(SOURCE_DOCS:.md=.odt) \
# $(SOURCE_DOCS:.md=.epub)

HTML_DOCS=$(SOURCE_DOCS:.md=.html)
LATEX_DOCS=$(SOURCE_DOCS:.md=.tex)
PDF_DOCS=$(SOURCE_DOCS:.md=.pdf)



RM=/bin/rm

PANDOC=/usr/local/bin/pandoc

PANDOC_OPTIONS=--standalone --number-sections

PANDOC_HTML_OPTIONS=--to html5 --default-image-extension=png --mathjax --template=easy_template.html -M fontsize=18px -M maxwidth=50em
PANDOC_PDF_OPTIONS=--default-image-extension=pdf
PANDOC_LATEX_OPTIONS=--default-image-extension=pdf
PANDOC_DOCX_OPTIONS=
PANDOC_RTF_OPTIONS=
PANDOC_ODT_OPTIONS=
PANDOC_EPUB_OPTIONS=--to epub3
PANDOC_BOOK_OPTIONS=--top-level-division=chapter --toc --toc-depth=2


# Pattern-matching Rules

%.html : %.md Makefile
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_HTML_OPTIONS) -o $@ $<

%.pdf : %.md Makefile
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_PDF_OPTIONS) -o $@ $<
	
%.tex : %.md Makefile
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_LATEX_OPTIONS) -o $@ $<
	
%.docx : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_DOCX_OPTIONS) -o $@ $<

%.rtf : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_RTF_OPTIONS) -o $@ $<

%.odt : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_ODT_OPTIONS) -o $@ $<

%.epub : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_EPUB_OPTIONS) -o $@ $<


# Targets and dependencies

.PHONY: all latex html pdf book clean # publish

all : $(OUTPUT_DOCS)
latex : $(LATEX_DOCS)
html : $(HTML_DOCS)
pdf : $(PDF_DOCS)

#
#  I really want to use "-t chunkedhtml" but it doesn't play well with easy_template.html.
#
bookhtml : $(SOURCE_DOCS)
	$(PANDOC) $(PANDOC_OPTIONS) --toc --toc-depth=2 ${PANDOC_HTML_OPTIONS} -o Book.html $(SOURCE_DOCS)

bookpdf : ${SOURCE_DOCS}
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_BOOK_OPTIONS) $(PANDOC_PDF_OPTIONS) -o Book.pdf $(SOURCE_DOCS)

books: bookhtml bookpdf

clean:
	- $(RM) $(OUTPUT_DOCS)
	
# publish: all
#	rsync -avu $(OUTPUT_DOCS) ../Web/notes
#	rsync -avru Fig/*.pdf Fig/*.png Fig/derived-maps ../Web/notes/Fig/

