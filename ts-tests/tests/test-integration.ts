import { expect } from 'chai';
import { step } from "mocha-steps";
import { describeWithFrontier, createAndFinalizeBlock } from './util'

import { BigNumber, utils } from 'ethers';
import { Wallet, types } from './zksync/index';
import { Tester } from './tester';
import './priority-ops';
import './change-pub-key';
import './transfer';
import './withdraw';
import './forced-exit';
import './misc';

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
        this.timeout(200000);
        tester = await Tester.init('operator', 'HTTP');
		await createAndFinalizeBlock(context.web3);
        alice = await tester.fundedWallet('5.0');
        bob = await tester.emptyWallet();
        chuck = await tester.emptyWallet();
        operatorBalance = await tester.operatorBalance('ETH');
    })

    after('disconnect tester', async () => {
        await tester.disconnect();
    });

    step('should execute an auto-approved deposit', async () => {
        await tester.testDeposit(alice, 'ETH', DEPOSIT_AMOUNT, true);
    });

    step('should execute a normal deposit', async () => {
        await tester.testDeposit(alice, 'ETH', DEPOSIT_AMOUNT);
    });

    step('should change pubkey onchain', async () => {
        await tester.testChangePubKey(alice, 'ETH', true);
    });

    step('should execute a transfer to new account', async () => {
        await tester.testTransfer(alice, chuck, 'ETH', TX_AMOUNT);
    });

    step('should execute a transfer to existing account', async () => {
        await tester.testTransfer(alice, chuck, 'ETH', TX_AMOUNT);
    });

    it('should execute a transfer to self', async () => {
        await tester.testTransfer(alice, alice, 'ETH', TX_AMOUNT);
    });

    step('should change pubkey offchain', async () => {
        await tester.testChangePubKey(chuck, 'ETH', false);
    });

    step('should test multi-transfers', async () => {
        await tester.testBatch(alice, bob, 'ETH', TX_AMOUNT);
        await tester.testIgnoredBatch(alice, bob, 'ETH', TX_AMOUNT);
        // TODO: With subsidized costs, this test fails on CI due to low gas prices and high allowance. (ZKS-138)
        // await tester.testFailedBatch(alice, bob, token, TX_AMOUNT);
    });

    step('should execute a withdrawal', async (done) => {
        await tester.testVerifiedWithdraw(alice, 'ETH', TX_AMOUNT).catch(done);
    });

    step('should execute a ForcedExit', async (done) => {
        await tester.testVerifiedForcedExit(alice, bob, 'ETH').catch(done);
    });

    it('should check collected fees', async () => {
        const collectedFee = (await tester.operatorBalance('ETH')).sub(operatorBalance);
        expect(collectedFee.eq(tester.runningFee), 'Fee collection failed').to.be.true;
    });

    it('should fail trying to send tx with wrong signature', async () => {
        await tester.testWrongSignature(alice, bob, 'ETH', TX_AMOUNT);
    });
})
