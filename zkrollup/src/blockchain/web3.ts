import Web3 from "web3";
import { wsPort } from './config'

const web3 = new Web3(`http://localhost:${wsPort}`)

export default web3
