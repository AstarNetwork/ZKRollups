import Web3 from "web3";
import * as rlp from 'rlp'
import keccak from 'keccak'
import { JsonRpcResponse } from "web3-core-helpers";

export const PORT = 2000;
export const RPC_PORT = 3000;
export const WS_PORT = 4000;

export const DISPLAY_LOG = process.env.FRONTIER_LOG || false;
export const FRONTIER_LOG = process.env.FRONTIER_LOG || "info";

export const BINARY_PATH = `../target/debug/frontier-template-node`;
export const SPAWNING_TIME = 30000;
export const operatorAddress = "0x6be02d1d3665660d22ff9624b7be0551ee1ac91b"

require('dotenv').config()
export const genesisRoot = process.env.GENESIS_ROOT

export default class Utilities {
    address: string
    nonce: number

    constructor(address: string) {
        this.address = address
        this.nonce = 0x00
    }

    getContractAddress = (): string => {
        const contractAddress = this.calculateContractAddress()
        this.nonce++
        return contractAddress
    }

    private calculateContractAddress = (): string => {
        const encoded = rlp.encode([this.address, this.nonce])
        const contractHex = keccak('keccak256').update(encoded).digest('hex')
        return "0x" + contractHex.substring(24)
    }
}

export async function customRequest(web3: Web3, method: string, params: any[]) {
	return new Promise<JsonRpcResponse>((resolve, reject) => {
		(web3.currentProvider as any).send(
			{
				jsonrpc: "2.0",
				id: 1,
				method,
				params,
			},
			(error: Error | null, result?: JsonRpcResponse) => {
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

// Create a block and finalize it.
// It will include all previously executed transactions since the last finalized block.
export async function createAndFinalizeBlock(web3: Web3) {
	const response = await customRequest(web3, "engine_createBlock", [true, true, null]);
	if (!response.result) {
		throw new Error(`Unexpected result: ${JSON.stringify(response)}`);
	}
}

export function describeWithFrontier(title: string, cb: (context: { web3: Web3 }) => void, provider?: string) {
	describe(title, () => {
		let context: { web3: Web3 } = { web3: null };
		// Making sure the Frontier node has started
		before("Starting Frontier Test Node", async function () {
			this.timeout(SPAWNING_TIME);
			const web3 = new Web3(`http://substrate:${RPC_PORT}`)
			context.web3 = web3;
		});

		cb(context);
	});
}
