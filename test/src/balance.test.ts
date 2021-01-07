import web3, { sendTx } from './web3'
import { expect } from "chai";
import { step } from "mocha-steps";

describe("EVM Balance Test", () => {
    const account = "0x17a4dC4aF1FAF9c3Db0515a170491c37eb0373Dc"
    const accountBalance = '100000000000000000000'
    const accoutPrivKey = "0x4dc023426c7bbd647cc9789343ac495225ff11aff3463b85dac0f503b70a119d"
    const recipient = "0xbF67c688C99cfE879165706d1FE0A5F80a39dFA6"

    it('Balance Test', async () => {
        const balance = await web3.eth.getBalance(account)
        expect(balance).to.equal(accountBalance)
    })

    it('Transfer Test', async () => {
        const tx = await web3.eth.accounts.signTransaction({
            from: account,
            to: recipient,
            value: 1000000000000000000,
            gasPrice: "0x01",
            gas: "0x100000"
        }, accoutPrivKey)
        await sendTx("eth_sendRawTransaction", [tx.rawTransaction])
        await sendTx("engine_createBlock", [true, true, null])
        const balance = await web3.eth.getBalance(recipient)
        expect(balance).to.equal("1000000000000000000")
    })
})
