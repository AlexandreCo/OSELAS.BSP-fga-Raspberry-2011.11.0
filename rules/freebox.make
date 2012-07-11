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
PACKAGES-$(PTXCONF_FREEBOX) += freebox

#
# Paths and names
#
FREEBOX_VERSION	:= 1.0
FREEBOX			:= freebox-$(FREEBOX_VERSION)
FREEBOX_SRCDIR	:= $(PTXDIST_WORKSPACE)/local_src/$(FREEBOX)
FREEBOX_DIR		:= $(BUILDDIR)/$(FREEBOX)
FREEBOX_LICENSE	:= GPL

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/freebox.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------
FREEBOX_PATH := PATH=$(CROSS_PATH)
FREEBOX_COMPILE_ENV := $(CROSS_ENV)

$(STATEDIR)/freebox.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/freebox.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/freebox.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/freebox.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  freebox)
	@$(call install_fixup, freebox,PACKAGE,freebox)
	@$(call install_fixup, freebox,PRIORITY,optional)
	@$(call install_fixup, freebox,VERSION,$(FREEBOX_VERSION))
	@$(call install_fixup, freebox,SECTION,base)
	@$(call install_fixup, freebox,AUTHOR,"Alexandre Coffignal <alexandre.github@gmail.com>")
	@$(call install_fixup, freebox,DEPENDS,)
	@$(call install_fixup, freebox,DESCRIPTION,missing)
	
	@$(call install_tree, freebox, 0, 0, $(PTXDIST_WORKSPACE)/local_src/freebox_gdc-1.0/,/)

	@$(call install_finish, freebox)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

#$(STATEDIR)/freebox.clean:
#	@$(call targetinfo)
#	@$(call clean_pkg, FREEBOX)

# vim: syntax=make
