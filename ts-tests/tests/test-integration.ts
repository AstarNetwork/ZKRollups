import { expect } from 'chai';
import { step } from "mocha-steps";
import { describeWithFrontier, createAndFinalizeBlock } from './util'
import { operatorHost } from './env';

import { BigNumber, utils } from 'ethers';
import { Wallet } from './zksync/index';
import { Tester } from './tester';
import './priority-ops';
import './change-pub-key';
import './transfer';
import './withdraw';
import './forced-exit';
import './misc';

const gwei = BigNumber.from(1000000000)
const ether = gwei.mul(100000000)
const unit = BigNumber.from(200)
const depositAmount = ether.mul(unit)
const transferAmount = depositAmount.div(10)
const timeoutMillSec = 200000

describeWithFrontier("Zk Rollup Integration Test", function (context) {
    let tester: Tester;
    let alice: Wallet;
    let bob: Wallet;
    let chuck: Wallet;
    let operatorBalance: BigNumber;

    before('create tester and test wallets', async function() {
        this.timeout(timeoutMillSec);
        tester = await Tester.init(operatorHost, 'HTTP');
		await createAndFinalizeBlock(context.web3);
        alice = await tester.fundedWallet('5.0');
        bob = await tester.emptyWallet();
        chuck = await tester.emptyWallet();
        operatorBalance = await tester.operatorBalance('ETH');
    })

    after('disconnect tester', async function () {
        await tester.disconnect();
    });

    step('should execute an auto-approved deposit', async function () {
        this.timeout(timeoutMillSec)
        await tester.testDeposit(alice, 'ETH', depositAmount, true);
    });

    step('should execute a normal deposit', async function () {
        this.timeout(timeoutMillSec)
        await tester.testDeposit(alice, 'ETH', depositAmount);
    });

    step('should change pubkey onchain', async function () {
        this.timeout(timeoutMillSec)
        await tester.testChangePubKey(alice, 'ETH', true);
    });

    step('should execute a transfer to new account', async function () {
        this.timeout(timeoutMillSec)
        await tester.testTransfer(alice, chuck, 'ETH', transferAmount);
    });

    step('should execute a transfer to existing account', async function () {
        this.timeout(timeoutMillSec)
        await tester.testTransfer(alice, chuck, 'ETH', transferAmount);
    });

    it('should execute a transfer to self', async function () {
        this.timeout(timeoutMillSec)
        await tester.testTransfer(alice, alice, 'ETH', transferAmount);
    });

    step('should change pubkey offchain', async function () {
        this.timeout(timeoutMillSec)
        await tester.testChangePubKey(chuck, 'ETH', false);
    });

    step('should test multi-transfers', async function () {
        this.timeout(timeoutMillSec)
        await tester.testBatch(alice, bob, 'ETH', transferAmount);
        await tester.testIgnoredBatch(alice, bob, 'ETH', transferAmount);
    });

    // step('should execute a withdrawal', async function (done) {
    //     this.timeout(timeoutMillSec)
    //     await tester.testVerifiedWithdraw(alice, 'ETH', transferAmount).catch(done);
    // });

    // step('should execute a ForcedExit', async function (done) {
    //     this.timeout(timeoutMillSec)
    //     await tester.testVerifiedForcedExit(alice, bob, 'ETH').catch(done);
    // });

    // it('should check collected fees', async function () {
    //     const collectedFee = (await tester.operatorBalance('ETH')).sub(operatorBalance);
    //     expect(collectedFee.eq(tester.runningFee), 'Fee collection failed').to.be.true;
    // });

    // it('should fail trying to send tx with wrong signature', async function () {
    //     await tester.testWrongSignature(alice, bob, 'ETH', TX_AMOUNT);
    // });
})
