# HardBank -- manifesting on-chain commerce. 

This is Version 0.1 of HardBank. Our smart contracts were built thanks to the open-source resources provided by the following:

The Stripes NFT: https://github.com/The-Stripes-NFT/

m1guelpf: https://github.com/m1guelpf/nft-token-drop

OpenZeppelin: https://github.com/OpenZeppelin/openzeppelin-contracts

HashLips: https://github.com/HashLips/solidity_smart_contracts

Thanks a ton, for real.

## How to Use

These smart contracts should be examined, editted, and deployed on Remix IDE.

Remix is incredible, and the tremendous amount of open-source resources available for blockchain development makes it very difficult to take a long-term bearish stance on blockchain.

As such, it only makes sense that a tremendous proportion of transactions for physical products -- both offline and online -- will eventually take place fully on-chain -- i.e. full-chain transactions.

## Smart Contracts

There are four smart contracts included in this folder:
 - <b>BranchNFT.sol</b> -- this smart contract acts as the barcode for the product; products are purchased by minting NFTs from this contract.
   - corresponds to BRANCH_NFT_ADDRESS on the front end
    
    
 - <b>$NFT.sol</b> -- this smart contract is engaged during the claim process and provides loyalty tokens to reward those who purchase the product while also ensuring that each minted NFT can only undergo the claim process once - i.e. one NFT can only claim one product.
   - corresponds to TOKEN_ADDRESS on the front end
    
    
 - <b>Payments.sol</b> -- this smart contract acts as the paymaster, designating how much of the proceeds from the sale of the product is due to each product owner, and allowing each product owner to claim their share of the proceeds in real time; as such, this contract is executable only by the product owners.
   - corresponds to PAYMENT_ADDRESS on the front end
   
   
 - <b>TrunkNFT.sol</b> -- this smart contract designates product ownership - i.e. holders of TrunkNFTs are the product owners who have exclusive access to view and withdraw their share of the proceeds in real time.
   - currently not engaged on the front end


Additional functionalities will be written into each smart contract in the iterations that follow. TrunkNFT.sol is currently not engaged by v0.1 of the HardBank application and will be engaged in future versions.

## BranchNFT.sol

The BranchNFT smart contract acts as the unique representation of the given physicial product on the blockchain and is meant to mirror how barcodes are used in commerce today. Just as how barcodes are scanned each time a product is sold, each sale of the product is represented by a BranchNFT mint from the BranchNFT smart contract.

Since there is no theoretical limit to the number of units a given product can sell, there is no cap to the number of BranchNFTs which can be be minted from the BranchNFT smart contract.

The BranchNFT holds the proceeds resulting from sales of the product. These proceeds are releasable to the Payments smart contract through a function on the BranchNFT smart contract that can only be exectued by the owners of TrunkNFTs. At this time, we have yet to code the functionality that allows the BranchNFT smart contract to read, in real-time, who owns TrunkNFTs and have instead manually inputted the wallet addresses of existing TrunkNFT owners to mimic the exclusive nature of this functionality.

## $NFT.sol

The $NFT smart contract is technically the smart contract for loyalty tokens, and resembles a smart contract designed for token claims exclusive to specific NFT holders, for example ApeCoin for BAYC/MAYC holders. This kind of airdrop is designed to ensure that a given NFT can only claim the airdrop tokens once.

In the event that the BranchNFT holder wants to claim the physical product, they provide a physical address to the merchant, and then provide their BranchNFT index number to mint the loyalty tokens from the $NFT smart contract and successfully complete the claim process. In order to execute this function, the executing wallet must hold the BranchNFT which corresponds to the index number that is provided.

Upon completing the process, the $NFT smart contract subseqeuntly records the index number of the BranchNFT that was used to claim the loyalty tokens, limiting each index number to one claim. A attempt to use the same index number for a second claim would fail to trigger the token airdrop, effectively ensuring that each BranchNFT can only be used to complete the claim process once.

