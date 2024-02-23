// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
pragma abicoder v2;

contract VaultFactory {
    address[] public vaults;

    mapping(address => address) public vaultToManager;

    struct Vault {
        uint256 activationPeriod;
        uint256 managerFee;
        uint256 managerBonus;
    }

    // Event to emit when a new vault is created
    event VaultCreated(address indexed manager, address vault , uint256 _managerBonus , uint256 _managerFee) ;

    function createVault(
        uint256 activationPeriod,
        uint256 managerFee,
        address[] memory tokens,
        uint256 managerBonus
    ) public {
        // Create a new Vault instance
        Vault memory newVault = Vault({
            activationPeriod: activationPeriod,
            managerFee: managerFee,
            managerBonus: managerBonus
        });

        // Deploy a new Vault contract and get its address
        address newVaultAddress = address(new VaultContract(newVault));

        // Store the relationship between the manager and the vault
        vaultToManager[newVaultAddress] = msg.sender;

        // Store the new vault address
        vaults.push(newVaultAddress);

        // Emit an event to signal the creation of a new vault
        emit VaultCreated(msg.sender, newVaultAddress , managerFee , managerBonus );
    }
}

// Example VaultContract to illustrate the concept
contract VaultContract {

    VaultFactory.Vault public vaultDetails ;
    constructor(VaultFactory.Vault memory _vaultDetails) {
        vaultDetails = _vaultDetails;
    }
}
