const Test = artifacts.require("Test")

contract("Deploy & Test", accounts => {
    let test

    before( async () => {
        test = await Test.new()
    })

    describe('Double Test',
        it('Pass Vlue', async () => {
            const res = await test.double(2)

            assert.equal(res, 4)
        })
    )
})
