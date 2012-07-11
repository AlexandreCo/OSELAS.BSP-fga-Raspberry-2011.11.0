# -*-makefile-*-
#
# Copyright (C) 2011 by alexandre coffignal <alexandre.github@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RF2TXT) += rf2txt

#
# Paths and names
#
RF2TXT_VERSION	:= 1.0
RF2TXT			:= rf2txt-$(RF2TXT_VERSION)
RF2TXT_SRCDIR	:= $(PTXDIST_WORKSPACE)/local_src/$(RF2TXT)
RF2TXT_DIR		:= $(BUILDDIR)/$(RF2TXT)
RF2TXT_LICENSE	:= GPL

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/rf2txt.extract:
	@$(call targetinfo)
	rm -fr $(RF2TXT_DIR)
	cp -a $(RF2TXT_SRCDIR) $(RF2TXT_DIR)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------
RF2TXT_PATH := PATH=$(CROSS_PATH)
RF2TXT_COMPILE_ENV := $(CROSS_ENV)

$(STATEDIR)/rf2txt.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/rf2txt.compile:
	@$(call targetinfo)
	@cd $(RF2TXT_DIR) && \
		$(RF2TXT_PATH) $(RF2TXT_COMPILE_ENV) \
		$(MAKE)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rf2txt.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rf2txt.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  rf2txt)
	@$(call install_fixup, rf2txt,PACKAGE,rf2txt)
	@$(call install_fixup, rf2txt,PRIORITY,optional)
	@$(call install_fixup, rf2txt,VERSION,$(RF2TXT_VERSION))
	@$(call install_fixup, rf2txt,SECTION,base)
	@$(call install_fixup, rf2txt,AUTHOR,"Alexandre Coffignal <alexandre.github@gmail.com>")
	@$(call install_fixup, rf2txt,DEPENDS,)
	@$(call install_fixup, rf2txt,DESCRIPTION,missing)

	@$(call install_copy, rf2txt, 0, 0, 0755, $(RF2TXT_DIR)/rf2txt, /bin/rf2txt,n)
	@$(call install_tree, rf2txt, 0, 0,    $(PTXDIST_WORKSPACE)/local_src/rf2txt_gdc-1.0/,/)
ifdef PTXCONF_RF2TXT_STARTUPSCRIPT
	@$(call install_alternative, rf2txt, 0, 0, 0755, /etc/init.d/rf2txt, n)
ifneq ($(call remove_quotes, $(PTXCONF_RF2TXT_STARTUPLINK)),)
		@$(call install_link, rf2txt, ../init.d/rf2txt, /etc/rc.d/$(PTXCONF_RF2TXT_STARTUPLINK))
endif
endif

	@$(call install_finish, rf2txt)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

#$(STATEDIR)/rf2txt.clean:
#	@$(call targetinfo)
#	@$(call clean_pkg, RF2TXT)

# vim: syntax=make
