//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library UserDataLibrary{
    struct User{
        string name;
        address userAddress;
        uint128 registrationTime;
        uint64 appealCount;
        uint256[] appealsOwned;
        uint256[] appealsDonated;
        uint256 amountWithdrawn;
        uint256 amountDonated;
    }
    function _register(User storage self,string calldata _name,address _userAddress) internal returns (bool){
        self.name=_name;
        self.userAddress=_userAddress;
        self.registrationTime=uint128(block.timestamp);
        self.appealCount=0;
        self.amountDonated=0;
        self.amountWithdrawn=0;
        return true;
    }
    function _alreadyRegistered(User storage self) internal returns (bool){
        return self.registrationTime==uint(0);
    }
}