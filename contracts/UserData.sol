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

    function addUser(string calldata name) external alreadyRegistered() returns (bool){
        allUsers[msg.sender]._register(name,msg.sender);
        emit newUserRegistered(name,msg.sender);
        return true;
    }

    function addOwnedAppeal(uint256 index) external alreadyRegistered() returns (bool){
        allUsers[msg.sender].appealsOwned.push(index);
        return true;
    }

    function addDonatedAppeal(uint256 index) external alreadyRegistered() returns (bool){
        allUsers[msg.sender].appealsDonated.push(index);
        return true;
    }

    function addAmtWithdrawn(uint256 amount) external alreadyRegistered() returns (bool)
    {
        allUsers[msg.sender].amountWithdrawn+=amount;
        
        return true;
    }

    function addAmtDonated(uint256 amount) external alreadyRegistered() returns (bool)
    {
        allUsers[msg.sender].amountDonated+=amount;
        return true;
    }
}