# Diretórios
SRCDIR	:= src
TMPDIR	:= tmp
OUTDIR	:= out

# Procura todos os arquivos .tex nas subpastas de src/ e faz escape de espaços
# TEXFILES	:= $(shell find $(SRCDIR) -type f -name '*.tex' | sed 's/\ /\\ /g')
TEXFILES	:= $(SRCDIR)/paper.tex
PDFFILES	:= $(TEXFILES:$(SRCDIR)/%.tex=$(OUTDIR)/%.pdf)

# Flags para os comandos
LATEXOUTPUT		:= -pdf
LATEXFLAGS		:= -synctex=1 -interaction=nonstopmode -file-line-error 

.PHONY: all pdf
all: pdf
pdf: $(PDFFILES)

.SECONDEXPANSION:
# Regra para gerar .pdf a partir de .tex.
$(OUTDIR)/%.pdf: $(SRCDIR)/%.tex
	latexmk $(LATEXOUTPUT) $(LATEXFLAGS) -emulate-aux-dir -aux-directory=$(dir $(TMPDIR)/$(*)) -output-directory=$(dir $@) $<

# Limpa os arquivos temporários
.PHONY: clean-tmp
clean-tmp:
	rm -rf $(TMPDIR)

# Limpa os arquivos de saída e temporários
.PHONY: clean
clean: clean-tmp
	rm -rf $(OUTDIR)
