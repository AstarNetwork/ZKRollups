const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  networks: {
    development: {
     host: "127.0.0.1",
     port: 7545,
     network_id: "*",
    },
    substrate: {
      provider: () => new HDWalletProvider("0x99B3C12287537E38C90A9219D4CB074A89A16E9CDB20BF85728EBD97C343E342", `http://localhost:3000`),
      host: "127.0.0.1",
      port: 3000,
      network_id: "*",
      gas: 100000,
      gasPrice: 0x01
    }
  },
  mocha: {
    timeout: 100000
  },
  compilers: {
    solc: {
      version: "0.6.0"
    }
  }
}
