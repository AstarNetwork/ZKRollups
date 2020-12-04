import Web3 from 'web3'
import web3 from './web3'
import { port, rpcPort, wsPort, specFile, target } from './config'
import { spawn, ChildProcess } from 'child_process'

const describeWithSubstrate = (title: string, test: (web3: Web3) => void) => {
	describe(title, () => {
		let command: ChildProcess

		beforeEach(async () => {command = buildChain()})
		afterAll(() => command.kill())
		test(web3)
	})
}

const buildChain = () => {
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
    const command = spawn(target, args)
    command.on("error", e => {throw e})
    return command
}

export default describeWithSubstrate
