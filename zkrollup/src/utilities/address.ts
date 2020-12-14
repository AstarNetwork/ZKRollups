import * as rlp from 'rlp'
import keccak from 'keccak'

export const getConractAddress = (sender: string, nonce: number): string => {
    const encoded = rlp.encode([sender, nonce])
    const contractHex = keccak('keccak256').update(encoded).digest('hex')
    return contractHex.substring(24)
}
