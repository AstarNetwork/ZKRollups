import { expect, assert } from 'chai';
import { step } from "mocha-steps";
import { describeWithFrontier, createAndFinalizeBlock } from './util'
import { operatorHost } from './env';

import { BigNumber, utils } from 'ethers';
import { Wallet } from './zksync';
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
        alice = await tester.fundedWallet();
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

    it('should fail trying to send tx with wrong signature', async function () {
        this.timeout(timeoutMillSec)
        await tester.testWrongSignature(alice, bob, 'ETH', transferAmount);
    });

    it('should check collected fees', async function () {
        this.timeout(timeoutMillSec)
        const collectedFee = (await tester.operatorBalance('ETH')).sub(operatorBalance);
        expect(collectedFee.eq(tester.runningFee), 'Fee collection failed').to.be.true;
    });

    describe('Full Exit tests', function () {
        let carl: Wallet;

        before('create a test wallet', async function () {
            this.timeout(timeoutMillSec)
            carl = await tester.fundedWallet();
        });

        step('should execute full-exit on random wallet', async function () {
            this.timeout(timeoutMillSec)
            await tester.testFullExit(carl, 'ETH', 145);
        });

        step('should execute a normal deposit', async function () {
            this.timeout(timeoutMillSec)
            // make a deposit so that wallet is assigned an accountId
            await tester.testDeposit(carl, 'ETH', transferAmount, true);
        });

        step('should fail full-exit with wrong eth-signer', async function () {
            this.timeout(timeoutMillSec)
            const oldSigner = carl.ethSigner;
            carl.ethSigner = tester.ethWallet;
            try {
                await tester.testFullExit(carl, 'ETH')
                assert.fail("wrong transaction should't be sent")
            } catch(_) {
                assert.isOk(true)
            }
            carl.ethSigner = oldSigner;
        });

        step('should execute a normal full-exit', async function () {
            this.timeout(timeoutMillSec)
            const [before, after] = await tester.testFullExit(carl, 'ETH');
            expect(before.eq(0), "Balance before Full Exit must be non-zero").to.be.false;
            expect(after.eq(0), "Balance after Full Exit must be zero").to.be.true;
        });

        step('should execute full-exit on an empty wallet', async function () {
            this.timeout(timeoutMillSec)
            const [before, after] = await tester.testFullExit(carl, 'ETH');
            expect(before.eq(0), "Balance before Full Exit must be zero (we've already withdrawn all the funds)").to.be.true;
            expect(after.eq(0), "Balance after Full Exit must be zero").to.be.true;
        });
    });
})
