import Web3 from 'web3'
import web3 from './web3'
import { port, rpcPort, wsPort, specFile, target } from './config'
import { spawn, ChildProcess } from 'child_process'

const describeWithSubstrate = (title: string, test: (web3: Web3) => void) => {
	describe(title, () => {
		let command: ChildProcess

		beforeEach(async () => command = await buildChain())
		afterAll(async () => await command.kill())
		test(web3)
	})
}

const buildChain = async () => {
    const args = [
        `--chain=${specFile}`,
		`--validator`,
		`--execution=Native`,
		`--no-telemetry`,
		`--no-prometheus`,
		`--sealing=Manual`,
		`--no-grandpa`,
		`--force-authoring`,
		`--port=${port}`,
		`--rpc-port=${rpcPort}`,
		`--ws-port=${wsPort}`,
		`--tmp`,
	]
    return await initCommand(args)
}

const initCommand = async (args: string[]): Promise<ChildProcess> => {
	const command = spawn(target, args)
	command.on("error", e => {throw e})
	await new Promise(resolve => {
		const onData = async (chunk: any) => {
			if (chunk.toString().match(/Manual Seal Ready/))
				resolve(null)
		};
		command.stderr.on("data", onData);
		command.stdout.on("data", onData);
	});
	return command
}

export default describeWithSubstrate
export { sendTx } from './web3'
