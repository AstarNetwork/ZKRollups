import web3, { sendTx } from './web3'
import { AbiItem } from "web3-utils";
import Utilities from './utilities'
import ZkSync from '../build/contracts/ZkSync.json'
import Verifier from '../build/contracts/Verifier.json'
import Governance from '../build/contracts/Test.json'
import Proxies from '../build/contracts/Proxy.json'
import { expect } from "chai";
import { step } from "mocha-steps";
const account = "0x17a4dC4aF1FAF9c3Db0515a170491c37eb0373Dc"
const accoutPrivKey = "0x4dc023426c7bbd647cc9789343ac495225ff11aff3463b85dac0f503b70a119d"

describe("EVM Contract Test", () => {
    const utilities = new Utilities(account)
    const governanceContractAddress = utilities.getContractAddress();
    console.log(governanceContractAddress)
    const verifierContractAddress = utilities.getContractAddress();
    const zkSyncContractAddress = utilities.getContractAddress();
    const proxiesContractAddress = utilities.getContractAddress();

    before(async () => {
      await deployContract(Governance.bytecode)
    })

    step("Deployed Governance Contract Test", async () => {
		  expect(await sendTx("eth_getCode", [governanceContractAddress]) as any).to.equal({
        id: 1,
        jsonrpc: "2.0",
        result:
        Governance.bytecode,
      });
    });

    // step("Deployed Hash Test", async () => {
		//   const contract = new web3.eth.Contract(Governance.abi as AbiItem[], governanceContractAddress, {
    //     from: account,
    //     gasPrice: "0x02",
    //   });
    //   const four = await contract.methods.hello().call()
		//   expect(four).to.equal("DAI");
    // });
})

const deployContract = async(bytecode: string) => {
  const tx = await web3.eth.accounts.signTransaction({
      from: account,
      data: bytecode,
      value: "0x00",
      gasPrice: "0x01000",
      gas: "0x1000000000"
    },
    accoutPrivKey
  );
  const res1 = await sendTx("eth_sendRawTransaction", [tx.rawTransaction]) as any
  const res2 = await sendTx("engine_createBlock", [true, true, null])
  console.log(res1, res2)
}
