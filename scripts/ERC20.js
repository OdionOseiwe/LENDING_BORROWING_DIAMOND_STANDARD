const hre = require("hardhat");

async function main() {

  const ERC20 = await hre.ethers.getContractFactory("ERC20");
  const eRC20 = await ERC20.deploy("FREECOINS", "FC");


  await eRC20.deployed();

  console.log("koko is address", eRC20.address);
}


// DiamondCutFacet deployed: 0x5958f260e487808a7FF903828ebf66799c7B34a6
// Diamond deployed: 0x9ea40c054B337A7Aae4E4205aDda8498C9a7BAd5
// DiamondInit deployed: 0x475d65B469A16ccd380f1B3bF1575c65386552D5

// Deploying facets
// DiamondLoupeFacet deployed: 0xcDF1b21DA285CA1Bf28aA175469ffe6a4796b79e
// OwnershipFacet deployed: 0xB62BDd40a5Bb6F5B73Bc4F1F2f6D12CE5511f03E
// Lending_Borrowing deployed: 0xF99a37b789113F29C62bA2acd5D978359f6a8189


// ERC20 address : 0x5FbDB2315678afecb367f032d93F642f64180aa3

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});