CC             ?= clang
CFLAGS         += -Wno-visibility -Wno-incompatible-pointer-types -Wall -Wextra
CFLAGS         += -DINVERT_COLORS -DVT100 -O2
LFLAGS         +=

# Detect if libintl.h is available
HAVE_LIBINTL := $(shell echo '\#include <libintl.h>' | $(CC) -E - >/dev/null 2>&1 && echo yes || echo no)
ifeq ($(HAVE_LIBINTL),yes)
    CFLAGS += -DHAVE_LIBINTL
endif

# Detect if locale.h is available
HAVE_LOCALE := $(shell echo '\#include <locale.h>' | $(CC) -E - >/dev/null 2>&1 && echo yes || echo no)
ifeq ($(HAVE_LOCALE),yes)
    CFLAGS += -DHAVE_LOCALE_H
endif

PROGRAM := 2048
C_FILES := $(wildcard src/*.c)
MERGE_FILE := src/merge_std.c
FILTERED_C_FILES := $(filter-out src/gfx%.c src/merge%.c, $(C_FILES))

all: terminal

curses: $(FILTERED_C_FILES) src/gfx_curses.c
	$(CC) $(CFLAGS) $(FILTERED_C_FILES) $(MERGE_FILE) src/gfx_curses.c -o $(PROGRAM) $(LDFLAGS) -lcurses

terminal: $(FILTERED_C_FILES) src/gfx_terminal.c
	$(CC) $(CFLAGS) $(FILTERED_C_FILES) $(MERGE_FILE) src/gfx_terminal.c -o $(PROGRAM) $(LDFLAGS)

remake: clean all

clean:
	rm -f $(PROGRAM)

.PHONY: clean remake
