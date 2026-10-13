from pathlib import Path
import pandas as pd
ROOT = Path(__file__).resolve().parents[1]
for filename, key in [("customers.csv","customer_id"),("loans.csv","loan_id"),("payments.csv","payment_id")]:
    df = pd.read_csv(ROOT / "data" / filename)
    print(f"{filename}: {len(df):,} rows, {len(df.columns)} columns")
    print(f"  duplicate {key}: {df[key].duplicated().sum()}")
    print(f"  missing values: {df.isna().sum().to_dict()}")
customers = pd.read_csv(ROOT / "data" / "customers.csv")
loans = pd.read_csv(ROOT / "data" / "loans.csv")
payments = pd.read_csv(ROOT / "data" / "payments.csv")
assert loans["customer_id"].isin(customers["customer_id"]).all()
assert payments["loan_id"].isin(loans["loan_id"]).all()
print("Relationship checks passed.")
