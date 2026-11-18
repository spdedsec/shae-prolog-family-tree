#!/usr/bin/env bash
# scripts/install.sh — install shae-family-tree
#
# This project is Prolog source. There is no binary to install; instead we
# create a ~/.local/bin/shae-family-tree wrapper that loads src/family.pl
# with whichever Prolog implementation is available (SWI-Prolog preferred,
# GNU Prolog as fallback).
#
# Requires SWI-Prolog (swipl) or GNU Prolog (gprolog) on the target machine.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FAMILY_PL="$REPO_DIR/src/family.pl"
TARGET="$HOME/.local/bin/shae-family-tree"

PROLOG=""
if command -v swipl >/dev/null 2>&1; then
    PROLOG="swipl"
elif command -v gprolog >/dev/null 2>&1; then
    PROLOG="gprolog"
fi

mkdir -p "$HOME/.local/bin"

if [ -n "$PROLOG" ]; then
    if [ "$PROLOG" = "swipl" ]; then
        cat > "$TARGET" <<EOF
#!/usr/bin/env bash
exec swipl -f "$FAMILY_PL" "\$@"
EOF
    else
        cat > "$TARGET" <<EOF
#!/usr/bin/env bash
exec gprolog --consult-file "$FAMILY_PL" --entry-goal repl "\$@"
EOF
    fi
    chmod +x "$TARGET"
    echo "Installed shae-family-tree -> $TARGET (using $PROLOG)"
    echo "Example: shae-family-tree -g 'grandparent(john, alice), halt.'"
else
    echo "NOTE: no Prolog implementation found (swipl or gprolog)." >&2
    echo "      Install SWI-Prolog or GNU Prolog, then run:" >&2
    echo "        swipl -f $FAMILY_PL" >&2
    echo "      Example queries:" >&2
    echo "        ?- grandparent(john, alice)." >&2
    echo "        ?- ancestor(mary, dan)." >&2
    echo "        ?- cousin(alice, carol)." >&2
fi

echo "Ensure $HOME/.local/bin is on your PATH."
