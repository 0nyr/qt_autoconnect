# A makefile to automate the creation process of the .deb package

# WARN : don't put " and use the echo command, not echo -e
LIGHT_ORANGE_COLOR=\e[38;5;216m
TURQUOISE_COLOR=\e[38;5;43m
LIGHT_BLUE_COLOR=\e[38;5;153m
RED_COLOR=\e[38;5;196m
NO_COLOR=\e[0m

# variables
ECHO = @echo # @echo hides this command in terminal, not its output

# package variables
PKG_NAME = qt-autoconnect
PKG_VERSION = 0.1.0
PGK_ROOT_DIR = $(PKG_NAME)-$(PKG_VERSION)
PGK_BASE_DIR = $(PGK_ROOT_DIR)/opt/qt_autoconnect

# targets
# set default target : https://stackoverflow.com/questions/2057689/how-does-make-app-know-default-target-to-build-if-no-target-is-specified
.DEFAULT_GOAL := build
.PHONY: build clean clean_all clean_last run dirs default compile

# build debian package
build:
	@$(ECHO) "$(LIGHT_BLUE_COLOR)*** Copying files for $(PGK_ROOT_DIR)  *** $(NO_COLOR)"
	mkdir -p build/$(PGK_BASE_DIR)
	@$(ECHO) "$(LIGHT_BLUE_COLOR)* Copying DEBIAN/ $(NO_COLOR)"
	cp -ru DEBIAN/ build/$(PGK_ROOT_DIR)
	@$(ECHO) "$(LIGHT_BLUE_COLOR)* Copying src/ $(NO_COLOR)"
	cp -ru src/ build/$(PGK_BASE_DIR)
	@$(ECHO) "$(LIGHT_BLUE_COLOR)* Copying logs/ $(NO_COLOR)"
	cp -ru logs/ build/$(PGK_BASE_DIR)
	@$(ECHO) "$(LIGHT_BLUE_COLOR)* Creating res/connection_data.json $(NO_COLOR)"
	mkdir -p build/$(PGK_BASE_DIR)/res/
	touch build/$(PGK_BASE_DIR)/res/connection_data.json
	cat res/connection_data_example.json > build/$(PGK_BASE_DIR)/res/connection_data.json
	@$(ECHO) "$(LIGHT_BLUE_COLOR)* Copying scripts/ $(NO_COLOR)"
	cp -ru scripts/ build/$(PGK_BASE_DIR)
	@$(ECHO) "$(LIGHT_BLUE_COLOR)*** Building $(PGK_ROOT_DIR)  *** $(NO_COLOR)"
	dpkg-deb --build build/$(PGK_ROOT_DIR)
	mv -f build/*.deb releases/

clean_last:
	rm -rf build/$(PGK_ROOT_DIR)

clean_all:
	rm -rf build/*
