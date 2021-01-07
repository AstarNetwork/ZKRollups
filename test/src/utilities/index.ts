import * as rlp from 'rlp'
import keccak from 'keccak'

export default class Utilities {
    address: string
    nonce: number

    constructor(address: string) {
        this.address = address
        this.nonce = 0x00
    }

    getContractAddress = (): string => {
        const contractAddress = this.calculateContractAddress()
        this.nonce++
        return contractAddress
    }

    private calculateContractAddress = (): string => {
        const encoded = rlp.encode([this.address, this.nonce])
        const contractHex = keccak('keccak256').update(encoded).digest('hex')
        return "0x" + contractHex.substring(24)
    }
}
