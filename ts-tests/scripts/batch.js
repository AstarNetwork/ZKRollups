const Web3 = require('web3')
const web3 = new Web3(`http://substrate:5000`)

const startBatch = async () => {
    let i = 0
    console.log("start mining block...")
    while(true) {
        i++
        await sleep()
        await customRequest()
        console.log("successful for commit block⛏️")
    }
}

const sleep = () => new Promise(resolve => setTimeout(() => resolve(1), 3000))

async function customRequest() {
	return new Promise((resolve, reject) => {
		web3.currentProvider.send(
			{
				jsonrpc: "2.0",
				id: 1,
				method: "engine_createBlock",
				params: [true, true, null],
			},
			(error, result) => {
				if (error) {
					reject(
						`Failed to send custom request (${method} (${params.join(",")})): ${
							error.message || error.toString()
						}`
					);
				}
				resolve(result);
			}
		);
	});
}

startBatch()
