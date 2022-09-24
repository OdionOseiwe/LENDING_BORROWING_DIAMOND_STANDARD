// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @dev lending and borrowing contract that lends to users but theusers are overcollaterised and the users put in ether
/// @dev and the contract lends stable coins (which they own) and a caculation is done to give stable coin 
/// @dev to the user
//_____________________________________________________________________________________________________________
                                                
                                                /// FREE LENDING      
//_____________________________________________________________________________________________________________
import {libstorage} from "../libraries/Appstorage.sol";
import { IERC20 } from "../interfaces/IERC20.sol";

contract Lending_Borrowing{ 
    libstorage internal s;

    event DepositEther(address borrower, uint depositedamount);

    function depositEther() payable external{
        require(s.borrowerdetails[msg.sender].deposited == false, "return outstanding tokens");
        uint realamount = checkOutputs(msg.value);
        require(msg.value >= 1 ether, "desposit enough for this transaction");
        s.borrowerdetails[msg.sender].amountin = msg.value;
        s.borrowerdetails[msg.sender].borrower = msg.sender;
        s.borrowerdetails[msg.sender].amounttoborrow = realamount;
        s.borrowerdetails[msg.sender].deposited = true;
    }

    function getFREECOINS() external{
        require(s.borrowerdetails[msg.sender].gottenfreecoin == false, "has gootten for this transaction"); 
        uint amount= s.borrowerdetails[msg.sender].amounttoborrow;
        bool sent = s.tokenaddress.transfer(msg.sender, amount);
        require(sent , "failed");
        s.borrowerdetails[msg.sender].gottenfreecoin == true;
    }

    /// @dev if a user needs __amountin he uses this function to calculate the amount he will pay for the loan
    /// @param __amountin is amount you have to get a FREECOIN
    /// @return  amount__  amount to get for inputing __amountin
    function checkOutputs(uint __amountin) public  pure returns(uint amount__){
       uint dollar = (__amountin * 1500) / 10**18;
       uint percentage = (dollar * 10) / 100;
       amount__ = dollar - percentage;
    }

    function Return(uint tokens) external {
        bool returned = s.borrowerdetails[msg.sender].deposited;
        require(returned == true , "has returned");
        require(s.borrowerdetails[msg.sender].amounttoborrow == tokens, "return all tokens please");
        bool sent = s.tokenaddress.transferFrom(msg.sender, address(this),tokens);
        require(sent , "failed");
        (bool send,) = payable(msg.sender).call{value:s.borrowerdetails[msg.sender].amountin}("");
        require(send, "failed");
        s.borrowerdetails[msg.sender].deposited = false;
        s.borrowerdetails[msg.sender].gottenfreecoin == false;
    }

    function checkuserbalance() external view returns(uint){
        return s.borrowerdetails[msg.sender].amountin;
    }

    receive() payable external{
        (bool sent,) = payable(msg.sender).call{value:msg.value}("");
        require(sent, "failed");
    }
}