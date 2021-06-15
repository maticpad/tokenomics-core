// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenManager is Context, Ownable {
    using SafeMath for uint256;

    IERC20 private _token;

    struct Faction {
        string name;
        address owner;
        uint256 supply;
    }

    constructor(IERC20 token) {
        _token = token;
    }

    uint8 index;
    mapping(uint8 => Faction) private _factions;

    function setFaction(
        string memory name,
        address owner,
        uint256 supply
    ) public virtual onlyOwner {
        _initiateFaction(name, owner, supply);
    }

    function _initiateFaction(
        string memory name,
        address owner,
        uint256 supply
    ) internal virtual {
        _factions[index] = Faction(name, owner, supply);
        index++;
    }

    function getFaction(uint8 _index)
        public
        view
        virtual
        returns (Faction memory)
    {
        return _factions[_index];
    }

    function withdraw(uint8 _index, uint256 amount) public virtual {
        require(_msgSender() == _factions[_index].owner, "Unknown Sender");
        _factions[_index].supply = _factions[_index].supply.sub(amount);
        _token.transfer(_msgSender(), amount);
    }
}
