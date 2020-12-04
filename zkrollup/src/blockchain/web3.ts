import Web3 from "web3";
import { rpcPort } from './config'

const web3 = new Web3(`http://localhost:${rpcPort}`)

export const sendRawTx = async (params: any) =>
    new Promise((resolve, reject) => {
        (web3 as any).currentProvider.send({
            jsonrpc: "2.0",
            id: 1,
            method: "eth_sendRawTransaction",
            params: params,
        }, (err: any, res: any) => {
            if (err) reject(err.toString())
            resolve(res)
        })
    })

export default web3
