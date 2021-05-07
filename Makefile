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
PKG_VERSION = 0.1.1
PGK_ROOT_DIR = $(PKG_NAME)-$(PKG_VERSION)
PGK_BASE_DIR = $(PGK_ROOT_DIR)/opt/qt_autoconnect

# targets
# set default target : https://stackoverflow.com/questions/2057689/how-does-make-app-know-default-target-to-build-if-no-target-is-specified
.DEFAULT_GOAL := build
.PHONY: build rebuild clean clean_all clean_last run dirs default compile

# build debian package
build:
	@$(ECHO) "$(LIGHT_BLUE_COLOR)*** Copying files for $(PGK_ROOT_DIR)  *** $(NO_COLOR)"
	mkdir -p build/$(PGK_BASE_DIR)

	@$(ECHO) "$(LIGHT_BLUE_COLOR)* Copying debian/ $(NO_COLOR)"
	cp -ru debian/ build/$(PGK_ROOT_DIR)

	@$(ECHO) "$(LIGHT_BLUE_COLOR)* Copying src/ $(NO_COLOR)"
	cp -ru src/ build/$(PGK_BASE_DIR)

	@$(ECHO) "$(LIGHT_BLUE_COLOR)* Copying logs/connection_logs.csv $(NO_COLOR)"
	mkdir -p build/$(PGK_BASE_DIR)/logs/
	cp logs/connection_logs.csv build/$(PGK_BASE_DIR)/logs/

	@$(ECHO) "$(LIGHT_BLUE_COLOR)* Copying data/ $(NO_COLOR)"
	cp -ru data/ build/$(PGK_ROOT_DIR)

	@$(ECHO) "$(LIGHT_BLUE_COLOR)* Creating res/connection_data.json $(NO_COLOR)"
	mkdir -p build/$(PGK_BASE_DIR)/res/
	touch build/$(PGK_BASE_DIR)/res/connection_data.json
	cat res/connection_data_example.json > build/$(PGK_BASE_DIR)/res/connection_data.json
	
	@$(ECHO) "$(LIGHT_BLUE_COLOR)* Copying scripts/*.sh $(NO_COLOR)"
	mkdir -p build/$(PGK_BASE_DIR)/scripts/
	cp scripts/*.sh build/$(PGK_BASE_DIR)/scripts/

	@$(ECHO) "$(LIGHT_BLUE_COLOR)*** Building $(PGK_ROOT_DIR)  *** $(NO_COLOR)"
	(cd build/$(PGK_ROOT_DIR) && debuild -uc -us)
	mv -f build/*.deb releases/
	find ./build -maxdepth 1 -type f -delete

clean_last:
	rm -rf build/$(PGK_ROOT_DIR)

clean_all:
	rm -rf build/*

# Determine this makefile's path.
# Be sure to place this BEFORE `include` directives, if any.
THIS_FILE := $(lastword $(MAKEFILE_LIST))

rebuild:
	@$(MAKE) -f $(THIS_FILE) clean_last
	@$(MAKE) -f $(THIS_FILE) build
