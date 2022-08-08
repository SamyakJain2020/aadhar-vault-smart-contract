COMPILE:
npx hardhat compile

---

## make sure to copy .env.example to .env

DEPLOY SMART CONTRACT:
npx hardhat run scripts/deploy.js --network maticmumbai

Verify Smart Contract:
npx hardhat verify --network maticmumbai 0x6FaDBBaebFB6c6BA7BCE340B251E85fCf390fA74 <- Put the address of the contract here after deployment

---

0x6FaDBBaebFB6c6BA7BCE340B251E85fCf390fA74 -----> Address of the Current smart Contract

you can directly run smart contract code on the browser by using the following link:
https://mumbai.polygonscan.com/address/0x6FaDBBaebFB6c6BA7BCE340B251E85fCf390fA74#code
