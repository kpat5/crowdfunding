//SPDX-License-Identifier: MIT

import "./libraries/AppealLibrary.sol";
import "./UserData.sol";
pragma solidity ^0.8.0;
contract AppealData is UserData{
    using AppealLibrary for AppealLibrary.Appeal;
    mapping(uint256=>AppealLibrary.Appeal) public allAppeals;
    uint256 totalAppeals=0;
    using UserDataLibrary for UserDataLibrary.User;
    UserData user=new UserData();

    event newAppealRegistered(uint256 index,string title,string description,address owner);

    modifier _appealDoesNotExist(uint256 index){
        require(allAppeals[index].amtNeeded<=0,"This appeal already exists");
        _;
    }
    modifier _userIsRegistered()
    {
        require(!(allUsers[msg.sender].registrationTime==uint(0)),"This user does not exist");
        _;
    }

    function addAppeal(string calldata title,string calldata description,uint256 amtNeeded) external _appealDoesNotExist(totalAppeals+1) _userIsRegistered returns (bool){
        totalAppeals++;
        allAppeals[totalAppeals]._createAppeal(title,description,amtNeeded,payable(msg.sender));
        user.addOwnedAppeal(totalAppeals);
        return true;
    }

    function donate(uint256 appealNo) public payable _userIsRegistered returns (bool) {
        require(msg.value>0,"Please send some ether");
        require(msg.value<=allAppeals[appealNo].amtNeeded,"The amount sent exceeds the amount needed");
        allAppeals[appealNo].balance+=msg.value;
        if(allUsers[msg.sender].donated[appealNo]>0){
            user.addDonatedAppeal(appealNo,msg.value);
        }
        else user.addAmtDonated(appealNo,msg.value);
        allAppeals[appealNo].numOfDonations++; 
        allAppeals[appealNo].amtNeeded-=msg.value;
        return true;
    }
    function withdraw(uint256 appealNo) public payable _userIsRegistered returns (bool){
        require(msg.sender==allAppeals[appealNo].owner,"You cannot withdraw as you are not the owner");
        require(allAppeals[appealNo].balance>0,"You have already withdrawn ot no amount has been donated");
        allAppeals[appealNo].owner.transfer(allAppeals[appealNo].balance);
        user.addAmtWithdrawn(appealNo,allAppeals[appealNo].balance);
        allAppeals[appealNo].balance=0;
        return true;
    }
}