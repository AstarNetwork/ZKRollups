import { getConractAddress } from './utilities/address'

describe("Contract Address Test", () => {
    it('Sample Contract Address', () => {
        const contractAddress = getConractAddress("0x6be02d1d3665660d22ff9624b7be0551ee1ac91b", 0x00)
        console.log(contractAddress)
    })
})