However, this does not alter the state of the BranchNFT itself, which can be misleading and may lead to fradulent re-selling as well as unneccessary disputes. As such, it may make more sense for the BranchNFT itself to be changed or burned during the claim process. These functionalities would need to be coded into the BranchNFT smart contract rather than the $NFT smart contract.

## Payments.sol

The Payments smart contract is used to accept and divvy proceeds from product sales for each product owner to withdraw; as such, only product owners - i.e. TrunkNFT holders - can execute on this smart contract.

Whenever a withdrawal function is executed on the BranchNFT smart contract, the balance of the BranchNFT smart contract is sent to the Payments smart contract. The Payments smart contract automatically divvies the received balance according to the respective proportion due to each product owner -- that is, TrunkNFT holder. TrunkNFT holders can then withdraw their respective balance from the Payments smart contract.

The proportions of the proceeds that are due to each party are written into the smart contract and cannot be adjusted.

Currently, we have yet to code the functionality which allows the Payments smart contract to read, in real-time, who owns TrunkNFTs and have instead manually inputted the wallet addresses of the TrunkNFT holders to mimic the functionality we describe.

## TrunkNFT.sol

The TrunkNFT smart contract is used to designate product ownership; existing product owners hold TrunkNFTs and prospective product owners can mint TrunkNFTs from the TrunkNFT smart contract.

As product owners, TrunkNFT holders can view the proceeds from BranchNFT/product sales and can also claim their share of the proceeds, in real time, from the BranchNFT smart contract via the Payments smart contract.

To ensure there is no dilution to the share of proceeds due to each product owner, there must be a cap to the number of TrunkNFTs that can be minted. In our contract, we have set this number at 10, but it can be adjusted accordingly.

By using NFTs instead of tokens to represent ownership positions, each ownership position exists as a single entry point rather than as a percentage. As such, we can extend certain and specific governance rights and responsibilities to each TrunkNFT, effectively rendering them to also operate as seats on a Board of Directors. This posits a system of governance that may be more efficient than one which relies entirely on governance tokens and therefore may be prone to devolve into disorganized voting blocks with no coherent agenda.

It should also be stressed that we intend each TrunkNFT to come not only with rights, but also with responsibilities. While the responsibilities may not be tremendous in scope, any community driven project requires that the participants actually participate.

The ability to claim proceeds, plus the ability to determine governance, plus the limited mints available, provides grounds for speculation on the value of a TrunkNFT. The possibility of upside effectively provides an incentive to mint TrunkNFTs and become new product owners.

The main challenge to integrating the TrunkNFT smart contract into the front end involves making sure the applications can read who holds a TrunkNFT at any given moment in real time.

## Additional Thoughts

1/ Instead of using BranchNFTs, it may make more sense to use BranchNTTs. The vast majority of physical products are purchased to be used; there is no concern given to the re-sale of these products -- for example a dozen eggs, or a pair of sandals; these products are purchased to be consumed/used, not to be speculated on or resold. NFTs carry a strong connotation of speculation, and while our TrunkNFTs does encourage speculation, our BranchNFTs act as representations of actual physical products and not collectibles or investments. Therefore, it may make more sense to utilize NTTs, which better mimic how end-users purchase the vast majority of physical products.

2/ There is no third-party oversight which demands that the merchant actually physically sends the product to the purchaser when the purchaser completes the claim process. This is a major shortcoming and there is no way for the smart contracts to enforce this crucial element of the transaction. That being said, there are two things to keep in mind:
- It is possible that the market, decentralized as it may, will self-regulate to ensure that bad acting merchants will be unable to sell their products in the face of tremendous transparency. This is idealistic and a process which is likely inefficient.
- Taking a more realistic view on the matter, an third-party which executes the physical logistics while also acting as an escrow via smart contracts is likely necessary for this protocol to scale. Again, there is no governing party to ensure that this third-party does not act in bad faith, but such is true for any logistics company or payments processing company that exists in commerce today. At the end of the day, we are already relying on the market to self-regulate.
