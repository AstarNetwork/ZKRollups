import { expect } from 'chai';
import { BigNumber, utils } from 'ethers';
import { Wallet, types } from './zksync/src/index';
import { Tester } from './tester';

const TX_AMOUNT = utils.parseEther('10.0');
// should be enough for ~200 test transactions (excluding fees), increase if needed
const DEPOSIT_AMOUNT = TX_AMOUNT.mul(200);

describe("Zk Rollup Integration Test", () => {
    let tester: Tester;
    let alice: Wallet;
    let bob: Wallet;
    let chuck: Wallet;
    let operatorBalance: BigNumber;

    before('create tester and test wallets', async () => {
        tester = await Tester.init('operator', 'HTTP');
        // alice = await tester.fundedWallet('5.0');
        // bob = await tester.emptyWallet();
        // chuck = await tester.emptyWallet();
        // operatorBalance = await tester.operatorBalance('ETH');
    })

    it("should be pass", async () => {
        expect(true).to.equal(true)
    })
})
