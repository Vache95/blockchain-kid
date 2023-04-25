// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract CriptoKinds {
    //owner DAD
    address owner;

    constructor() {
        owner = msg.sender;
    }

    struct Kid {
        address payable  walletAddress;
        string firstName;
        string lastName;
        uint releaseTime;
        uint amount;
        bool canWithdraw;
    }

    Kid[] public kids;
    // add kind to contract
    function addKid(address payable  walletAddress,string memory firstName,string memory lastName,uint releaseTime,uint amount,bool canWithdraw) public{
        kids.push(Kid(
            walletAddress,
            firstName,
            lastName,
            releaseTime,
            amount,
            canWithdraw
        ));
    }
    function balanceOf() public view returns(uint){
        return address(this).balance;
    }
    //deposit funds to contract,specifically to a kid`s account
    // function deposit(address waletAddress) payable public {}
    function deposit(address waletAddress) payable public {

    }

    function addToKidsBalance(address walletAddress) private {
      for(uint i = 0; i < kids.length; i++) {
          if(kids[i].walletAddress == walletAddress) {
            kids[i].amount += msg.value;
          }
      }
    }
     
     function getIndex(address walletAddress) view private returns(uint){
         for(uint i= 0; i < kids.length; i++) {
             if (kids[i].walletAddress == walletAddress) {
                return i;
             }
         }
         return 999;
     }

    //kid checks if able to withdraw
    function availableToWithdraw(address walletAddress) public returns(bool) {
        uint i = getIndex(walletAddress);
        if(block.timestamp > kids[i].releaseTime){
            kids[i].canWithdraw = true;
            return true;
        }else {
            return false;
        }
    }

    //withdraw money
    function withdraw(address payable walletAddress) payable public {
        uint i = getIndex(walletAddress);
        // require(msg.sender == kids[i].walletAddress, "error");
        kids[i].walletAddress.transfer(kids[i].amount);
    }
}