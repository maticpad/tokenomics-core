// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IVest {
    function initiateVest(
        address owner,
        uint256 amount,
        uint256 initial,
        uint256 cliff,
        uint256 releaseTime,
        uint256 numberOfReleases
    ) external returns (bytes32);
}

interface Manager {
    function withdraw(uint8 _index, uint256 amount) external;
}

contract FactionManager is Context, Ownable {
    IERC20 private t;
    IVest private v;
    Manager private m;
    string public factionName;
    uint256 initial;
    uint256 cliff;
    uint256 releaseTime;
    uint256 numberOfReleases;

    constructor(
        string memory factionName_,
        IVest v_,
        Manager m_,
        IERC20 t_,
        uint256 initial_,
        uint256 cliff_,
        uint256 releaseTime_,
        uint256 numberOfReleases_
    ) {
        factionName = factionName_;
        v = v_;
        m = m_;
        t = t_;
        initial = initial_;
        cliff = cliff_;
        releaseTime = releaseTime_;
        numberOfReleases = numberOfReleases_;
        t.approve(address(v), 6e26);
    }

    function vest(address user, uint256 amount) public virtual onlyOwner {
        v.initiateVest(user, amount, initial, cliff, releaseTime, numberOfReleases);
    }

    function withdraw(uint8 index, uint256 amount) public virtual onlyOwner {
        m.withdraw(index, amount);
    }
}
