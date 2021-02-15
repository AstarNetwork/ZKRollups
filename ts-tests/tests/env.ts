type Network = 'localhost' | 'rinkeby' | 'ropsten' | 'operator';

export const mainchainHost = process.env.MAINCHAIN_HOST
export const operatorHost = process.env.OPERATOR_HOST as Network
