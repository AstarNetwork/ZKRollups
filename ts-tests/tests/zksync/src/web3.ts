import Web3 from "web3";
import { ACCOUNT, PRIVATE_KEY } from './utils'
const web3 = new Web3(`http://substrate:5000`)

export default web3

export const sendTransaction = async (method: string, params: any[]) => {
    return new Promise((resolve, reject) => {
        (web3.currentProvider as any).send(
        {
            jsonrpc: "2.0",
            id: 1,
            method,
            params,
        },
        (e, r) => {
            if (e) reject(e)
            else resolve(r)
        }
    )});
}

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
