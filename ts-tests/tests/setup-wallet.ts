import { expect } from "chai";
import { step } from "mocha-steps";

import { createAndFinalizeBlock, describeWithFrontier, customRequest } from "./util";
import { BigNumber } from 'ethers';

describeWithFrontier("Frontier RPC (Balance)", (context) => {
	const GENESIS_ACCOUNT = "0x6be02d1d3665660d22ff9624b7be0551ee1ac91b";
	const GENESIS_ACCOUNT_PRIVATE_KEY = "0x99B3C12287537E38C90A9219D4CB074A89A16E9CDB20BF85728EBD97C343E342";
	const ACTOR_ACCOUNT = "0x17a4dC4aF1FAF9c3Db0515a170491c37eb0373Dc"

	step("genesis balance is setup correctly", async function () {
		expect(await context.web3.eth.getBalance(GENESIS_ACCOUNT)).not.to.equal('0');
	});

	step("balance to be updated after transfer", async function () {
		this.timeout(15000);
		const gwei = BigNumber.from(1000000000)
		const ether = gwei.mul(100000000)
		const unit = BigNumber.from(5000)
		const value = ether.mul(unit)
		const tx = await context.web3.eth.accounts.signTransaction({
			from: GENESIS_ACCOUNT,
			to: ACTOR_ACCOUNT,
			value: value.toHexString(),
			gasPrice: "0x01",
			gas: "0x100000",
		}, GENESIS_ACCOUNT_PRIVATE_KEY);
		await customRequest(context.web3, "eth_sendRawTransaction", [tx.rawTransaction]);
		await createAndFinalizeBlock(context.web3);
		expect(await context.web3.eth.getBalance(ACTOR_ACCOUNT)).to.equal(value.toString());
	});
});
