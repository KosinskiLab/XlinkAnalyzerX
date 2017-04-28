# The "make" targets are:
# 	wheel: build a Python wheel in "dist" directory.
# 	app-install: build wheel (if needed) and install in ChimeraX.
# 	compile: compile all Python source code in "SOURCE" directory.
# 	clean: remove files used in building wheel

# These parameters may be changed as needed.

# ChimeraX bundle names must start with "ChimeraX_"
# to avoid clashes with package names in pypi.python.org.
# When uploaded to the ChimeraX toolshed, the bundle
# will be displayed without the ChimeraX_ prefix.
BUNDLE_NAME = ChimeraX_XlinkAnalyzerX
BUNDLE_VERSION = 0.1
# ChimeraX bundles should only include packages
# that install as chimerax.package_name.
# General Python packages should be uploaded to
# pypi.python.org rather than the ChimeraX toolshed.
PKG_NAME = chimerax.xlinkanalyzer

OS = $(patsubst CYGWIN_NT%,CYGWIN_NT,$(shell uname -s))
# CHIMERAX_APP is the ChimeraX install folder
ifeq ($(OS),CYGWIN_NT)
# Windows
CHIMERAX_APP = /e/chimerax/ChimeraX.app
endif
ifeq ($(OS),Darwin)
# Mac
CHIMERAX_APP = /Applications/ChimeraX.app
endif
ifeq ($(OS),Linux)
CHIMERAX_APP = /usr/local/src/chimerax/ChimeraX.app
endif

# ==================================================================
# Theoretically, no changes should be needed below here.

# Platform-dependent settings.  Should not need fixing.
# For Windows, we assume Cygwin is being used.
ifeq ($(OS),CYGWIN_NT)
PYTHON_EXE = $(CHIMERAX_APP)/bin/python.exe
CHIMERAX_EXE = $(CHIMERAX_APP)/bin/ChimeraX.exe
endif
ifeq ($(OS),Darwin)
# PYTHON_EXE = $(CHIMERAX_APP)/Contents/bin/python3.6
PYTHON_EXE = /Users/kosinski/anaconda/envs/imp2.7.0/bin/python
# CHIMERAX_EXE = $(CHIMERAX_APP)/Contents/bin/ChimeraX
CHIMERAX_EXE = /Users/kosinski/anaconda/envs/imp2.7.0/bin/python
endif
ifeq ($(OS),Linux)
PYTHON_EXE = $(CHIMERAX_APP)/bin/python3.6
CHIMERAX_EXE = $(CHIMERAX_APP)/bin/ChimeraX
endif

# Paths used for constructing the installation "wheel"
WHL_BNDL_NAME = $(subst -,_,$(BUNDLE_NAME))
# Use the "-p" version for pure Python packages
#TAG = $(shell $(PYTHON_EXE) wheel_tag.py -p)
TAG = $(shell $(PYTHON_EXE) wheel_tag.py)
WHEEL = dist/$(WHL_BNDL_NAME)-$(BUNDLE_VERSION)-$(TAG).whl
SOURCE = src
# SRCS = $(SOURCE)/*.py $(SOURCE)/*.cpp
SRCS = $(SOURCE)/*.py
#
# Actual make dependencies!
#

wheel $(WHEEL): license.txt setup.py $(SRCS)
	$(PYTHON_EXE) setup.py --no-user-cfg build
	$(PYTHON_EXE) setup.py --no-user-cfg bdist_wheel
	rm -rf $(WHL_BNDL_NAME).egg-info
	echo Distribution is in $(WHEEL)

license.txt:
	@echo Please specify your project licensing terms in file \"license.txt\"
	@echo The BSD license is included as file \"license.txt.bsd\"
	@echo The MIT license is included as file \"license.txt.mit\"
	@exit 1

app-install:	$(WHEEL)
	# For explanation of using two pip install commands, see
	# https://pip.pypa.io/en/stable/user_guide/#installing-from-local-packages
	$(CHIMERAX_EXE) -m pip install --upgrade --no-deps $(WHEEL)
	$(CHIMERAX_EXE) -m pip install $(WHEEL)

setup.py: setup.py.in Makefile
	sed -e 's,BUNDLE_NAME,$(BUNDLE_NAME),' \
		-e 's,BUNDLE_VERSION,$(BUNDLE_VERSION),' \
		-e 's,PKG_NAME,$(PKG_NAME),' \
		< setup.py.in > setup.py

compile:
	$(PYTHON_EXE) -B -m compileall $(SOURCE)

clean:
	rm -rf __pycache__ build dist $(WHL_BNDL_NAME).egg-info setup.py
	rm -rf $(SOURCE)/__pycache__

distclean:	clean
	rm -f license.txt
