#!/usr/bin/make
KIBOT?=kibot
DEBUG?=
# Empty is all
TARGET?=
OUT_DIR=Generated
EXTRA_OPS?=--banner -1 --log $(OUT_DIR)/kibot.log $(DEBUG)

all: erc drc ardu_prog

# For ERC we skip the DRC, the -i is "invert all", so no outputs are generated, just pre-flights
erc:
	$(KIBOT) $(EXTRA_OPS) -d $(OUT_DIR) -s drc -i

# For DRC we skip the ERC, the -i is "invert all", so no outputs are generated, just pre-flights
drc:
	$(KIBOT) $(EXTRA_OPS) -d $(OUT_DIR) -s erc -i

# One target for each variant, note that we could use --variant 3 times to get all of them in one run
# but in then will get all outputs in the same directory
# As we have separated targets for D/ERC we skip both
# You can specify a particular KiBot output using:
# TARGET=bom_html make var_default
var_default:
	$(KIBOT) $(EXTRA_OPS) -d $(OUT_DIR)/default --variant default -s erc,drc $(TARGET)

var_usb:
	$(KIBOT) $(EXTRA_OPS) -d $(OUT_DIR)/USB --variant USB -s erc,drc $(TARGET)

var_xtal:
	$(KIBOT) $(EXTRA_OPS) -d $(OUT_DIR)/XTAL --variant XTAL -s erc,drc $(TARGET)

ardu_prog: var_default var_usb var_xtal

.PHONY: ardu_prog erc drc var_default var_usb var_xtal
