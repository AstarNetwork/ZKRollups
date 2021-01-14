import Web3 from "web3"
import ZkSync from '../build/ZkSync.json'

const web3 = new Web3(`http://substrate:3000`);
const account = "0x17a4dC4aF1FAF9c3Db0515a170491c37eb0373Dc";
const privKey = "0x4dc023426c7bbd647cc9789343ac495225ff11aff3463b85dac0f503b70a119d";

const deployContract = async () => {
    const tx = await web3.eth.accounts.signTransaction(
        {
            from: account,
            data: ZkSync.bytecode,
            value: "0x00",
            gasPrice: 20000000000,
            gas: 6000000,
        },
        privKey
    );
    const res = await web3.eth.sendSignedTransaction(tx.rawTransaction)
    console.log(res)
}

deployContract()
