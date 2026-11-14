#!/usr/bin/env bash
# Scoped ACL grant for existing Valheim SMB bind mounts.
# Run on VM9001 only with the Valheim container stopped.
set -Eeuo pipefail

BASE=/srv/valheim
SHARE=$BASE/share
WORLD=$BASE/config/worlds_local
MODS=$BASE/config/bepinex

for cmd in docker getfacl setfacl findmnt runuser mountpoint mktemp; do
    command -v "$cmd" >/dev/null || { echo "MISSING: $cmd"; exit 1; }
done
test "$(docker inspect -f '{{.State.Running}}' valheim-server)" = false || {
    echo "ERROR: Stop Valheim before changing ACLs"
    exit 1
}
test "$(findmnt -rn -o SOURCE -M "$BASE")" = /dev/sdb
for name in worlds bepinex; do
    mountpoint -q "$SHARE/$name" || {
        echo "ERROR: Missing bind mount $SHARE/$name"
        exit 1
    }
done
test "$(stat -c '%d:%i' "$WORLD")" = "$(stat -c '%d:%i' "$SHARE/worlds")"
test "$(stat -c '%d:%i' "$MODS")" = "$(stat -c '%d:%i' "$SHARE/bepinex")"

umask 077
mkdir -p "$BASE/rollback"
BK=$(mktemp -d "$BASE/rollback/smb-acl.XXXXXXXX")
getfacl -Rp "$WORLD" "$MODS" > "$BK/acl.before"
trap 'rc=$?; setfacl --restore="$BK/acl.before" || true; echo "ERROR: ACL rollback attempted ($BK)"; exit "$rc"' ERR

setfacl -Rm u:vspadmin:rwX "$WORLD" "$MODS"
find "$WORLD" "$MODS" -type d -exec setfacl -m d:u:vspadmin:rwx {} +

runuser -u vspadmin -- bash -c '
set -euo pipefail
for dir in "$@"; do
    test -w "$dir"
    file=$(mktemp "$dir/.vsp-acl-check.XXXXXXXX")
    printf "ACL test\n" > "$file"
    rm -- "$file"
done
' _ "$SHARE/worlds/Valheim" "$SHARE/bepinex/plugins"

trap - ERR
echo "PASS: local write/delete via bind mounts"
echo "ACL backup: $BK/acl.before"
getfacl -p "$MODS/plugins"
