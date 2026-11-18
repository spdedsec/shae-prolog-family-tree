# shae-prolog-family-tree (de)

Ein Familienstammbaum-Reasoningsystem in Prolog. Stellt Fakten (`parent/2`,
`male/1`, `female/1`) und Regeln (`mother/2`, `father/2`, `sister/2`,
`brother/2`, `aunt/2`, `uncle/2`, `grandparent/2`, `ancestor/2`, `cousin/2`,
`siblings/2`) über eine Beispiel-Familie mit 12 Personen in 3 Generationen
zur Verfügung.

## Anforderungen

- SWI-Prolog (`swipl`) oder GNU Prolog (`gprolog`)
  - Nicht in dieser Umgebung installiert; der Quellcode ist in authentischer
    Prolog-Syntax geschrieben und soll auf einer Prolog-Implementierung oder
    in GitHub Actions laufen.

## Installation

```bash
git clone https://github.com/spdedsec/shae-prolog-family-tree.git
cd shae-prolog-family-tree
bash scripts/install.sh
```

`scripts/install.sh` erkennt `swipl` oder `gprolog` und erstellt
`~/.local/bin/shae-family-tree`, einen Wrapper, der `src/family.pl`
konsultiert. Falls keine Prolog-Implementierung gefunden wird, werden
Hinweise ausgegeben.

## Verwendung

```bash
# Stammbaum laden und Prolog-Toplevel betreten
swipl -f src/family.pl

# Einzelne Abfrage ausführen und beenden
swipl -f src/family.pl -g 'grandparent(john, alice), halt.'

# Über den installierten Wrapper
shae-family-tree -g 'cousin(alice, carol), halt.'
```

## Beispielabfragen

| Abfrage | Bedeutung |
|---------|-----------|
| `?- mother(mary, michael).` | Ist Mary die Mutter von Michael? |
| `?- father(john, susan).` | Ist John der Vater von Susan? |
| `?- sister(susan, michael).` | Ist Susan Michaels Schwester? |
| `?- brother(michael, susan).` | Ist Michael Susans Bruder? |
| `?- aunt(susan, alice).` | Ist Susan Alices Tante? |
| `?- uncle(david, bob).` | Ist David Bobs Onkel? |
| `?- grandparent(john, alice).` | Ist John Alices Großelternteil? |
| `?- ancestor(mary, dan).` | Ist Mary eine Vorfahrin von Dan? |
| `?- cousin(alice, carol).` | Sind Alice und Carol Cousins? |
| `?- siblings(alice, bob).` | Sind Alice und Bob Geschwister? |
| `?- ancestor(john, Who).` | Wer sind Johns Nachkommen? |

## Test

```bash
make test
```

Konsultiert `src/family.pl` und führt Abfragetests durch. Auf diesem Rechner
ist keine Prolog-Toolchain verfügbar, daher wird `make test` hier
übersprungen; es läuft in GitHub Actions, falls eine Prolog-Implementierung
vorhanden ist.

## Lizenz

MIT
