/**
 * @jest-environment node
*/

import describeWithSubstrate, { sendTx } from './blockchain'
import { AbiItem } from "web3-utils";
import Utilities from './utilities'
import ContractJson from '../build/contracts/Test.json'

describeWithSubstrate("EVM Contract Test", web3 => {
    const account = "0x17a4dC4aF1FAF9c3Db0515a170491c37eb0373Dc"
    const accoutPrivKey = "0x4dc023426c7bbd647cc9789343ac495225ff11aff3463b85dac0f503b70a119d"
    const TEST_CONTRACT_BYTECODE = ContractJson.bytecode;
    const TEST_CONTRACT_ABI = ContractJson.abi[0] as AbiItem;
    const utilities = new Utilities(account)
    const contractAddress = utilities.getContractAddress();

    beforeEach(async () => {
        const tx = await web3.eth.accounts.signTransaction({
				from: account,
				data: TEST_CONTRACT_BYTECODE,
				value: "0x00",
				gasPrice: "0x01",
				gas: "0x100000",
			},
			accoutPrivKey);
        await sendTx("eth_sendRawTransaction", [tx.rawTransaction]) as any
        await sendTx("engine_createBlock", [true, true, null])
    })

    it("Deployed Hash Test", async () => {
		const contract = new web3.eth.Contract([TEST_CONTRACT_ABI], contractAddress, {
			from: account,
			gasPrice: "0x02",
        });
        const four = await contract.methods.double(2).call({ from: account })
		expect(four).toBe("4");
    });
})
