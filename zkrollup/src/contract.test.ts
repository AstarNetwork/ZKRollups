/**
 * @jest-environment node
*/

import describeWithSubstrate, { sendTx } from './blockchain'
import { AbiItem } from "web3-utils";

describeWithSubstrate("EVM Contract Test", web3 => {
    const account = "0x17a4dC4aF1FAF9c3Db0515a170491c37eb0373Dc"
    const accoutPrivKey = "0x4dc023426c7bbd647cc9789343ac495225ff11aff3463b85dac0f503b70a119d"
    const TEST_CONTRACT_BYTECODE =
    "0x6080604052348015600f57600080fd5b5060ae8061001e6000396000f3fe6080604052348015600f57600080fd5b506004361060285760003560e01c8063c6888fa114602d575b600080fd5b605660048036036020811015604157600080fd5b8101908080359060200190929190505050606c565b6040518082815260200191505060405180910390f35b600060078202905091905056fea265627a7a72315820f06085b229f27f9ad48b2ff3dd9714350c1698a37853a30136fa6c5a7762af7364736f6c63430005110032";
    const TEST_CONTRACT_ABI = {
        constant: true,
        inputs: [{ internalType: "uint256", name: "a", type: "uint256" }],
        name: "multiply",
        outputs: [{ internalType: "uint256", name: "d", type: "uint256" }],
        payable: false,
        stateMutability: "pure",
        type: "function",
    } as AbiItem;
    const FIRST_CONTRACT_ADDRESS = "0xc2bf5f29a4384b1ab0c063e1c666f02121b6084a";

    beforeEach(async () => {
        const tx = await web3.eth.accounts.signTransaction(
			{
				from: account,
				data: TEST_CONTRACT_BYTECODE,
				value: "0x00",
				gasPrice: "0x01",
				gas: "0x100000",
			},
			accoutPrivKey
        );
        const res = await sendTx("eth_sendRawTransaction", [tx.rawTransaction]) as any
        const res2 = await web3.eth.getTransactionReceipt(res.result)
        // console.log(res2)
        await sendTx("engine_createBlock", [true, true, null])
    })

    it("Deployed Hash Test", async () => {
		const latestBlock = await web3.eth.getBlock("latest");
		expect(latestBlock.transactions.length).toBe(1);

		const tx_hash = latestBlock.transactions[0];
		const tx = await web3.eth.getTransaction(tx_hash);
		expect(tx.hash).toBe(tx_hash);
    });

    // it("should return contract method result", async function () {
	// 	const contract = new web3.eth.Contract([TEST_CONTRACT_ABI], FIRST_CONTRACT_ADDRESS, {
	// 		from: account,
	// 		gasPrice: "0x02",
	// 	});

	// 	expect(await contract.methods.multiply(3).call()).toBe("21");
	// });
})
