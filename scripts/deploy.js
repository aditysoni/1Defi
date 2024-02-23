// deploy.js

async function main() {
  const VaultFactory = await ethers.getContractFactory("VaultFactory");
  const vaultFactory = await VaultFactory.deploy();

  await vaultFactory.deployed();

  console.log("VaultFactory deployed to:", vaultFactory.address);
}

main().then(() => process.exit(0)).catch((error) => {
  console.error(error);
  process.exit(1);
});


