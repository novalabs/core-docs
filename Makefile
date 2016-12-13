SRC_BASEPATH = ./docs
HTML_BASEPATH = ./html
PDF_BASEPATH = ./pdf

SRC_FILES = $(shell find $(SRC_BASEPATH) -type f -name index.adoc)
HTML_FILES=$(patsubst $(SRC_BASEPATH)/%.adoc, $(HTML_BASEPATH)/%.html, $(SRC_FILES))
PDF_FILES=$(patsubst $(SRC_BASEPATH)/%.adoc, $(PDF_BASEPATH)/%.pdf, $(SRC_FILES))

print-%:
	@echo '$*=$($*)'

.PHONY : clean prepare html

all: clean prepare html

clean:
	@rm -rf $(HTML_BASEPATH)

prepare:
	@mkdir -p $(HTML_BASEPATH) $(PDF_BASEPATH)

html: $(HTML_FILES)

$(HTML_BASEPATH)/%.html: $(SRC_BASEPATH)/%.adoc
	asciidoctor -b html5 -r asciidoctor-diagram -a experimental -a toc=left -a toclevels=3 -a data-uri -a icons=font -a source-highlighter=coderay -a plantuml_format=png -o $@ $<
