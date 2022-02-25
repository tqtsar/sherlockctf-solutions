pragma solidity 0.8.4;

import "./Padlock.sol";

contract BowTiedPickleAttacker {
    
    constructor(Padlock instance) payable {
        require(msg.value == 33 wei);
        
        instance.pick1(unicode"‮6167209‬");
        instance.pick2{value: 33 wei}();
        instance.pick3(0x69420000000000000000000000000000);

        instance.open();

    }

    receive() external payable { }

}
