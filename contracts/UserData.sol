//SPDX-License-Identifier: MIT

import "./libraries/UserDataLibrary.sol";
pragma solidity ^0.8.0;

contract UserData{
    using UserDataLibrary for UserDataLibrary.User;
    mapping(address=>UserDataLibrary.User) public allUsers;

    event newUserRegistered(string,address);

    modifier alreadyRegistered(){
        require(allUsers[msg.sender]._alreadyRegistered(),"already registered");
        _;
    }

    modifier appealIsOwned(uint256 index){
        require(allUsers[msg.sender]._isOwned(index),"This user does not own this appeal");
        _;
    }

    function addUser(string calldata name) external alreadyRegistered() returns (bool){
        allUsers[msg.sender]._register(name,msg.sender);
        emit newUserRegistered(name,msg.sender);
        return true;
    }

    function addOwnedAppeal(uint256 index) external alreadyRegistered() returns (bool){
        allUsers[msg.sender].appealsOwned.push(index);
        return true;
    }

    function addDonatedAppeal(uint256 index,uint256 amount) external alreadyRegistered() returns (bool){
        allUsers[msg.sender].donated[index]=amount;
        return true;
    }

    function addAmtWithdrawn(uint256 index,uint256 amount) external alreadyRegistered() appealIsOwned(index) returns (bool)
    {
        allUsers[msg.sender].withdrawn[index]+=amount;
        allUsers[msg.sender].totWithdrawn+=amount;
        return true;
    }

    function addAmtDonated(uint256 index,uint256 amount) external alreadyRegistered() returns (bool)
    {
        allUsers[msg.sender].donated[index]+=amount;
        allUsers[msg.sender].totDonated+=amount;
        return true;
    }
}