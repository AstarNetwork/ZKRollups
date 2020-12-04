/**
 * @jest-environment node
*/

import describeWithSubstrate from './blockchain'

describeWithSubstrate("KZ Rollup Contracts Test", (web3) => {
    const account = "0x6be02d1d3665660d22ff9624b7be0551ee1ac91b"
    const accountBalance = '340282366920938463463374607431768211455'

    it('Balance Test', async () => {
        const balance = await web3.eth.getBalance(account)
        expect(balance).toBe(accountBalance)
    })
})
