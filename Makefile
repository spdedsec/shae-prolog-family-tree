# SHAE Prolog Family Tree — Makefile
#
# No compile step (Prolog is consulted/interpreted). Targets: syntax-check,
# test (consult + run demonstration queries), install, clean.
#
# Requires SWI-Prolog (swipl) or GNU Prolog (gprolog). Not available on this
# machine, so test is a no-op here but will run on GitHub Actions.

PROLOG ?= $(shell command -v swipl 2>/dev/null || command -v gprolog 2>/dev/null || echo)
SRC := src/family.pl

.PHONY: all test syntax-check install clean

all:
	@echo "shae-family-tree: Prolog source, no build step required."

syntax-check:
	@if [ -z "$(PROLOG)" ]; then \
		echo "No Prolog implementation found; skipping syntax check."; \
		exit 0; \
	fi
	@echo "Consulting $(SRC) with $(PROLOG)..."
	@if [ "$(PROLOG)" = "swipl" ]; then \
		swipl -q -f $(SRC) -g 'halt.' ; \
	else \
		gprolog --consult-file $(SRC) --entry-goal halt ; \
	fi

test: syntax-check
	@if [ -z "$(PROLOG)" ]; then \
		echo "No Prolog implementation found; skipping queries."; \
		exit 0; \
	fi
	@echo "Running demonstration queries..."
	@if [ "$(PROLOG)" = "swipl" ]; then \
		swipl -q -f $(SRC) \
			-g 'mother(mary, michael), write(mary-michael), nl, halt.' \
			-g 'father(john, susan), write(john-susan), nl, halt.' \
			-g 'grandparent(john, alice), write(john-alice), nl, halt.' \
			-g 'ancestor(mary, dan), write(mary-dan), nl, halt.' \
			-g 'cousin(alice, carol), write(alice-carol), nl, halt.' ; \
	else \
		gprolog --consult-file $(SRC) --entry-goal halt ; \
	fi

install:
	bash scripts/install.sh

clean:
	@echo "Nothing to clean (no build artifacts)."
