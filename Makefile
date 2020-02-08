PREFIX := /usr/local
SRC_PREFIX := ./src
SRC := $(patsubst $(SRC_PREFIX)/%, %, $(wildcard ./src/*.sh))
INSTALL_PATH := $(patsubst %.sh, $(PREFIX)/bin/%, $(SRC))

.PHONY: all
all:
	@echo "Run 'make install' to install all scripts."
	@echo
	@echo "Run 'make install_SCRIPT' to install individual scripts."
	@echo "For example: 'make install_$(word 1, $(SRC))' to install the $(word 1, $(SRC)) script."

## install : Install all scripts.
.PHONY: install
install: $(patsubst %, install_%, $(SRC))
	@echo
	@echo "Finished installing dmenu-bin!"

## uninstall : Uninstall all scripts.
.PHONY: uninstall
uninstall: $(patsubst $(PREFIX)/bin/%, uninstall_%, $(INSTALL_PATH))
	@echo
	@echo "Finished uninstalling dmenu-bin!"

## install_SCRIPT : Install individual script.
.PHONY: install_%
install_%: $(SRC_PREFIX)/%
	@echo "Installing $@..."
	@cp -vp $< $(PREFIX)/bin/$(notdir $(basename $<))
	@chmod 755 $(PREFIX)/bin/$(notdir $(basename $<))

## uninstall_SCRIPT : Uninstall individual script.
.PHONY: uninstall_%
uninstall_%: $(PREFIX)/bin/%
	@echo "Uninstalling $<..."
	@rm -vf $<

## variables : Print variables.
.PHONY: variables
variables:
	@echo SRC_PREFIX: $(SRC_PREFIX)
	@echo PREFIX: $(PREFIX)
	@echo SRC: $(SRC)
	@echo INSTALL_PATH: $(INSTALL_PATH)

## help : Print help message.
.PHONY: help
help: Makefile
	@sed -n 's/^## //p' $< | awk -F':' '{printf "%-30s: %s\n", $$1, $$2'}
