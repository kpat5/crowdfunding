//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library UserDataLibrary{
    struct User{
        string name;
        address userAddress;
        uint128 registrationTime;
        uint256[] appealsOwned;
        mapping(uint256=>uint256) withdrawn;
        mapping(uint256=>uint256) donated;
        uint256 totDonated;
        uint256 totWithdrawn;
    }
    function _register(User storage self,string calldata _name,address _userAddress) internal returns (bool){
        self.name=_name;
        self.userAddress=_userAddress;
        self.registrationTime=uint128(block.timestamp);
        self.totDonated=0;
        self.totWithdrawn=0;
        return true;
    }
    function _alreadyRegistered(User storage self) internal view returns (bool){
        return self.registrationTime==uint(0);
    }
    function _isOwned(User storage self,uint256 index) internal view returns (bool){
        for(uint256 i=0;i<self.appealsOwned.length;i++)
        {
            if(self.appealsOwned[i]==index)return true;
        }
        return false;
    }
}