const ethers = require('ethers');

const privKey = '0x4dc023426c7bbd647cc9789343ac495225ff11aff3463b85dac0f503b70a119d';
const addressTo = '0x17a4dC4aF1FAF9c3Db0515a170491c37eb0373Dc';
const providerURL = 'http://localhost:7545';
// Define Provider
let provider = new ethers.providers.JsonRpcProvider(providerURL);
// Create Wallet
let wallet = new ethers.Wallet(privKey, provider);

const send = async () => {
    console.log(
       `Attempting to send transaction from ${wallet.address} to ${addressTo}`
    );

    // Create Tx Object
    const tx = {
       to: '0xe1301f9Bc2EFf1ec709b144d72F3CFc578B85f9F',
       value: ethers.utils.parseEther('1'),
    };

    const createReceipt = await wallet.sendTransaction(tx);
    await createReceipt.wait();
    console.log(`Transaction successful with hash: ${createReceipt.hash}`);
};

send()
