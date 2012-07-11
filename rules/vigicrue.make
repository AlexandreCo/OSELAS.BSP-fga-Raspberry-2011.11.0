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
PACKAGES-$(PTXCONF_VIGICRUE) += vigicrue

#
# Paths and names
#
VIGICRUE_VERSION	:= 1.0
VIGICRUE			:= vigicrue-$(VIGICRUE_VERSION)
VIGICRUE_SRCDIR	:= $(PTXDIST_WORKSPACE)/local_src/$(VIGICRUE)
VIGICRUE_DIR		:= $(BUILDDIR)/$(VIGICRUE)
VIGICRUE_LICENSE	:= GPL

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/vigicrue.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------
VIGICRUE_PATH := PATH=$(CROSS_PATH)
VIGICRUE_COMPILE_ENV := $(CROSS_ENV)

$(STATEDIR)/vigicrue.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/vigicrue.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/vigicrue.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/vigicrue.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  vigicrue)
	@$(call install_fixup, vigicrue,PACKAGE,vigicrue)
	@$(call install_fixup, vigicrue,PRIORITY,optional)
	@$(call install_fixup, vigicrue,VERSION,$(VIGICRUE_VERSION))
	@$(call install_fixup, vigicrue,SECTION,base)
	@$(call install_fixup, vigicrue,AUTHOR,"Alexandre Coffignal <alexandre.github@gmail.com>")
	@$(call install_fixup, vigicrue,DEPENDS,)
	@$(call install_fixup, vigicrue,DESCRIPTION,missing)

	@$(call install_tree, vigicrue, 0, 0,    $(PTXDIST_WORKSPACE)/local_src/vigicrue_gdc-1.0/,/)

	@$(call install_finish, vigicrue)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

#$(STATEDIR)/vigicrue.clean:
#	@$(call targetinfo)
#	@$(call clean_pkg, VIGICRUE)

# vim: syntax=make
