import { expect } from "chai";
import Web3 from "web3";
import ZkSync from '../build/ZkSync.json'
import Verifier from '../build/Verifier.json'
import Governance from '../build/Governance.json'
import DeployFactory from '../build/DeployFactory.json'
import { operatorAddress, genesisRoot } from './util'
import Utilities, { createAndFinalizeBlock, customRequest, describeWithFrontier } from "./util";

const GENESIS_ACCOUNT = "0x6be02d1d3665660d22ff9624b7be0551ee1ac91b";
const GENESIS_ACCOUNT_PRIVATE_KEY = "0x99B3C12287537E38C90A9219D4CB074A89A16E9CDB20BF85728EBD97C343E342";

const utilities = new Utilities(GENESIS_ACCOUNT)
const zkSyncContractAddress = utilities.getContractAddress();
const verifierContractAddress = utilities.getContractAddress();
const governanceContractAddress = utilities.getContractAddress();
const proxiesContractAddress = utilities.getContractAddress();

describeWithFrontier("Frontier RPC (Contract)", (context) => {
	it("contract creation should return contract bytecode", async function () {
		const proxiesContractorArgs = context.web3.eth.abi.encodeParameters(
			['address', 'address', 'address', 'bytes32', 'address', 'address', 'address'],
			[
				governanceContractAddress,
				verifierContractAddress,
				zkSyncContractAddress,
				genesisRoot,
				operatorAddress,
				operatorAddress,
				operatorAddress
			]).slice(2)
		this.timeout(15000);
		await deployContract(context.web3, ZkSync.bytecode)
		await deployContract(context.web3, Verifier.bytecode)
		await deployContract(context.web3, Governance.bytecode)
		await deployContract(context.web3, DeployFactory.bytecode + proxiesContractorArgs)
		const zkSyncCode = await customRequest(context.web3, "eth_getCode", [zkSyncContractAddress])
		const verifierCode = await customRequest(context.web3, "eth_getCode", [verifierContractAddress])
		const governanceCode = await customRequest(context.web3, "eth_getCode", [governanceContractAddress])
		const deployFactoryCode = await customRequest(context.web3, "eth_getCode", [zkSyncContractAddress])
		expect(zkSyncCode.result).not.to.equal('0x')
		expect(verifierCode.result).not.to.equal('0x')
		expect(governanceCode.result).not.to.equal('0x')
		expect(deployFactoryCode.result).not.to.equal('0x')
	});
});

const deployContract = async(web3: Web3, bytecode: string) => {
	const tx = await web3.eth.accounts.signTransaction(
		{
			from: GENESIS_ACCOUNT,
			data: bytecode,
			value: "0x00",
			gasPrice: 20000000000,
			gas: 6000000,
		},
		GENESIS_ACCOUNT_PRIVATE_KEY
	);

	await customRequest(web3, "eth_sendRawTransaction", [tx.rawTransaction]);
	await createAndFinalizeBlock(web3);
}
