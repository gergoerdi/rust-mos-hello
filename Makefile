LLVM_MOS	= /home/cactus/sdk/rust/llvm-mos

CC=$(LLVM_MOS)/bin/mos-c64-clang
CFLAGS=-O2

.PHONY: all clean

all: _build/factorial.prg _build/factorial.s

clean:
	rm -rf _build/

_build/factorial.prg: _build/factorial.ll main.c
	mkdir -p _build
	${CC} ${CFLAGS} $^ -o $@

_build/factorial.s: _build/factorial.ll main.c
	mkdir -p _build
	${CC} ${CFLAGS} $^ -o $@ -Wl,--lto-emit-asm

_build/factorial.ll: factorial.rs
	mkdir -p _build
	rustc $^ --emit=llvm-ir --crate-type=rlib -C debuginfo=0 -C opt-level=1 -o $@
