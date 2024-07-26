# Candle Auction Smart Contract

This project contains a simple implementation of a Candle Auction smart contract in Solidity. The contract allows users to start an auction, place bids, and end the auction with a random end time. This README file provides instructions on how to test this smart contract using the Remix IDE.

Reason to choose Remix IDE is solely due to availability of unlimited Test Eth.
If you have enough Sepolia Testnet Eth, I have already deployed and verified the smart contract at [here](https://sepolia.etherscan.io/address/0x182422ef05F497140A128D3958633bd7fe9382D8).

## Instructions
 ### 1. Open Remix IDE
 1. Open your web browser and navigate to [Remix IDE](https://remix.ethereum.org).
 2. Create a new file named CandleAuction.sol in the contracts directory and paste the code available in the repository

 ### 2. Compile the Contract
 1. In Remix, navigate to the "Solidity Compiler" tab on the left sidebar.
 2. Select the appropriate compiler version (e.g., 0.8.0).
 3. Click the "Compile CandleAuction.sol" button.

 ### 3. Deploy the Contract
 1. Navigate to the "Deploy & Run Transactions" tab on the left sidebar.
 2. Click the "Deploy" button to deploy the contract.

 ### 4. Interact with the Contract
    After deploying the contract, you can interact with it using the provided functions:
 1. Start Auction: Call the startAuction function with the desired bidding time (in seconds).
 2. Place Bid: Use the bid function to place a bid. Ensure you send some Ether with the transaction.
 3. Withdraw: If you are not the highest bidder, you can withdraw your bid using the withdraw function.
 4. End Auction: After the auction end time, call the auctionEnd function to finalize the auction and transfer the highest bid to the auctioneer.

 ### Example Steps
 1. Start the Auction:
  
  
 2. Place Bids:
  Enter the amount of Ether (in Wei) you want to bid and click the "bid" button.
  
 3. Withdraw:
  If your bid is outbid, you can withdraw your Ether by calling the "withdraw" function.
  
 4. End the Auction:
  After the bidding time has passed, click the "auctionEnd" button to end the auction and transfer the highest bid to the auctioneer.