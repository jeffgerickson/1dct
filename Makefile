# Makefile
# 
# Run "make" (or "make all") to convert to all other formats
#
# Run "make clean" to delete converted files
#

MD_FILES = $(wildcard md/*.md)
PDF_FILES = $(patsubst md/%.md,pdf/%.pdf,$(MD_FILES))
HTML_FILES = $(patsubst md/%.md,html/%.html,$(MD_FILES))
OUTPUT_FILES = $HTML_FILES $PDF_FILES


#
#  Options
#

RM=/bin/rm

PANDOC=/usr/local/bin/pandoc

PANDOC_OPTIONS=--number-sections

PANDOC_HTML_OPTIONS=--standalone --default-image-extension=png --mathjax -M fontsize=18px -M maxwidth=50em

# removed --template=easy_template.html

PANDOC_PDF_OPTIONS=--default-image-extension=pdf

PANDOC_EPUB_OPTIONS=--to epub3

PANDOC_BOOK_OPTIONS=--top-level-division=chapter --toc --toc-depth=2 -Vtoc


#
#  Pattern matching rules
#

html/%.html: md/%.md Makefile
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_HTML_OPTIONS) -o $@ $<
	
pdf/%.pdf: md/%.md Makefile
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_PDF_OPTIONS) -o $@ $<



#
#  Targets and dependencies
#


.PHONY: all html pdf books 

#  Chapters

all: html pdf
html : $(HTML_FILES)
pdf : $(PDF_FILES)


# Whole book

bookhtml : $(SOURCE_DOCS)
	rm -rf Book
	$(PANDOC) -t chunkedhtml $(PANDOC_OPTIONS) ${PANDOC_BOOK_OPTIONS} ${PANDOC_HTML_OPTIONS} -o Book $(MD_FILES)

bookpdf : ${SOURCE_DOCS}
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_BOOK_OPTIONS) $(PANDOC_PDF_OPTIONS) -o pdf/Book.pdf $(MD_FILES)

books: bookhtml bookpdf



# clean:
#	- $(RM) $(OUTPUT_DOCS)
	
# publish: all
#	rsync -avu $(OUTPUT_DOCS) ../Web/notes
#	rsync -avru Fig/*.pdf Fig/*.png Fig/derived-maps ../Web/notes/Fig/

