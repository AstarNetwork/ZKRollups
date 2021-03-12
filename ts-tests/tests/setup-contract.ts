import { expect } from "chai";
import Web3 from "web3";
import ZkSync from '../build/ZkSync.json'
import Verifier from '../build/Verifier.json'
import Governance from '../build/Governance.json'
import DeployFactory from '../build/DeployFactory.json'
import Utilities, { createAndFinalizeBlock, customRequest, describeWithFrontier, operatorAddress, genesisRoot } from "./util";

const GENESIS_ACCOUNT = "0x6be02d1d3665660d22ff9624b7be0551ee1ac91b";
const GENESIS_ACCOUNT_PRIVATE_KEY = "0x99B3C12287537E38C90A9219D4CB074A89A16E9CDB20BF85728EBD97C343E342";

const deployer = new Utilities(GENESIS_ACCOUNT)
const zkSyncContractAddress = deployer.getContractAddress();
const verifierContractAddress = deployer.getContractAddress();
const governanceContractAddress = deployer.getContractAddress();
const proxiesContractAddress = deployer.getContractAddress();

const contract = new Utilities(proxiesContractAddress)
const governanceProxyContractAddress = contract.incrementNonce().getContractAddress();
const verifierProxyContractAddress = contract.getContractAddress();
const zkSyncProxyContractAddress = contract.getContractAddress();
const upgradeGateKeeperContractAddress = contract.getContractAddress();

describeWithFrontier("Frontier RPC (Contract)", (context) => {
	it("contract creation should return contract bytecode", async function () {
		this.timeout(15000);
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
		await deployContract(context.web3, ZkSync.bytecode)
		await deployContract(context.web3, Verifier.bytecode)
		await deployContract(context.web3, Governance.bytecode)
		await deployContract(context.web3, DeployFactory.bytecode + proxiesContractorArgs)
		console.log("Deploy All Contracts...")
		expect((await customRequest(context.web3, "eth_getCode", [zkSyncContractAddress])).result).not.to.equal('0x')
		console.log(`ZkSync: ${zkSyncContractAddress}`)
		expect((await customRequest(context.web3, "eth_getCode", [verifierContractAddress])).result).not.to.equal('0x')
		console.log(`Verifier: ${verifierContractAddress}`)
		expect((await customRequest(context.web3, "eth_getCode", [governanceContractAddress])).result).not.to.equal('0x')
		console.log(`Governance: ${governanceContractAddress}`)

		// proxies contract destruct itself
		expect((await customRequest(context.web3, "eth_getCode", [proxiesContractAddress])).result).to.equal('0x')

		// contracts created as proxy
		expect((await customRequest(context.web3, "eth_getCode", [governanceProxyContractAddress])).result).not.to.equal('0x')
		console.log(`Governance Proxy: ${governanceProxyContractAddress}`)
		expect((await customRequest(context.web3, "eth_getCode", [verifierProxyContractAddress])).result).not.to.equal('0x')
		console.log(`Verifier Proxy: ${verifierProxyContractAddress}`)
		expect((await customRequest(context.web3, "eth_getCode", [zkSyncProxyContractAddress])).result).not.to.equal('0x')
		console.log(`ZkSync Proxy: ${zkSyncProxyContractAddress}`)
		expect((await customRequest(context.web3, "eth_getCode", [upgradeGateKeeperContractAddress])).result).not.to.equal('0x')
		console.log(`Gate Keeper Proxy: ${upgradeGateKeeperContractAddress}`)
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
};
