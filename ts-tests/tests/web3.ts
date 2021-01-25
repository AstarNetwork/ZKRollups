import Web3 from "web3";
import { mainchainHost } from './env'
import { RPC_PORT, createAndFinalizeBlock } from "./util";

const web3 = new Web3(`http://${mainchainHost}:${RPC_PORT}`)

export default web3
export const finalize = async () => createAndFinalizeBlock(web3)
