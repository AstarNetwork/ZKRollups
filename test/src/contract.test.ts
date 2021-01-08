import web3, { sendTx } from './web3'
import { AbiItem } from "web3-utils";
import Utilities from './utilities'
import ContractJson from '../build/contracts/Test.json'
import { expect } from "chai";
import { step } from "mocha-steps";

describe("EVM Contract Test", () => {
    const account = "0x17a4dC4aF1FAF9c3Db0515a170491c37eb0373Dc"
    const accoutPrivKey = "0x4dc023426c7bbd647cc9789343ac495225ff11aff3463b85dac0f503b70a119d"
    const TEST_CONTRACT_BYTECODE = ContractJson.bytecode;
    const TEST_CONTRACT_ABI = ContractJson.abi[0] as AbiItem;
    const utilities = new Utilities(account)
    const contractAddress = utilities.getContractAddress();

    before(async () => {
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

    step("Deployed Hash Test", async () => {
		  const contract = new web3.eth.Contract([TEST_CONTRACT_ABI], contractAddress, {
        from: account,
        gasPrice: "0x02",
      });
      const four = await contract.methods.double(2).call({ from: account })
		  expect(four).to.equal("4");
    });
})
