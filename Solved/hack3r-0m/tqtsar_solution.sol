pragma solidity 0.8.4;

import "./BitMania.sol";

contract hack3r0mAttacker {
    
    constructor(BitMania instance) payable {
        
        instance.solveIt("SHERLOCK_CTF_0x0_WINNER_333");

    }

    receive() external payable { }

}
