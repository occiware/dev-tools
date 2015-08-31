#
# Author: Jean Parpaillon <jean.parpaillon@inria.fr>
#
# Install Eclipse for use with OCCIware tools
#
# Supported disitributions: Debian
#
archive_linux64=eclipse-java-mars-R-linux-gtk-x86_64.tar.gz
link_linux64='http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/mars/R/eclipse-java-mars-R-linux-gtk-x86_64.tar.gz&r=1'

distribution=$(shell lsb_release -s -i)
arch=$(shell uname -m)

destdir=/opt/eclipse-occiware

all:
	$(MAKE) archive
	sudo $(MAKE) install

ifeq ($(distribution),Debian)
install: install-debian
else
install:
	@echo "E: Unsupported distribution: "$(distribution)
	@false
endif

install-debian: install-linux
	update-desktop-database

install-linux: destdir
	install -o root -g root icon.png $(destdir)/icon.png
	install -o root -g root eclipse-occiware.desktop /usr/share/applications/eclipse-occiware.desktop
	ln -fs $(destdir)/eclipse /usr/local/bin/occiware-studio

ifeq ($(arch),x86_64)
archive: $(archive_linux64)

destdir: $(archive_linux64)
	@if test -d $(destdir); then \
	  echo "E: Existing OCCIware Studio installation in $(destdir), please remove it."; \
	  false; \
	else \
	  tmpdir=`mktemp -d`; \
	  tar xfC $< $$tmpdir; \
	  mv $$tmpdir/* $(destdir); \
	fi
else
archive:
	@echo "E: Unsupported architecture: "$(arch)
	@false

destdir:
endif

eclipse-java-mars-R-linux-gtk-x86_64.tar.gz:
	curl -L $(link_linux64) > $@

.PHONY: all archive destdir install install-debian archive_linux64
