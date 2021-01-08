pragma solidity ^0.5.8;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract TestnetERC20Token is ERC20, ERC20Detailed {
    constructor() public ERC20Detailed('DAI', 'DAI', 18) {}

    function mint(address _to, uint256 _amount) public returns (bool) {
        _mint(_to, _amount);
        return true;
    }

    function hello() public view returns (string memory) {
        return 'hello';
    }
}
