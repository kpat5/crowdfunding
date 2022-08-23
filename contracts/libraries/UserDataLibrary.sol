//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library UserDataLibrary{
    struct User{
        string name;
        address userAddress;
        uint128 registrationTime;
        uint256[] appealsOwned;
        uint256[] amountWithdrawn;
        mapping(uint256=>uint256) donated;
    }
    function _register(User storage self,string calldata _name,address _userAddress) internal returns (bool){
        self.name=_name;
        self.userAddress=_userAddress;
        self.registrationTime=uint128(block.timestamp);
        return true;
    }
    function _alreadyRegistered(User storage self) internal view returns (bool){
        return self.registrationTime==uint(0);
    }
}