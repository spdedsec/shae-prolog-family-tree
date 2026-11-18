# shae-prolog-family-tree

A family-tree reasoning system in Prolog. Provides facts (`parent/2`,
`male/1`, `female/1`) and rules (`mother/2`, `father/2`, `sister/2`,
`brother/2`, `aunt/2`, `uncle/2`, `grandparent/2`, `ancestor/2`, `cousin/2`,
`siblings/2`) over a sample family of 12 people across 3 generations.

Part of the SHAE Tier 2 series. Built per the SHAE field manual design system:
precise over decorative, flat and physical, type does the work.

## Requirements

- SWI-Prolog (`swipl`) or GNU Prolog (`gprolog`)
  - Not installed in this environment; the source is written in authentic
    Prolog syntax and is intended to run on a Prolog implementation or in
    GitHub Actions.

## Install

```bash
git clone https://github.com/spdedsec/shae-prolog-family-tree.git
cd shae-prolog-family-tree
bash scripts/install.sh
```

`scripts/install.sh` detects `swipl` or `gprolog` and creates
`~/.local/bin/shae-family-tree`, a wrapper that consults `src/family.pl`.
If no Prolog implementation is found, it prints instructions instead.

## Usage

```bash
# Load the family tree and enter the Prolog toplevel
swipl -f src/family.pl

# Or run a single query and exit
swipl -f src/family.pl -g 'grandparent(john, alice), halt.'

# Via the installed wrapper
shae-family-tree -g 'cousin(alice, carol), halt.'
```

## Example queries

| Query | Meaning |
|-------|---------|
| `?- mother(mary, michael).` | Is Mary the mother of Michael? |
| `?- father(john, susan).` | Is John the father of Susan? |
| `?- sister(susan, michael).` | Is Susan Michael's sister? |
| `?- brother(michael, susan).` | Is Michael Susan's brother? |
| `?- aunt(susan, alice).` | Is Susan Alice's aunt? |
| `?- uncle(david, bob).` | Is David Bob's uncle? |
| `?- grandparent(john, alice).` | Is John Alice's grandparent? |
| `?- ancestor(mary, dan).` | Is Mary an ancestor of Dan? |
| `?- cousin(alice, carol).` | Are Alice and Carol cousins? |
| `?- siblings(alice, bob).` | Are Alice and Bob siblings? |
| `?- ancestor(john, Who).` | Who are John's descendants? |

## Test

```bash
make test
```

Consults `src/family.pl` and runs demonstration queries. On this machine no
Prolog toolchain is available, so `make test` reports that it is skipped; it
runs on GitHub Actions where a Prolog implementation may be present.

## License

MIT
