import { expect } from 'chai';
import { BigNumber, utils } from 'ethers';
import { Wallet, types } from './zksync/src/index';
import { Tester } from './tester';
import { step } from "mocha-steps";

import { describeWithFrontier, createAndFinalizeBlock } from './util'

const TX_AMOUNT = utils.parseEther('10.0');
// should be enough for ~200 test transactions (excluding fees), increase if needed
const DEPOSIT_AMOUNT = TX_AMOUNT.mul(200);

describeWithFrontier("Zk Rollup Integration Test", function (context) {
    let tester: Tester;
    let alice: Wallet;
    let bob: Wallet;
    let chuck: Wallet;
    let operatorBalance: BigNumber;

    before('create tester and test wallets', async function() {
        this.timeout(150000);
        tester = await Tester.init('operator', 'HTTP');
		await createAndFinalizeBlock(context.web3);
        console.log('tester')
        alice = await tester.fundedWallet('5.0');
        console.log('alice')
        bob = await tester.emptyWallet();
        console.log('bob')
        chuck = await tester.emptyWallet();
        console.log('chuck')
        operatorBalance = await tester.operatorBalance('ETH');
        console.log('operator')
    })

    step("should be pass", async function () {
        expect(true).to.equal(true)
    })
})
