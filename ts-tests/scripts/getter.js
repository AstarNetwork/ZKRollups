const Web3 = require("web3");
const web3 = new Web3(`http://localhost:5000`)
const ZkSync = require("../build/ZkSync.json")

const getVariable = async () => {
    const mainZkSyncContract = new web3.eth.Contract(
        ZkSync.abi,
        "0x617A6822702a24F80f42fB1baeF83a3a35463A8E"
    );
    const pubKey = await mainZkSyncContract.methods.authFacts('0x17a4dc4af1faf9c3db0515a170491c37eb0373dc', 0).call()
    console.log(pubKey)
}

getVariable()
