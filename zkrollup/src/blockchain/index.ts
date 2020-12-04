import { port, rpcPort, wsPort, specFile, target } from './config'
import { spawn } from 'child_process'

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

buildChain()
