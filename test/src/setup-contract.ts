import { web3 } from "./util";
import Web3 from "web3"
import ZkSync from '../build/ZkSync.json'
import Verifier from '../build/Verifier.json'
import Governance from '../build/Governance.json'
import DeployFactory from '../build/DeployFactory.json'
import Utilities, { createAndFinalizeBlock, customRequest, operatorAddress, genesisRoot } from "./util";

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

const deployContracts = async() => {
		const proxiesContractorArgs = web3.eth.abi.encodeParameters(
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
		await deployContract(web3, ZkSync.bytecode)
		await deployContract(web3, Verifier.bytecode)
		await deployContract(web3, Governance.bytecode)
		await deployContract(web3, DeployFactory.bytecode + proxiesContractorArgs)
		console.log("Deploy All Contracts...")
		await customRequest(web3, "eth_getCode", [zkSyncContractAddress])
		console.log(`ZkSync: ${zkSyncContractAddress}`)
		await customRequest(web3, "eth_getCode", [verifierContractAddress])
		console.log(`Verifier: ${verifierContractAddress}`)
		await customRequest(web3, "eth_getCode", [governanceContractAddress])
		console.log(`Governance: ${governanceContractAddress}`)

		// proxies contract destruct itself
		await customRequest(web3, "eth_getCode", [proxiesContractAddress])

		// contracts created as proxy
		await customRequest(web3, "eth_getCode", [governanceProxyContractAddress])
		console.log(`Governance Proxy: ${governanceProxyContractAddress}`)
		await customRequest(web3, "eth_getCode", [verifierProxyContractAddress])
		console.log(`Verifier Proxy: ${verifierProxyContractAddress}`)
		await customRequest(web3, "eth_getCode", [zkSyncProxyContractAddress])
		console.log(`ZkSync Proxy: ${zkSyncProxyContractAddress}`)
		await customRequest(web3, "eth_getCode", [upgradeGateKeeperContractAddress])
		console.log(`Gate Keeper Proxy: ${upgradeGateKeeperContractAddress}`)
}

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

deployContracts()
