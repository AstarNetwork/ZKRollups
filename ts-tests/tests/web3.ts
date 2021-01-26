import Web3 from "web3";
import { BigNumber } from 'ethers';
import { mainchainHost } from './env';
import { RPC_PORT, createAndFinalizeBlock } from "./util";
import { ACCOUNT, PRIVATE_KEY } from './zksync/src/utils'

const web3 = new Web3(`http://${mainchainHost}:${RPC_PORT}`)

export default web3
export const finalize = async () => createAndFinalizeBlock(web3)

export const composeTransaction = async (data: string, toAddr: string) => {
    return await web3.eth.accounts.signTransaction(
        {
            from: ACCOUNT,
            to: toAddr,
            data: data,
            value: "0x00",
            gasPrice: 20000000000,
            gas: 6000000,
        },
        PRIVATE_KEY
    );
}

export const composeTransactionWithValue = async (data: string, toAddr: string, value: BigNumber) => {
    return await web3.eth.accounts.signTransaction(
        {
            from: ACCOUNT,
            to: toAddr,
            data: data,
            value: value.toHexString(),
            gasPrice: 20000000000,
            gas: 6000000
        },
        PRIVATE_KEY
    );
}
