import Utilities from './utilities'

describe("Contract Address Test", () => {
    it('Sample Contract Address', () => {
        const utilities = new Utilities("0x6be02d1d3665660d22ff9624b7be0551ee1ac91b")
        const contractAddress = utilities.getContractAddress()
        expect("0xc2bf5f29a4384b1ab0c063e1c666f02121b6084a").toBe(contractAddress)
    })
})
