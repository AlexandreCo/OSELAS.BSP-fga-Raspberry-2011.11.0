# -*-makefile-*-
#
# Copyright (C) 2012 by alexandre coffignal <alexandre.github@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MSTTCOREFONTS) += msttcorefonts

#
# Paths and names
#
MSTTCOREFONTS_VERSION	:= 1.0
MSTTCOREFONTS_LICENSE	:= GPL
MSTTCOREFONTS		:= msttcorefonts
MSTTCOREFONTS_SUFFIX	:= tar.gz
MSTTCOREFONTS_SOURCE	:= $(SRCDIR)/$(MSTTCOREFONTS).$(MSTTCOREFONTS_SUFFIX)
MSTTCOREFONTS_URL	:= http://thelinuxbox.org/downloads/fonts/$(MSTTCOREFONTS).$(MSTTCOREFONTS_SUFFIX)
MSTTCOREFONTS_DIR	:= $(BUILDDIR)/$(MSTTCOREFONTS)
MSTTCOREFONTS_MD5	:= 79fbc1a2ac2f3415a884c4d4736a4cd3
# ----------------------------------------------------------------------------
# omit the 'get' stage (due to the fact, the files are already present)
# ----------------------------------------------------------------------------
#$(STATEDIR)/msttcorefonts.get:
#		@$(call targetinfo)
#		@$(call get, MSTTCOREFONTS)

# ----------------------------------------------------------------------------
# omit the 'extract' stage (due to the fact, all files are already present)
# ----------------------------------------------------------------------------
#$(STATEDIR)/msttcorefonts.extract:
#		@$(call targetinfo)
#		@$(call touch)

# ----------------------------------------------------------------------------
# omit the 'prepare' stage (due to the fact, nothing is to be built)
# ----------------------------------------------------------------------------
$(STATEDIR)/msttcorefonts.prepare:
		@$(call targetinfo)
		@$(call touch)

# ----------------------------------------------------------------------------
# omit the 'compile' stage (due to the fact, nothing is to be built)
# ----------------------------------------------------------------------------
$(STATEDIR)/msttcorefonts.compile:
		@$(call targetinfo)
		@$(call touch)

# ----------------------------------------------------------------------------
# omit the 'install' stage (due to the fact, nothing is to be installed into the sysroot)
# ----------------------------------------------------------------------------
$(STATEDIR)/msttcorefonts.install:
		@$(call targetinfo)
		@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/msttcorefonts.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  msttcorefonts)
	@$(call install_fixup, msttcorefonts,PACKAGE,msttcorefonts)
	@$(call install_fixup, msttcorefonts,PRIORITY,optional)
	@$(call install_fixup, msttcorefonts,VERSION,$(FONT_VERSION))
	@$(call install_fixup, msttcorefonts,SECTION,base)
	@$(call install_fixup, msttcorefonts,AUTHOR,"Alexandre Coffignal <alexandre.github@gmail.com>")
	@$(call install_fixup, msttcorefonts,DEPENDS,)
	@$(call install_fixup, msttcorefonts,DESCRIPTION,missing)

#	@$(call install_archive, msttcorefonts, 0, 0, $(PTXDIST_WORKSPACE)/local_src/www-1.0/www-1.0.tgz,)
	@$(call install_tree, msttcorefonts, 0, 0, $(MSTTCOREFONTS_DIR), /usr/share/font)
#	@$(call install_copy, msttcorefonts, 0, 0, 644, <source> [, <destination>])
	@$(call install_finish, msttcorefonts)

	@$(call touch)

# vim: syntax=make
