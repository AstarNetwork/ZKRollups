import * as ethers from 'ethers';
import { BigNumber } from 'ethers';
import * as zksync from './zksync/src/index';
import ZkSync from '../build/ZkSync.json'
import config from './config/eth.json'
import { composeTransactionWithValue } from './web3'
import web3, { finalize, sendTransaction } from './zksync/src/web3';
require('dotenv').config();

const franklin_abi = ZkSync.abi;
type Network = 'localhost' | 'rinkeby' | 'ropsten' | 'operator';

export class Tester {
    public contract: ethers.Contract;
    public runningFee: ethers.BigNumber;
    constructor(
        public network: Network,
        public ethProvider: ethers.providers.Provider,
        public syncProvider: zksync.Provider,
        public ethWallet: ethers.Wallet,
        public syncWallet: zksync.Wallet
    ) {
        this.contract = new ethers.Contract(syncProvider.contractAddress.mainContract, franklin_abi, ethWallet);
        this.runningFee = ethers.BigNumber.from(0);
    }

    // prettier-ignore
    static async init(network: Network, transport: 'WS' | 'HTTP') {
        const ethProvider = new ethers.providers.JsonRpcProvider(config.web3_url)
        if (network == 'localhost') {
            ethProvider.pollingInterval = 100;
        }
        const syncProvider = await zksync.getDefaultProvider(network, transport);
        const ethWallet = ethers.Wallet.fromMnemonic(
            config.test_mnemonic as string,
            "m/44'/60'/0'/0/0"
        ).connect(ethProvider);
        const syncWallet = await zksync.Wallet.fromEthSigner(ethWallet, syncProvider);
        return new Tester(network, ethProvider, syncProvider, ethWallet, syncWallet);
    }

    async disconnect() {
        await this.syncProvider.disconnect();
    }

    async fundedWallet() {
        const gwei = BigNumber.from(1000000000)
        const ether = gwei.mul(100000000)
        const unit = BigNumber.from(10)
        const newWallet = ethers.Wallet.createRandom().connect(this.ethProvider);
        const syncWallet = await zksync.Wallet.fromEthSigner(newWallet, this.syncProvider);
        const tx = await composeTransactionWithValue('0x', newWallet.address, ether.mul(unit));
        await sendTransaction("eth_sendRawTransaction", [tx.rawTransaction]) as any
        await finalize();
        return syncWallet;
    }

    async emptyWallet() {
        let ethWallet = ethers.Wallet.createRandom().connect(this.ethProvider);
        return await zksync.Wallet.fromEthSigner(ethWallet, this.syncProvider);
    }

    async operatorBalance(token: zksync.types.TokenLike) {
        const operatorAddress = process.env.OPERATOR_FEE_ETH_ADDRESS as string;
        const accountState = await this.syncProvider.getState(operatorAddress);
        const tokenSymbol = this.syncProvider.tokenSet.resolveTokenSymbol(token);
        const balance = accountState.committed.balances[tokenSymbol] || '0';
        return ethers.BigNumber.from(balance);
    }
}
