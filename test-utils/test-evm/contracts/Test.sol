pragma solidity 0.6.0;

contract Test {
    mapping (uint256 => uint256) public uintStorage;

    function double(uint256 num) public view returns(uint256) {
        return num * 2;
    }
}
