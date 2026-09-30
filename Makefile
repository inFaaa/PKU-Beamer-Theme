# Optional convenience commands; XeLaTeX and BibTeX must be on PATH.
XELATEX ?= xelatex
BIBTEX ?= bibtex
LATEXFLAGS = -interaction=nonstopmode -halt-on-error -file-line-error

.PHONY: all pdf tutorial clean

all: pdf

# Build a working copy without overwriting the bundled tutorial.
pdf:
	mkdir -p build
	$(XELATEX) $(LATEXFLAGS) -output-directory=build slide.tex
	$(BIBTEX) build/slide
	$(XELATEX) $(LATEXFLAGS) -output-directory=build slide.tex
	$(XELATEX) $(LATEXFLAGS) -output-directory=build slide.tex

# Refresh the PDF shipped with the repository.
tutorial: pdf
	cp build/slide.pdf How_to_do_pku_beamer_theme.pdf

# Keep source files and the bundled tutorial.
clean:
	rm -rf build
