/**
 * @jest-environment node
*/

import describeWithSubstrate from './blockchain'

describeWithSubstrate("EVM Balance Test", web3 => {
    const account = "0x6be02d1d3665660d22ff9624b7be0551ee1ac91b"
    const accountBalance = '100000000000000000000'

    it('Balance Test', async () => {
        await web3.eth.getChainId();
        const balance = await web3.eth.getBalance(account)
        expect(balance).toBe(accountBalance)
    })
})
