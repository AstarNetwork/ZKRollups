import Web3 from "web3"
import { AbiItem } from "web3-utils";
import ZkSync from '../build/Test.json'

const web3 = new Web3(`http://localhost:7545`);
const account = "0x17a4dC4aF1FAF9c3Db0515a170491c37eb0373Dc";
const privKey = "0x4dc023426c7bbd647cc9789343ac495225ff11aff3463b85dac0f503b70a119d";

const deployContract = async () => {
    const tx1 = await composeDeployTransaction(ZkSync.bytecode)
    const res = await sendTransaction("eth_sendRawTransaction", [tx1.rawTransaction]) as any
    await sendTransaction('engine_createBlock', [true, true, null])
    const res2 = await web3.eth.getTransactionReceipt(res.result)
    const data = await composeContractTx(res2.contractAddress)
    const tx2 = await composeTransaction(data, res2.contractAddress)
    console.log(tx2.rawTransaction)
    const res3 = await sendTransaction("eth_sendRawTransaction", [tx2.rawTransaction]) as any
    await sendTransaction('engine_createBlock', [true, true, null])
    const res4 = await web3.eth.getTransactionReceipt(res3.result)
    console.log(res4)
}

const sendTransaction = async (method: string, params: any[]) => {
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


const composeTransaction = async (data: string, toAddr: string) => {
    return await web3.eth.accounts.signTransaction(
        {
            from: account,
            to: toAddr,
            data: data,
            value: "0x00",
            gasPrice: 20000000000,
            gas: 6000000,
        },
        privKey
    );
}

const composeDeployTransaction = async (data: string) => {
    return await web3.eth.accounts.signTransaction(
        {
            from: account,
            data: data,
            value: "0x00",
            gasPrice: 20000000000,
            gas: 6000000,
        },
        privKey
    );
}

const composeContractTx = async (address: string) => {
    const Test = new web3.eth.Contract(ZkSync.abi as AbiItem[], address)
    const exec = await Test.methods.store("hello")
    return exec.encodeABI()
}

deployContract()
