local env = vim.env -- shortcut

vim.g.dbs = {
  -- ─────── DEV ──────────────────────────────────────────────
  -- ['dev/entity-service'] = string.format(
  --   'ssh://bastion.dev01:postgres://serviceuser:%s@db-cluster-entityservice-dev.cluster-cmvdnlwph3z1.eu-west-1.rds.amazonaws.com:5432/entitydb',
  --   env.DEV_SALES_PASS or '!I6VBzBFBj_v6f(FQ5[auM)}oPOsz(MS' -- fall back for local use
  -- ),
  --
  -- ─────── PRE-PROD ─────────────────────────────────────────
  -- ['preprod/sales'] = string.format('ssh://bastion.preprod01:postgres://sales:%s@preprod-sales.internal:5432/sales', env.PRE_SALES_PASS),
  --
  -- -- ─────── PROD (SSL on) ───────────────────────────────────
  -- ['prod/sales'] = string.format(
  --   'ssh://bastion.prod01:postgres://sales:%s@prod-sales.internal:5432/sales?sslmode=require',
  --   env.PROD_SALES_PASS -- never hard-code prod passwords
  -- ),
  -- ['prod/finance'] = string.format('ssh://bastion-prod:postgres://fin:%s@prod-fin.internal:5432/finance?sslmode=require', env.PROD_FIN_PASS),
}
