import { expect } from "chai";
import ZkSync from '../build/contracts/ZkSync.json'
import { createAndFinalizeBlock, customRequest, describeWithFrontier } from "./util";

describeWithFrontier("Frontier RPC (Contract)", (context) => {
	const GENESIS_ACCOUNT = "0x6be02d1d3665660d22ff9624b7be0551ee1ac91b";
	const GENESIS_ACCOUNT_PRIVATE_KEY = "0x99B3C12287537E38C90A9219D4CB074A89A16E9CDB20BF85728EBD97C343E342";

	// Solidity: contract test { function multiply(uint a) public pure returns(uint d) {return a * 7;}}
	const TEST_CONTRACT_BYTECODE = ZkSync.bytecode
	const FIRST_CONTRACT_ADDRESS = "0xc2bf5f29a4384b1ab0c063e1c666f02121b6084a";
	// Those test are ordered. In general this should be avoided, but due to the time it takes
	// to spin up a frontier node, it saves a lot of time.

	it("contract creation should return transaction hash", async function () {
		this.timeout(15000);
		const tx = await context.web3.eth.accounts.signTransaction(
			{
				from: GENESIS_ACCOUNT,
				data: TEST_CONTRACT_BYTECODE,
				value: "0x00",
				gasPrice: 20000000000,
				gas: 1000000000000,
			},
			GENESIS_ACCOUNT_PRIVATE_KEY
		);

		await customRequest(context.web3, "eth_sendRawTransaction", [tx.rawTransaction]);

		expect(await customRequest(context.web3, "eth_getCode", [FIRST_CONTRACT_ADDRESS])).to.deep.equal({
			id: 1,
			jsonrpc: "2.0",
			result: "0x",
		});

		await createAndFinalizeBlock(context.web3);
		expect(await customRequest(context.web3, "eth_getCode", [FIRST_CONTRACT_ADDRESS])).to.deep.equal({
			id: 1,
			jsonrpc: "2.0",
			result: TEST_CONTRACT_BYTECODE,
		});
	});
});
