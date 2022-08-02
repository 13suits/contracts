// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.7.0) (finance/PaymentSplitter.sol)

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/finance/PaymentSplitter.sol";
import "https://github.com/transmissions11/solmate/blob/main/src/tokens/ERC721.sol";

contract PAYMENTS is PaymentSplitter {
    
    address[] public ProductOwner = [0x98dfa9Bb43E698A8559C0e2Cde23EdfCA23Fd73b,0x6eAb15F002D41F90765b16712dE1001d306710d4,0xa7c978247ECB5DD05313d148DFFFc480Bfe7DdEe];
    uint256[] public Stakes = [40,40,20];


    
    constructor (uint256[] memory _shares) PaymentSplitter(ProductOwner, _shares) payable {}
    
}
/**
    address[] public ProductOwner = [0x98dfa9Bb43E698A8559C0e2Cde23EdfCA23Fd73b,0x6eAb15F002D41F90765b16712dE1001d306710d4,0xa7c978247ECB5DD05313d148DFFFc480Bfe7DdEe];

 */

/** 
[40,40,20]
*/
