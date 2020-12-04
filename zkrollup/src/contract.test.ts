/**
 * @jest-environment node
*/

import describeWithSubstrate from './blockchain'

describeWithSubstrate("EVM Contract Test", web3 => {
    it("Deploy Test", async () => {
        expect(true).toBe(true)
    })
})
