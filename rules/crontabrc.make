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
PACKAGES-$(PTXCONF_CRONTAB_RC) += crontabrc

#
# Paths and names
#
CRONTAB_RC_VERSION	:= 1.0
CRONTAB_RC			:= crontabrc-$(CRONTAB_RC_VERSION)
CRONTAB_RC_SRCDIR	:= $(PTXDIST_WORKSPACE)/local_src/$(CRONTAB_RC)
CRONTAB_RC_DIR		:= $(BUILDDIR)/$(CRONTAB_RC)
CRONTAB_RC_LICENSE	:= GPL

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/crontabrc.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------
CRONTAB_RC_PATH := PATH=$(CROSS_PATH)
CRONTAB_RC_COMPILE_ENV := $(CROSS_ENV)

$(STATEDIR)/crontabrc.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/crontabrc.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/crontabrc.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/crontabrc.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  crontabrc)
	@$(call install_fixup, crontabrc,PACKAGE,crontabrc)
	@$(call install_fixup, crontabrc,PRIORITY,optional)
	@$(call install_fixup, crontabrc,VERSION,$(CRONTAB_RC_VERSION))
	@$(call install_fixup, crontabrc,SECTION,base)
	@$(call install_fixup, crontabrc,AUTHOR,"Alexandre Coffignal <alexandre.github@gmail.com>")
	@$(call install_fixup, crontabrc,DEPENDS,)
	@$(call install_fixup, crontabrc,DESCRIPTION,missing)
	
	@$(call install_tree, crontabrc, 0, 0, $(PTXDIST_WORKSPACE)/local_src/crontabrc-1.0/,/)
	
	@$(call install_finish, crontabrc)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

#$(STATEDIR)/crontabrc.clean:
#	@$(call targetinfo)
#	@$(call clean_pkg, CRONTAB_RC)

# vim: syntax=make
