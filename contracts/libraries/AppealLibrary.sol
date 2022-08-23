//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library AppealLibrary{
    struct Appeal{
        string title;
        address owner;
        string description;
        uint256 amtWithdrawn;
        mapping(address=>uint256) donors;
        uint256 amtNeeded;
        uint256 numOfDonations;
        uint256 amtAsked;
        uint128 creationTime;
    }

    function _createAppeal(Appeal storage self,string calldata title,string calldata description,uint256 amtNeeded,address owner) internal returns (bool){
        self.title=title;
        self.owner=owner;
        self.description=description;
        self.amtNeeded=amtNeeded;
        self.amtAsked=amtNeeded;
        self.amtWithdrawn=0;
        self.numOfDonations=0;
        self.creationTime=uint128(block.timestamp);
        return true;
    }
}