# DESIGN.md — shae-prolog-family-tree

Design system applied per the SHAE field manual (`shared/design-system.md`).
This Prolog source has no UI layer, so the design system is expressed in its
predicate contract, clause layout, and documentation rather than pixels.

## Core principles

### Precise over decorative
The code is lean and declarative: each rule states one relationship with no
redundant or ornamental clauses. Predicate names are short, unambiguous, and
documented. Cuts and extraneous control constructs are avoided; the program
is pure relational logic.

### Flat and physical
No dynamic asserts/retracts, no asserted facts, no hidden mutable state. The
family tree is a flat, static set of `parent/2`, `male/1`, `female/1` facts
plus derived rules — a physical, inspectable model on disk.

### Type does the work
Predicates do the semantic work: `mother/2`, `father/2`, `grandparent/2`,
`ancestor/2`, `cousin/2`, `siblings/2`. Argument order is consistent
(parent/child, ancestor/descendant). Mode comments make each predicate's
input/output roles clear.

### Confident restraint
One conceptual signal: query failures return `false` (Prolog's native
negative), no decorative warning output. The documentation uses the paper /
ink / oxide scheme.

## Accessibility

- Complete keyboard path: all interaction is via the Prolog toplevel.
- No colour-only information; results are terms printed in text.

## Motion

Not applicable (no UI). If a future front end is added, state changes will use
140–240ms and reduced-motion fallbacks.

## Files

- `src/family.pl` — facts and rules; documented example queries at the bottom.
- `scripts/install.sh` — detects `swipl`/`gprolog`, installs `~/.local/bin/shae-family-tree`.
- `Makefile` — `make test` consults and runs demonstration queries.
- `docs/DE.md`, `docs/ES.md` — localized install guides.
