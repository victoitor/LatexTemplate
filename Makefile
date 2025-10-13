# Rodar tarefas em paralelo
MAKEFLAGS += -j
MAKEFLAGS += --output-sync

# Diretórios
SRCDIR	:= src
TMPDIR	:= tmp
OUTDIR	:= out

# Procura todos os arquivos .tex nas subpastas de src/ ou lista manualmente
TEXFILES	:= $(shell find $(SRCDIR) -type f -name '*.tex')
# TEXFILES	:= $(SRCDIR)/paper.tex
PDFFILES	:= $(TEXFILES:$(SRCDIR)/%.tex=$(OUTDIR)/%.pdf)

# Flags para os comandos
LATEXFLAGS		:= -pdf
LATEXFLAGS		+= -synctex=1 
LATEXFLAGS		+= -interaction=nonstopmode 
LATEXFLAGS		+= -file-line-error 
LATEXFLAGS		+= -emulate-aux-dir 

.PHONY: all
all: pdf

.PHONY: pdf
pdf: $(PDFFILES)

# Regra para gerar .pdf a partir de .tex.
$(OUTDIR)/%.pdf: $(SRCDIR)/%.tex
	latexmk $(LATEXFLAGS) -aux-directory=$(dir $(TMPDIR)/$*) -output-directory=$(dir $@) $<

# Limpa os arquivos temporários
.PHONY: clean-tmp
clean-tmp:
	rm -rf $(TMPDIR)

# Limpa os arquivos de saída e temporários
.PHONY: clean
clean: clean-tmp
	rm -rf $(OUTDIR)
