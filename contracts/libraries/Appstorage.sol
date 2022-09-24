
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import { IERC20 } from "../interfaces/IERC20.sol";

struct Borrower{
    address borrower;
    uint amounttoborrow;
    uint amountin;
    bool deposited;
    bool gottenfreecoin;
}

struct libstorage{
    ///////////////////////////////////////FREE TOKENS STATE///////////////////////////////// 

    ////////////////////////////////////////////LENDING STATE/////////////////////////////////////////
    mapping(address => Borrower) borrowerdetails;
    address owner;
    IERC20 tokenaddress;


}
library Appstorage{
    function appStorage() internal pure returns(libstorage storage s) {    
        assembly { s.slot := 0 }
    }
}

