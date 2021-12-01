ZIG_FILES=$(wildcard *.zig)
TARGETS=$(patsubst %.zig, %, $(ZIG_FILES))

% : %.zig
	mkdir -p build
	zig build-exe $< && mv $@ build/$@

.PHONY: all
all: $(TARGETS)

.PHONY: clean
clean: $(TARGETS)
	rm $(TARGETS)