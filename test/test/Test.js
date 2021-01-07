const Test = artifacts.require("Test")

contract("Deploy & Test", accounts => {
    let test

    before(async () => {
        test = await Test.new()
    })

    describe("Double Test",
        it('Double Test', async () => {
            const num = await test.double(2)

            assert.equal(num, 2 * 2)
        })
    )
})
