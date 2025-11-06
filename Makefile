# Rodar tarefas em paralelo
# MAKEFLAGS += -j
# MAKEFLAGS += --output-sync

# Diretórios
SRCDIR	:= src
TMPDIR	:= tmp
OUTDIR	:= out
CURDIR	:= $(shell pwd)

# Inclui arquivo com definição de texfiles, se existir. Se TEXFILES não estiver definido, usa todos que estão na pasta src
-include $(SRCDIR)/.env.texfiles
ifdef TEXFILES
	TEXFILES := $(subst ",,$(TEXFILES))
else
	TEXFILES := $(shell find $(SRCDIR) -type f -name '*.tex' -printf '%P ')
endif

# Arquivos pdf no diretório de saída a partir dos arquivos de entrada
PDFFILES	:= $(TEXFILES:%.tex=$(OUTDIR)/%.pdf)

# Flags para os comandos
LATEXFLAGS		= -pdf
LATEXFLAGS		+= -cd
LATEXFLAGS		+= -file-line-error 
LATEXFLAGS		+= -emulate-aux-dir 
# Incluir apenas um dos dois a seguir
# LATEXFLAGS		+= -interaction=nonstopmode 
LATEXFLAGS		+= -halt-on-error


.PHONY: all
all: pdf-synctex

.PHONY: pdf
pdf: $(PDFFILES)

.PHONY: pdf-synctex
pdf-synctex: LATEXFLAGS	+= -synctex=1 
pdf-synctex: pdf

# Regra para gerar .pdf a partir de .tex.
.PHONY: FORCE_MAKE
$(OUTDIR)/%.pdf: $(SRCDIR)/%.tex FORCE_MAKE
	latexmk $(LATEXFLAGS) -aux-directory=$(CURDIR)/$(dir $(TMPDIR)/$*) -output-directory=$(CURDIR)/$(dir $@) $<

# Limpa os arquivos temporários
.PHONY: clean-tmp
clean-tmp:
	rm -rf $(TMPDIR)

# Limpa os arquivos de saída e temporários
.PHONY: clean
clean: clean-tmp
	rm -rf $(OUTDIR)
