import { Tester } from './tester';
import { expect } from 'chai';
import { Wallet, types } from './zksync/index';
import { BigNumber } from 'ethers';

type TokenLike = types.TokenLike;

declare module './tester' {
    interface Tester {
        testDeposit(wallet: Wallet, token: TokenLike, amount: BigNumber, approve?: boolean): Promise<void>;
        testFullExit(wallet: Wallet, token: TokenLike, accountId?: number): Promise<[BigNumber, BigNumber]>;
    }
}

Tester.prototype.testDeposit = async function (wallet: Wallet, token: TokenLike, amount: BigNumber, approve?: boolean) {
    const balanceBefore = await wallet.getBalance(token);

    const depositHandle = await this.syncWallet.depositToSyncFromEthereum({
        depositTo: wallet.address(),
        token: token,
        amount,
        approveDepositAmountForERC20: approve
    });

    console.log('handled')
    const receipt = await depositHandle.awaitReceipt();
    expect(receipt.executed, 'Deposit was not executed').to.be.true;
    console.log('executed')
    console.log(receipt.executed)
    const balanceAfter = await wallet.getBalance(token);
    console.log(Number(balanceAfter), Number(amount))
    console.log(balanceAfter.sub(balanceBefore), amount)
    expect(
        balanceAfter.sub(balanceBefore).eq(amount),
        `Deposit balance mismatch. Expected ${amount}, actual ${balanceAfter.sub(balanceBefore)}`
    ).to.be.true;
};

Tester.prototype.testFullExit = async function (wallet: Wallet, token: TokenLike, accountId?: number) {
    const balanceBefore = await wallet.getBalance(token);
    const handle = await wallet.emergencyWithdraw({ token, accountId });
    let receipt = await handle.awaitReceipt();
    expect(receipt.executed, 'Full Exit was not executed').to.be.true;
    const balanceAfter = await wallet.getBalance(token);
    return [balanceBefore, balanceAfter];
};
