import Web3 from "web3";

const web3 = new Web3(`http://substrate:3000`)

export const sendTx = async (method: string, params: any) =>
    new Promise((resolve, reject) => {
        const tx = {
            jsonrpc: "2.0",
            id: 1,
            method,
            params,
        };
        (web3 as any).currentProvider.send(tx, (err: any, res: any) => {
            if (err)
                reject(err.toString())
            else
                resolve(res)
        })
    })

export default web3
