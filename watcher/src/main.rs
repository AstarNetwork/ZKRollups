use hex_literal::hex;
use web3::{
    contract,
    transports, Web3,
    types::{FilterBuilder, Address},
};
use tokio;

#[tokio::main]
async fn main() -> contract::Result<()> {
    let web3 = Web3::new(transports::Http::new("http://substrate:5000")?);

    println!("Creating Filter...");
    let contract_addr: Address = "65cf84183883c3e38280e549f647b775cf7cb7db".parse().unwrap();
    let filter = FilterBuilder::default()
            .address(vec![contract_addr])
            .topics(Some(vec![hex!(
                "d0943372c08b438a88d4b39d77216901079eda9ca59d45349841c099083b6830"
            )
            .into()]), None, None, None)
            .build();

    let res = web3
        .eth()
        .logs(filter)
        .await;

    println!("{:?}", res);
    Ok(())
}