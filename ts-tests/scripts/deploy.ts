import Web3 from "web3"
import { AbiItem } from "web3-utils";
import ZkSync from '../build/Test.json'

const web3 = new Web3(`http://localhost:5000`);
const account = "0x6be02d1d3665660d22ff9624b7be0551ee1ac91b";
const privKey = "0x99B3C12287537E38C90A9219D4CB074A89A16E9CDB20BF85728EBD97C343E342";

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
