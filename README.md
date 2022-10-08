# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
GAS_REPORT=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```
# Testing

Open the contracts in Remix IDE and deploy the "AppealData.sol" contract. 
First register the account using the addUser function then you can add appeals (An appeal is a need for money which registered users can create to ask for funding. It has a title and a description along with the amount that is needed)

All appeals and users are stored. 
Who has the user donated to and how much was donated is also stored along with the amount withdrawn by the owner.
