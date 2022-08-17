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
}