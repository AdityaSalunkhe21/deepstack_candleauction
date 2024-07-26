const hre = require("hardhat");
async function main() {
    const CandleAuction = await ethers.getContractFactory("CandleAuction");
    const candleAuction = await CandleAuction.deploy();
    await candleAuction.waitForDeployment();
    console.log("CandleAuction deployed to:",await candleAuction.getAddress());
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });