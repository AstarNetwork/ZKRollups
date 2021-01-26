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

describeWithFrontier("Zk Rollup Integration Test", function (context) {
    let tester: Tester;
    let alice: Wallet;
    let bob: Wallet;
    let chuck: Wallet;
    let operatorBalance: BigNumber;

    before('create tester and test wallets', async function() {
        this.timeout(200000);
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
        this.timeout(30000);
        await tester.testDeposit(alice, 'ETH', depositAmount, true);
    });

    step('should execute a normal deposit', async function () {
        this.timeout(30000);
        await tester.testDeposit(alice, 'ETH', depositAmount);
    });

    step('should change pubkey onchain', async function () {
        this.timeout(30000);
        await tester.testChangePubKey(alice, 'ETH', true);
    });

    // step('should execute a transfer to new account', async function () {
    //     await tester.testTransfer(alice, chuck, 'ETH', TX_AMOUNT);
    // });

    // step('should execute a transfer to existing account', async function () {
    //     await tester.testTransfer(alice, chuck, 'ETH', TX_AMOUNT);
    // });

    // it('should execute a transfer to self', async function () {
    //     await tester.testTransfer(alice, alice, 'ETH', TX_AMOUNT);
    // });

    // step('should change pubkey offchain', async function () {
    //     await tester.testChangePubKey(chuck, 'ETH', false);
    // });

    // step('should test multi-transfers', async function () {
    //     await tester.testBatch(alice, bob, 'ETH', TX_AMOUNT);
    //     await tester.testIgnoredBatch(alice, bob, 'ETH', TX_AMOUNT);
    //     // TODO: With subsidized costs, this test fails on CI due to low gas prices and high allowance. (ZKS-138)
    //     // await tester.testFailedBatch(alice, bob, token, TX_AMOUNT);
    // });

    // step('should execute a withdrawal', async (done) => {
    //     await tester.testVerifiedWithdraw(alice, 'ETH', TX_AMOUNT).catch(done);
    // });

    // step('should execute a ForcedExit', async (done) => {
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
