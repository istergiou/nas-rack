# Overview: 
# 	The Makefile will build the requested files and all prerequisites.
# (1) *.scad files to create stl_output/*.stl and then slic3r_output/*.gcode 
# (2) *.stl files to create slic3r_output/*.gcode or cura_output/*.gcode
#
# Target summary:
#	make stl # makes stl_output/*.stl using OpenScad
#	make gcode  # makes slic3r_output/*.gcode (uses slic3r)
#	make slic3r # makes slic3r_output/*.gcode using slic3r (files: slic3r_output/basefilename.gcode)
#   make all # makes stl_output/*.stl, slic3r_output/*.gcode and cura_output/*.gcode using slic3r and CuraEngine
#	make clean # removes all ouput files (*_output/*.stl and *.gcode)
#	make clean.g # removes slic3r_output/*.gcode and cura_output/*.gcode files
#	make clean.stl # removes stl_output/*.stl files
#   make info # will present info for each *.stl and stl_output/*.stl file
#
# OpenScad 
#  src/scad/*configuration.scad files are optional dependencies and will not produce *configuration.stl
#  Included directories are ./inc and ./src/inc all files therein are prerequisites
#  Updating configuration.scad or files in include directories will rebuild all *.scad files.
#
# slic3r 
#   Uses for configuration file slic3r.ini and basefilename-slic3r.conf (overwrites 
# 	slic3r.conf values for basefilename.stl only). See slic3r.conf.distr for more information.
#
# Merge STL (mstl) files
#   *.mstl files include a list of stl files that must be merged to create a single gcode file.
#   mstl files can be created using:
#     ls -1 output/ultimate_calibration_test_mod.stl TestCube.stl >multi-somefile.mstl
#   To make an mstl file (also makes all dependencies!!!):
#     make multi

ifndef SLIC3R_CONF
SLIC3R_CONF = ./slic3r.ini
endif

OPENSCAD_BIN=openscad
SLIC3R_BIN=slic3r

SLIC3R_OPTS=--print-center=100,150 

INCLUDES = $(wildcard src/scad/inc/*.scad)

SCAD_FILES = $(wildcard src/scad/*.scad)
SCAD_FILE_NAMES = $(SCAD_FILES:src/scad/%.scad=%.scad)
SCAD_MODEL_FILES = $(filter-out configuration.scad, $(SCAD_FILE_NAMES))
STL_FILES = $(wildcard src/stl/*.stl)
STL_MODEL_FILES = $(STL_FILES:src/stl/%.stl=%.stl)
OPENSCAD_STL_FROM_SCAD_FILES = $(SCAD_MODEL_FILES:%.scad=stl_output/%.stl) 
SLIC3R_GCODE_FROM_STL_FILES = $(OPENSCAD_STL_FROM_SCAD_FILES:stl_output/%.stl=slic3r_output/%.gcode) $(STL_MODEL_FILES:%.stl=slic3r_output/%.gcode) 

# make print-SCAD_MODEL_FILES
# make print-OPENSCAD_STL_FROM_SCAD_FILES
# make print-SLIC3R_GCODE_FROM_STL_FILES

# make print-STL_FILES

.PHONY: all multi stl gcode slic3r cura gcode clean clean.stl clean.g clean.depends

.PRECIOUS: $(OPENSCAD_STL_FROM_SCAD_FILES)

.DEFAULT_GOAL := gcode

all: gcode
	
stl: $(OSCAD_STL_FROM_SCAD_FILES)

gcode: slic3r

slic3r: $(SLIC3R_GCODE_FROM_STL_FILES)

stl_output:
	-mkdir stl_output 

slic3r_output:
	-mkdir slic3r_output

# http://blog.jgc.org/2015/04/the-one-line-you-should-add-to-every.html
print-%: ; @echo $*=$($*)

info:
	for file in `ls -1 *.stl stl_output/*.stl`; do $(SLIC3R_BIN) --info $$file; done 

#
# from src/scad/%.scad to stl_output/%.stl and gcode_output/%.gcode
#
# from %.scad to stl_output/%.stl
stl_output/%.stl: src/scad/%.scad $(INCLUDES) $(wildcard src/scad/*configuration.scad) | stl_output
	$(OPENSCAD_BIN) $(OPENSCAD_OPTS) -o $@ $<

# from stl_output/%.stl with 2 slic3r configurations to slic3r_output/%.gcode 
slic3r_output/%.gcode: stl_output/%.stl $(SLIC3R_CONF) src/slic3r/%.conf | slic3r_output
	$(SLIC3R_BIN) $(SLIC3R_OPTS) --load $(SLIC3R_CONF) --load src/slic3r/$*.conf -o $@ $<

# from stl_output/%.stl with 1 slic3r configuration to output/%.gcode 
slic3r_output/%.gcode: stl_output/%.stl $(SLIC3R_CONF) | slic3r_output
	$(SLIC3R_BIN) $(SLIC3R_OPTS) --load $(SLIC3R_CONF) -o $@ $<

# from src/stl/%.stl with 2 slic3r configurations to slic3r_output/%.gcode 
slic3r_output/%.gcode: src/stl/%.stl $(SLIC3R_CONF) src/slic3r/%.conf | slic3r_output
	$(SLIC3R_BIN) $(SLIC3R_OPTS) --load $(SLIC3R_CONF) --load src/slic3r/$*.conf -o $@ $<

# from stl_output/%.stl with 1 slic3r configuration to output/%.gcode 
slic3r_output/%.gcode: src/stl/%.stl $(SLIC3R_CONF) | slic3r_output
	$(SLIC3R_BIN) $(SLIC3R_OPTS) --load $(SLIC3R_CONF) -o $@ $<

# 
# clean
#
clean.slic3r:
	-rm slic3r_output/*.gcode

clean.g: clean.slic3r

clean.stl: 
	-rm stl_output/*.stl

clean: clean.stl clean.g

