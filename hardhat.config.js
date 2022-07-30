require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require("@openzeppelin/hardhat-upgrades");
require('dotenv').config();



module.exports = {
  solidity: {
    version: "0.8.9",
    settings: {
      optimizer: {enabled: process.env.DEBUG ? false : true},
    }
  },
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      // blockGasLimit: 518379120000 // whatever you want here
    }, 
    maticmumbai: {
      url: process.env.POLYGON_ALCHEMY,
      accounts: [process.env.PRIVATE_KEY_1, process.env.PRIVATE_KEY_2, process.env.PRIVATE_KEY_3],
      // blockGasLimit: 518379120000 // whatever you want here

    }
  },
  // etherscan: {
  //   // Your API key for Etherscan - rinkeby
  //   // Obtain one at https://etherscan.io/
  //   apiKey: "HBMB8ER9AI26GMHR2IAGYK6KS3AX3FA6J1"
  // }
  etherscan: {
    // Your API key for Etherscan - matic
    // Obtain one at https://etherscan.io/
    apiKey: process.env.POLYGONSCAN_API
  }
  
};