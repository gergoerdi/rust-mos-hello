LLVM_MOS	= /home/cactus/prog/rust/mos/llvm-mos
LLVM_MOS_SDK	= /home/cactus/prog/rust/mos/llvm-mos-sdk/build

CLANG=$(LLVM_MOS)/bin/clang --config $(LLVM_MOS_SDK)/commodore/64.cfg -O2

.PHONY: all clean

all: factorial.prg factorial.s

clean:
	rm -f factorial.prg factorial.s factorial.ll

factorial.prg: factorial.ll main.c
	${CLANG} main.c factorial.ll -o factorial.prg

factorial.s: factorial.ll main.c
	${CLANG} main.c factorial.ll -o factorial.s -Wl,--lto-emit-asm

factorial.ll: factorial.rs
	rustc factorial.rs --emit=llvm-ir --crate-type=rlib -C debuginfo=0 -C opt-level=1
