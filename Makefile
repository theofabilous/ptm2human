# vim:noexpandtab:ft=make

BUILD_DIR ?= .build
CC ?= gcc
CFLAGS ?= -g -O2 -Wall

SOURCES = etmv4.c ptm.c ptm2human.c stream.c etb_format.c tracer-ptm.c tracer-etmv4.c
HEADERS = stream.h tracer-ptm.h tracer-etmv4.h log.h output.h pktproto.h tracer.h
OBJECTS = $(patsubst %.c,$(BUILD_DIR)/%.o,$(SOURCES))

.PHONY: exe clean

all: $(BUILD_DIR)/ptm2human

$(BUILD_DIR):
	mkdir -p $@

# Putting $(HEADERS) as a pre-req here is suboptimal. This if fine for now
# but eventually we could add separate preprocessing steps to mitigate this
$(OBJECTS): $(BUILD_DIR)/%.o: %.c $(HEADERS) | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

exe: $(BUILD_DIR)/ptm2human

$(BUILD_DIR)/ptm2human: $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $@

clean:
	rm -rf $(BUILD_DIR)
