import { HardhatUserConfig } from "hardhat/config";
import * as dotenv from "dotenv";
import "@nomicfoundation/hardhat-toolbox";

dotenv.config();

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  networks: {
    yuma: {
      url: process.env.YUMA_URL!,
      accounts: [process.env.WALLET_PRIVATE_KEY!],
      gasPrice: "auto"
    },
    polygonMumbai: {
      url: process.env.MUMBAI_URL!,
      accounts: [process.env.WALLET_PRIVATE_KEY!],
      gasPrice: "auto"
    },
  },
};

export default config;
