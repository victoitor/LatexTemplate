# Rodar tarefas em paralelo
MAKEFLAGS += -j
# MAKEFLAGS += --output-sync

# Diretórios
SRCDIR	:= src
TMPDIR	:= tmp
CURDIR	:= $(shell pwd)

# Inclui arquivo com definição de texfiles, se existir. Se TEXFILES não estiver definido, usa todos que estão na pasta src
-include $(SRCDIR)/.env.texfiles
ifdef TEXFILES
	TEXFILES := $(subst ",,$(TEXFILES))
else
	TEXFILES := $(shell find $(SRCDIR) -type f -name '*.tex' -printf '%P ')
endif

#Arquivos pdf no diretório de saída a partir dos arquivos de entrada
PDFFILES	:= $(TEXFILES:%.tex=$(SRCDIR)/%.pdf)

# Flags para os comandos
LATEXFLAGS		= -pdf
LATEXFLAGS		+= -interaction=nonstopmode 
LATEXFLAGS		+= -cd
LATEXFLAGS		+= -file-line-error 
LATEXFLAGS		+= -emulate-aux-dir 

.PHONY: all
all: pdf-synctex

.PHONY: pdf
pdf: $(PDFFILES)

.PHONY: pdf-synctex
pdf-synctex: LATEXFLAGS	+= -synctex=1 
pdf-synctex: pdf

# Regra para gerar .pdf a partir de .tex.
.PHONY: FORCE_MAKE
$(SRCDIR)/%.pdf: $(SRCDIR)/%.tex FORCE_MAKE
	latexmk $(LATEXFLAGS) -aux-directory=$(CURDIR)/$(dir $(TMPDIR)/$*) -output-directory=$(CURDIR)/$(dir $@) $<

# Limpa os arquivos de saída e temporários
.PHONY: clean
clean: LATEXFLAGS	+= -C
clean: pdf
	rm -rf $(TMPDIR)
