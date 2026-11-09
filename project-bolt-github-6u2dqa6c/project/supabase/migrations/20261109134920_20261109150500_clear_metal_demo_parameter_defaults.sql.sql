/*
# Clear placeholder price parameters on metals

1. Schema changes
- Removes the default values of `base_price`, `volatility` and `trend` on `metals`.
  The defaults were placeholders (0, 0.02, 0) and must not appear as market data.

2. Data changes
- Sets `base_price`, `volatility` and `trend` to NULL on all metals rows.
  These columns are demo-generator parameters and hold no real market prices.

3. Security
- No changes to row level security, grants or policies.

4. Notes
- Real prices are written only by the collector into price_quotations.
*/

ALTER TABLE metals ALTER COLUMN base_price DROP DEFAULT;
ALTER TABLE metals ALTER COLUMN volatility DROP DEFAULT;
ALTER TABLE metals ALTER COLUMN trend DROP DEFAULT;

UPDATE metals SET base_price = NULL, volatility = NULL, trend = NULL
WHERE base_price IS NOT NULL OR volatility IS NOT NULL OR trend IS NOT NULL;
