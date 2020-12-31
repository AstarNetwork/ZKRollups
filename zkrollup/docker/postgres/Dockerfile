FROM postgres:11-alpine

ENV POSTGRES_USER="postgres"

ENV POSTGRES_PASSWORD="password"

COPY 00000000000000_diesel_initial_setup/up.sql \
     2020-04-07-065600_init_storage/up.sql \
     2020-05-13-202316_ticker_price/up.sql \
     2020-06-09-084018_block_gas_limit/up.sql \
     2020-06-30-121924_tx_meta_info/up.sql \
     2020-08-31-140338_witness_storage/up.sql \
     2020-09-01-142308_executed_priority_ops_new_pk/up.sql \
     2020-09-02-103253_mempool_txs_batches/up.sql \
     2020-09-10-220546_merkle-tree-storage/up.sql \
     2020-09-21-135622_complete_withdrawals/up.sql \
     2020-09-22-065910_use_json_for_merkle_tree/up.sql \
     2020-09-22-113305_use_json_for_block_witness/up.sql \
     2020-09-22-130104_use_text_for_block_witness/up.sql \
     2020-09-22-140531_use_text_for_account_tree_cache/up.sql \
     2020-10-06-044839_average-gas-price/up.sql \
     2020-10-28-172923_batch_signatures_table/up.sql \
     ./docker-entrypoint-initdb.d/

EXPOSE 5432
