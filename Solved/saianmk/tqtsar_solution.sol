pragma solidity 0.8.4;

import "./Combination.sol";

contract saianmkAttacker {
    
    constructor(Combination instance) payable {
        instance.dial(7, true);
        instance.dial(7, false);
        instance.dial(1, true);
        instance.unlock(0x4b);
    }

    receive() external payable { }

}