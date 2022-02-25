// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

interface ISetup {
    event Deployed(address instance);

    function isSolved() external view returns (bool);
}
