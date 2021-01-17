const ethers = require("ethers")
const url = 'http://localhost:5000'
const addr = '0x617a6822702a24f80f42fb1baef83a3a35463a8e'
const abi = require("../build/ZkSync").abi
const provider = new ethers.providers.JsonRpcProvider(url)
const TokenContract = new ethers.Contract(addr, abi, provider)

TokenContract.on('BlockVerification', console.log)
