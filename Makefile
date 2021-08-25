LLVM_MOS	= /home/cactus/prog/rust/mos/llvm-mos
LLVM_MOS_SDK	= /home/cactus/prog/rust/mos/llvm-mos-sdk/build

CLANG=$(LLVM_MOS)/bin/clang --config $(LLVM_MOS_SDK)/commodore/64.cfg -O2

.PHONY: all clean

all: _build/factorial.prg _build/factorial.s

clean:
	rm -rf _build/

_build/factorial.prg: _build/factorial.ll main.c
	mkdir -p _build
	${CLANG} $^ -o $@

_build/factorial.s: _build/factorial.ll main.c
	mkdir -p _build
	${CLANG} $^ -o $@ -Wl,--lto-emit-asm

_build/factorial.ll: factorial.rs
	mkdir -p _build
	rustc $^ --emit=llvm-ir --crate-type=rlib -C debuginfo=0 -C opt-level=1 -o $@
