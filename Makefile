VERSIONS = 5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8 5.9 5.10 5.11 5.12
GENERATE_STANDALONE = $(patsubst %,generated/%/standalone, ${VERSIONS}) 
GENERATE_UNIT = $(patsubst %,generated/%/unit, ${VERSIONS}) 

.PHONY: all
.PHONY: ${GENERATE_STANDALONE} ${GENERATE_UNIT}
.PHONY: clean

all: ${GENERATE_STANDALONE} ${GENERATE_UNIT}

${GENERATE_STANDALONE}: 
	echo $@
	mkdir -p $@
	printf ${patsubst generated/%/standalone,%,$@} > $@/version
	cp standalone/* $@/

${GENERATE_UNIT}:
	mkdir -p $@
	printf ${patsubst generated/%/unit,%,$@} > $@/version
	cp unit/* $@

clean: 
	rm -rf generated
