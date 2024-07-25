// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CandleAuction {
    struct Auction {
        address payable owner;
        uint256 auctionStartTime;
        uint256 auctionEndTime;
        uint256 randomEndTime;
        uint256 highestBid;
        address highestBidder;
        bool ended;
    }

    Auction public currentAuction;
    bool public auctionActive;
    
    mapping(address => uint256) public pendingReturns;

    event AuctionStarted(address owner, uint256 endTime);
    event HighestBidIncreased(address bidder, uint256 amount);
    event AuctionEnded(address winner, uint256 amount);

    modifier onlyAuctionOwner() {
        require(msg.sender == currentAuction.owner, "You are not the auction owner");
        _;
    }

    modifier auctionOngoing() {
        require(auctionActive, "No active auction");
        _;
    }

    function startAuction(uint256 _biddingTime) public {
        require(!auctionActive, "An auction is already active");

        uint256 startTime = block.timestamp;
        uint256 endTime = startTime + _biddingTime;
        uint256 randomTime = endTime - (uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % _biddingTime);

        currentAuction = Auction({
            owner: payable(msg.sender),
            auctionStartTime: startTime,
            auctionEndTime: endTime,
            randomEndTime: randomTime,
            highestBid: 0,
            highestBidder: address(0),
            ended: false
        });

        auctionActive = true;
        emit AuctionStarted(msg.sender, endTime);
    }

    function bid() public payable auctionOngoing {
        require(block.timestamp <= currentAuction.auctionEndTime, "Auction already ended.");
        require(block.timestamp <= currentAuction.randomEndTime, "Auction ended unpredictably.");
        require(msg.value > currentAuction.highestBid, "There already is a higher or equal bid.");

        if (currentAuction.highestBid != 0) {
            pendingReturns[currentAuction.highestBidder] += currentAuction.highestBid;
        }

        currentAuction.highestBidder = msg.sender;
        currentAuction.highestBid = msg.value;
        emit HighestBidIncreased(msg.sender, msg.value);
    }

    function withdraw() public returns (bool) {
        uint256 amount = pendingReturns[msg.sender];
        if (amount > 0) {
            pendingReturns[msg.sender] = 0;
            if (!payable(msg.sender).send(amount)) {
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }

    function auctionEnd() public auctionOngoing onlyAuctionOwner {
        require(block.timestamp >= currentAuction.randomEndTime || block.timestamp >= currentAuction.auctionEndTime, "Auction not yet ended.");
        require(!currentAuction.ended, "auctionEnd has already been called.");

        currentAuction.ended = true;
        auctionActive = false;
        emit AuctionEnded(currentAuction.highestBidder, currentAuction.highestBid);

        currentAuction.owner.transfer(currentAuction.highestBid);
    }

    function getRandomEndTime() public view onlyAuctionOwner returns (uint256) {
        return currentAuction.randomEndTime;
    }
}
