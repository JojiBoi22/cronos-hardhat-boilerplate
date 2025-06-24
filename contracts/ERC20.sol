// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

    contract MyToken is ERC20, ERC20Permit, Ownable, AccessControl
{
    bytes32 public constant CONTROLLER_ROLE = keccak256("CONTROLLER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    
    constructor(
        string memory name
        
    ) ERC20("MyToken", "MTK") ERC20Permit(name) Ownable(_msgSender()){
        // Default initial supply of 1 million tokens (with 18 decimals)
        uint256 initialSupply = 1_000_000 * (10 ** 18);

        // The initial supply is minted to the deployer's address
        _mint(_msgSender(), initialSupply);

        // The deployer is granted the default admin role and the controller role
        _grantRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _grantRole(CONTROLLER_ROLE, _msgSender());
        _grantRole(MINTER_ROLE, _msgSender());
    }

    function getControllerRole() public view virtual returns (bytes32) {
        return CONTROLLER_ROLE;
    }

    function getMinterRole() public view virtual returns (bytes32) {
        return MINTER_ROLE;
    }

    function mint(address to, uint256 amount) public onlyRole((MINTER_ROLE)) {
        _mint(to, amount);
    }

    function pause() public onlyRole(CONTROLLER_ROLE) {
        pause();
    }

    function unpause() public onlyRole(CONTROLLER_ROLE) {
        unpause();
    }

    /**
     * @dev Internal functions
     */

    function _update(
        address from,
        address to,
        uint256 value
    ) internal override(ERC20) {
        super._update(from, to, value);
    }
}
