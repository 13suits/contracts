# HardBank -- manifesting on-chain commerce. 

This is Version 0.1 of HardBank. Our smart contracts were built thanks to the open-source resources provided by the following:

The Stripes NFT: https://github.com/The-Stripes-NFT/

m1guelpf: https://github.com/m1guelpf/nft-token-drop

OpenZeppelin: https://github.com/OpenZeppelin/openzeppelin-contracts

HashLips: https://github.com/HashLips/solidity_smart_contracts

Thanks a ton, for real.

## Smart Contracts

There are four smart contracts included in this folder:
 - <b>BranchNFT.sol</b> -- this smart contract acts as the barcode for the product and is executable by anyone.
   - corresponds to BRANCH_NFT_ADDRESS on the front end
    
    
 - <b>$NFT.sol</b> -- this smart contract is for the rewards token of the product and is also engaged in the claim function of the purchasing journey.
   - corresponds to TOKEN_ADDRESS on the front end
    
    
 - <b>Payments.sol</b> -- this smart contract is the payment splitter, designating how much each owner is due to receive and is executable only by the owners. - 
   - corresponds to PAYMENT_ADDRESS on the front end
   
   
 - <b>TrunkNFT.sol</b> -- this smart contract mints the owners of the product, who have exclusive access to view and claim their share of cash proceeds from sales of the product in real time.
   - currently not engaged on the front end


Additional functionalities will be written into each smart contract in following iterations. TrunkNFT.sol is currently not engaged by v0.1 of the HardBank application and will be engaged in future versions.

## BranchNFT

The BranchNFT smart contract acts as the representation of the physical product which will be sold and is meant to mirror how barcodes are used in commerce today.

As such, there is no cap given to how many BranchNFTs can be minted from the BranchNFT smart contract, since there is no theoretical limit to how much quantity a given product can sell.

The BranchNFT holds all the proceeds from sales of the product, which are releasable to the Payments.sol through a blockchain function that can only be exectued by the owners of TrunkNFTs. At this time, we have yet to code the functionality that allows the BranchNFT smart contract to read, in real-time, who owns the TrunkNFT and have instead manually inputted the wallet addresses of the TrunkNFT owners.
