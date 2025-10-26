# Rodar tarefas em paralelo
MAKEFLAGS += -j
# MAKEFLAGS += --output-sync

# Diretórios
SRCDIR	:= src
TMPDIR	:= tmp
OUTDIR	:= out
CURDIR	:= $(shell pwd)

# Inclui arquivos .mk adicionais, se existirem
-include $(wildcard $(SRCDIR)/.*.mk $(SRCDIR)/*.mk)

# Define TEXFILES se não estiver definido
ifndef TEXFILES
	TEXFILES := $(shell find $(SRCDIR) -type f -name '*.tex' -printf '%P ')
endif

#Arquivos pdf no diretório de saída a partir dos arquivos de entrada
PDFFILES	:= $(TEXFILES:%.tex=$(OUTDIR)/%.pdf)

# Flags para os comandos
LATEXFLAGS		= -pdf
LATEXFLAGS		+= -synctex=1 
LATEXFLAGS		+= -interaction=nonstopmode 
LATEXFLAGS		+= -cd
LATEXFLAGS		+= -file-line-error 
LATEXFLAGS		+= -emulate-aux-dir 

.PHONY: all
all: pdf

.PHONY: pdf
pdf: $(PDFFILES)

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
