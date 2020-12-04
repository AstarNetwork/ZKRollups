import Web3 from "web3";
import { rpcPort } from './config'

const web3 = new Web3(`http://localhost:${rpcPort}`)

export default web3
