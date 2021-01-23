pragma solidity ^0.5.8;

contract Test {
    string public greet;

    function double(uint256 num) public view returns(uint256) {
        return num * 2;
    }

    function store(string memory text) public {
        greet = text;
    }
}
