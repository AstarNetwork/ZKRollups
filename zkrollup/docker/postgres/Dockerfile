FROM postgres:11-alpine

ENV POSTGRES_USER="postgres"

ENV POSTGRES_PASSWORD="password"

ENV POSTGRES_DB="zksync"

COPY 00000000000000_diesel_initial_setup/up.sql ./docker-entrypoint-initdb.d/1.sql
COPY 2020-04-07-065600_init_storage/up.sql ./docker-entrypoint-initdb.d/2.sql
COPY 2020-05-13-202316_ticker_price/up.sql ./docker-entrypoint-initdb.d/3.sql
COPY 2020-06-09-084018_block_gas_limit/up.sql ./docker-entrypoint-initdb.d/4.sql
COPY 2020-06-30-121924_tx_meta_info/up.sql ./docker-entrypoint-initdb.d/5.sql
COPY 2020-08-31-140338_witness_storage/up.sql ./docker-entrypoint-initdb.d/6.sql
COPY 2020-09-01-142308_executed_priority_ops_new_pk/up.sql ./docker-entrypoint-initdb.d/7.sql
COPY 2020-09-02-103253_mempool_txs_batches/up.sql ./docker-entrypoint-initdb.d/8.sql
COPY 2020-09-10-220546_merkle-tree-storage/up.sql ./docker-entrypoint-initdb.d/9.sql
COPY 2020-09-21-135622_complete_withdrawals/up.sql ./docker-entrypoint-initdb.d/a.sql
COPY 2020-09-22-065910_use_json_for_merkle_tree/up.sql ./docker-entrypoint-initdb.d/b.sql
COPY 2020-09-22-113305_use_json_for_block_witness/up.sql ./docker-entrypoint-initdb.d/c.sql
COPY 2020-09-22-130104_use_text_for_block_witness/up.sql ./docker-entrypoint-initdb.d/d.sql
COPY 2020-09-22-140531_use_text_for_account_tree_cache/up.sql ./docker-entrypoint-initdb.d/e.sql
COPY 2020-10-06-044839_average-gas-price/up.sql ./docker-entrypoint-initdb.d/f.sql
COPY 2020-10-28-172923_batch_signatures_table/up.sql ./docker-entrypoint-initdb.d/g.sql

EXPOSE 5432
