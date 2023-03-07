const { ethers } = require("hardhat");

async function main() {
    const LoveFaucet = await ethers.getContractFactory("LoveFaucet");

    const myLoveFaucet = await LoveFaucet.deploy();
    console.log("Deploying LoveFaucet:");

    await myLoveFaucet.deployed();
    console.log("LoveFaucet deployed to:", myLoveFaucet.address);

    console.log("hardhat verify --network Yuma", myLoveFaucet.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
    
// RUN : yarn hardhat run .\scripts\deploy.js --network Yuma
