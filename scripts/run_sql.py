"""Loads every data/*.csv into SQLite and runs sql/*.sql in order. Results go to outputs/sql/."""
import pathlib
import sqlite3
import sys

import pandas as pd

ROOT = pathlib.Path(__file__).resolve().parent.parent
out = ROOT / "outputs" / "sql"
out.mkdir(parents=True, exist_ok=True)
db = sqlite3.connect(ROOT / "outputs" / "project.db")

for f in sorted((ROOT / "data").glob("*.csv")):
    df = pd.read_csv(f, low_memory=False)
    df.to_sql(f.stem, db, if_exists="replace", index=False)
    print(f"Loaded {f.name}: {len(df)} rows")

failed = []
for q in sorted((ROOT / "sql").glob("*.sql")):
    try:
        res = pd.read_sql_query(q.read_text(encoding="utf-8"), db)
        res.to_csv(out / f"{q.stem}.csv", index=False)
        print(f"OK    {q.name}: {len(res)} rows")
    except Exception as e:  # noqa: BLE001
        print(f"ERROR {q.name}: {e}")
        failed.append(q.name)

sys.exit(1 if failed else 0)
