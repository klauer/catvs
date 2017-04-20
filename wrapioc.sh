#!/bin/sh
set -e

die() {
    echo "$1" >&2
    exit 1
}

[ "$WRAPDEBUG" ] && set -x

[ -x "$SOFTIOC" ] || ((env |grep IOC) && die "Must set \$SOFTIOC to softIoc executable")

cat <<EOF > test.db
record(longout, "ival") {
    field(VAL, "42")
}
record(waveform, "aval") {
    field(FTVL, "SHORT")
    field(NELM, "5")
}
EOF

exec "$SOFTIOC" -d test.db
