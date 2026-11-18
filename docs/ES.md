# shae-prolog-family-tree (es)

Un sistema de razonamiento de árbol genealógico en Prolog. Proporciona
hechos (`parent/2`, `male/1`, `female/1`) y reglas (`mother/2`, `father/2`,
`sister/2`, `brother/2`, `aunt/2`, `uncle/2`, `grandparent/2`, `ancestor/2`,
`cousin/2`, `siblings/2`) sobre una familia de ejemplo de 12 personas en 3
generaciones.

## Requisitos

- SWI-Prolog (`swipl`) o GNU Prolog (`gprolog`)
  - No instalado en este entorno; el código fuente está escrito en sintaxis
    de Prolog auténtica y está destinado a ejecutarse en una implementación
    de Prolog o en GitHub Actions.

## Instalación

```bash
git clone https://github.com/spdedsec/shae-prolog-family-tree.git
cd shae-prolog-family-tree
bash scripts/install.sh
```

`scripts/install.sh` detecta `swipl` o `gprolog` y crea
`~/.local/bin/shae-family-tree`, un wrapper que consulta `src/family.pl`.
Si no se encuentra ninguna implementación de Prolog, imprime instrucciones.

## Uso

```bash
# Cargar el árbol genealógico y entrar al toplevel de Prolog
swipl -f src/family.pl

# Ejecutar una consulta individual y salir
swipl -f src/family.pl -g 'grandparent(john, alice), halt.'

# A través del wrapper instalado
shae-family-tree -g 'cousin(alice, carol), halt.'
```

## Consultas de ejemplo

| Consulta | Significado |
|----------|-------------|
| `?- mother(mary, michael).` | ¿Es Mary la madre de Michael? |
| `?- father(john, susan).` | ¿Es John el padre de Susan? |
| `?- sister(susan, michael).` | ¿Es Susan la hermana de Michael? |
| `?- brother(michael, susan).` | ¿Es Michael el hermano de Susan? |
| `?- aunt(susan, alice).` | ¿Es Susan la tía de Alice? |
| `?- uncle(david, bob).` | ¿Es David el tío de Bob? |
| `?- grandparent(john, alice).` | ¿Es John el abuelo de Alice? |
| `?- ancestor(mary, dan).` | ¿Es Mary un antepasado de Dan? |
| `?- cousin(alice, carol).` | ¿Son Alice y Carol primos? |
| `?- siblings(alice, bob).` | ¿Son Alice y Bob hermanos? |
| `?- ancestor(john, Who).` | ¿Quiénes son los descendientes de John? |

## Pruebas

```bash
make test
```

Consulta `src/family.pl` y ejecuta consultas de demostración. En esta
máquina no hay disponible una toolchain de Prolog, por lo que `make test`
se omite aquí; se ejecuta en GitHub Actions si hay una implementación de
Prolog presente.

## Licencia

MIT
