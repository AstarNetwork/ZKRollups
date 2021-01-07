pragma solidity ^0.5.0;

contract TokenDeployInit {
    function getTokens() internal pure returns (address[] memory) {
        address[] memory tokens = new address[](4);
        tokens[0] = 0x5E6D086F5eC079ADFF4FB3774CDf3e8D6a34F7E9;
        tokens[1] = 0x3fad2B2E21eA1c96618Cc76a42Fb5a77c3f71c6F;
        tokens[2] = 0x2c7E84980191210883d2dF3167A3AB6A2cc15E01;
        tokens[3] = 0x5C55e2cf0a4243b9C7676e0aD8687C308959A153;
        return tokens;
    }
}
