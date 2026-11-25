"""Checks that the notebook produced everything the dashboard needs."""
import json
import pathlib
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
errors = []
summary = {}
s = ROOT / "outputs" / "summary.json"
if not s.exists():
    errors.append("outputs/summary.json is missing (the notebook must write it)")
else:
    summary = json.loads(s.read_text(encoding="utf-8-sig"))

spec = json.loads((ROOT / "docs" / "dashboard.json").read_text(encoding="utf-8-sig"))
for k in spec.get("kpis", []):
    if summary and k.get("key") not in summary:
        errors.append(f"KPI key '{k.get('key')}' not found in summary.json (keys: {list(summary)[:20]})")
for c in spec.get("charts", []):
    p = ROOT / "docs" / c["file"]
    if not p.exists():
        errors.append(f"docs/{c['file']} is missing (the notebook must write it)")
        continue
    rows = json.loads(p.read_text(encoding="utf-8-sig"))
    if not isinstance(rows, list) or not rows:
        errors.append(f"docs/{c['file']} must be a non-empty list of records")
        continue
    cols = set(rows[0].keys())
    for col in [c["x"], *c["y"]]:
        if col not in cols:
            errors.append(f"docs/{c['file']}: column '{col}' missing (has {sorted(cols)})")
if not list((ROOT / "outputs" / "charts").glob("*.png")):
    errors.append("No chart saved in outputs/charts/*.png")

print("\n".join(errors) if errors else "All outputs OK")
sys.exit(1 if errors else 0)
