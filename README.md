# HardBank -- manifesting on-chain commerce. 

This is Version 0.1 of HardBank. Our smart contracts were built thanks to the open-source resources provided by the following:

The Stripes NFT: https://github.com/The-Stripes-NFT/

m1guelpf: https://github.com/m1guelpf/nft-token-drop

OpenZeppelin: https://github.com/OpenZeppelin/openzeppelin-contracts

HashLips: https://github.com/HashLips/solidity_smart_contracts

Thanks a ton, for real.

## Smart Contracts

There are four smart contracts included in this folder:
 - <b>BranchNFT.sol</b> -- this smart contract acts as the barcode for the product; products are purchased by minting NFTs from this contract.
   - corresponds to BRANCH_NFT_ADDRESS on the front end
    
    
 - <b>$NFT.sol</b> -- this smart contract is engaged during the claim process and provides rewards token for purchasing the product while also ensuring that each minted NFT can only undergo the claim process once - i.e. one NFT can only claim one product.
   - corresponds to TOKEN_ADDRESS on the front end
    
    
 - <b>Payments.sol</b> -- this smart contract is the payment splitter, designating how much each owner is due to receive and is executable only by the owners.
   - corresponds to PAYMENT_ADDRESS on the front end
   
   
 - <b>TrunkNFT.sol</b> -- this smart contract mints the owners of the product, who have exclusive access to view and withdraw their share of cash proceeds in real time.
   - currently not engaged on the front end


Additional functionalities will be written into each smart contract in following iterations. TrunkNFT.sol is currently not engaged by v0.1 of the HardBank application and will be engaged in future versions.

## BranchNFT.sol

The BranchNFT smart contract acts as the injective representation of the given physicial product and is meant to mirror how barcodes are used in commerce today. Just as how barcodes are scanned each time a product is sold, each sale of the product is represented by a BranchNFT mint from the BranchNFT smart contract.

Since there is no theoretical limit to how much quantity a given product can sell, there is no cap to how many BranchNFTs can be be minted from the BranchNFT smart contract.

The BranchNFT holds the proceeds resulting from sales of the product, which are releasable to the Payments smart contract through a function on the BranchNFT smart contract that can only be exectued by the owners of TrunkNFTs. At this time, we have yet to code the functionality that allows the BranchNFT smart contract to read, in real-time, who owns TrunkNFTs and have instead manually inputted the wallet addresses of the TrunkNFT owners.

## $NFT.sol

The $NFT smart contract is technically the smart contract for the loyalty points, and resembles a smart contract designed for token claims exclusive to specific NFT holders. These kinds of airdrop are designed to ensure that a given NFT can claim the airdrop tokens only once.

In the event that the BranchNFT holder wants to claim the physical product, they provide a physical address to the merchant, and then provide their BranchNFT index number to mint the rewards tokens from the $NFT smart contract to successfully complete the claim process. The $NFT smart contract subseqeuntly records the index numbers of the BranchNFTs that have already been used to claim reward tokens, limiting each index number to one claim. This ensures that each BranchNFT can only be used to complete the claim process once.

However, this does not alter the state of the BranchNFT itself, which may be misleading and lead to fradulent re-selling as well as unneccessary disputes. As such, it may make more sense for BranchNFT itself to be changed or burned during the claim process. This type of functionality needs to be coded into the BranchNFT smart contract rather than the $NFT smart contract.

## Payments.sol

The Payments smart contract is used to withdraw proceeds from product sales and is executable only by owners of the product. Technically speaking, this equates to proceeds from BranchNFT mints that can only be accessed only by TrunkNFT holders.

Whenever a withdrawal function is executed on the BranchNFT smart contract, the balance of the BranchNFT smart contract is sent to the Payments smart contract. The resulting balance of the Payments smart contract can then be withdrawn by holders of TrunkNFTs, which represent the product owners.

Currently, we have yet to code the functionality which allows the Payments smart contract to read, in real-time, who owns TrunkNFTs and have instead manually inputted the wallet addresses of the TrunkNFT holders.

The proportions of the proceeds that are due to each party are written into the smart contract and cannot be adjusted.
