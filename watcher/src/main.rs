use hex_literal::hex;
use web3::{
    contract,
    transports, Web3,
    types::{BlockNumber, FilterBuilder, Address},
};
use tokio;

#[tokio::main]
async fn main() -> contract::Result<()> {
    let web3 = Web3::new(transports::Http::new("http://localhost:7545")?);

    println!("Creating Filter...");
    let contract_addr: Address = "6798b7a0b24d01a14399ebe742fc3a9c41a597ff".parse().unwrap();
    let filter = FilterBuilder::default()
            .address(vec![contract_addr])
            .from_block(BlockNumber::from(0))
            .to_block(BlockNumber::from(5))
            .topics(Some(vec![hex!(
                "9b5478c99b5ca41beec4f6f6084126d6f9e26382d017b4bb67c37c9e8453a313"
            )
            .into()]), None, None, None)
            .build();
    println!("filter start");
    println!("{:?}", filter);

    let res = web3
        .eth()
        .logs(filter)
        .await;

    println!("res start");
    println!("{:?}", res);
    Ok(())
}

// { from_block: Some(Number(0)), to_block: Some(Number(5)), address: Some(ValueOrArray([0x617a6822702a24f80f42fb1baef83a3a35463a8e])), topics: Some([Some(ValueOrArray([0xd0943372c08b438a88d4b39d77216901079eda9ca59d45349841c099083b6830]))]), limit: None }
// { from_block: Some(Number(0)), to_block: Some(Number(5)), address: Some(ValueOrArray([0x617a6822702a24f80f42fb1baef83a3a35463a8e])), topics: Some([Some(ValueOrArray([0x9b5478c99b5ca41beec4f6f6084126d6f9e26382d017b4bb67c37c9e8453a313]))]), limit: None }