#!/usr/bin/env bash
set -euo pipefail

PROJECT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="$PROJECT/inventory/desktop-launchers-$(date +%Y%m%d-%H%M%S).md"

python3 - <<'PY'
from pathlib import Path

dirs = [
    Path("/run/current-system/sw/share/applications"),
    Path("/usr/share/applications"),
    Path.home() / ".local/share/applications",
    Path.home() / "Desktop",
]

rows = []
for d in dirs:
    if not d.exists():
        continue
    for f in sorted(d.glob("*.desktop")):
        text = f.read_text(errors="ignore")
        fields = {"Name": "", "Exec": "", "Icon": "", "Categories": "", "Comment": ""}
        for line in text.splitlines():
            for k in fields:
                if line.startswith(k + "=") and not fields[k]:
                    fields[k] = line.split("=", 1)[1]
        if fields["Name"] or fields["Exec"]:
            rows.append((fields["Name"], str(f), fields["Exec"], fields["Icon"], fields["Categories"], fields["Comment"]))

out = Path("REPLACE_OUT")
with out.open("w") as fh:
    fh.write("# Desktop Launcher Inventory\n\n")
    fh.write("| Name | File | Exec | Current Icon | Categories | Comment |\n")
    fh.write("|---|---|---|---|---|---|\n")
    for row in rows:
        def clean(s):
            return (s or "").replace("|", "\\|").replace("\n", " ").strip()
        fh.write("| " + " | ".join(f"`{clean(x)}`" if i in [1,2,3] else clean(x) for i,x in enumerate(row)) + " |\n")
PY
