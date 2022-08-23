//SPDX-License-Identifier: MIT

import "./libraries/AppealLibrary.sol";
import "./UserData.sol";
pragma solidity ^0.8.0;
contract AppealData is UserData{
    using AppealLibrary for AppealLibrary.Appeal;
    mapping(uint256=>AppealLibrary.Appeal) public allAppeals;
    uint256 totalAppeals=0;
    UserData user=new UserData();

    event newAppealRegistered(uint256 index,string title,string description,address owner);

    modifier _appealDoesNotExist(uint256 index){
        require(allAppeals[index].amtNeeded<=0,"This appeal already exists");
        _;
    }

    function addAppeal(string calldata title,string calldata description,uint256 amtNeeded) external _appealDoesNotExist(totalAppeals+1) returns (bool){
        totalAppeals++;
        allAppeals[totalAppeals]._createAppeal(title,description,amtNeeded,msg.sender);
        user.addOwnedAppeal(totalAppeals);
    }
}