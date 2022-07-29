// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "https://github.com/transmissions11/solmate/blob/main/src/tokens/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

error MintPriceNotPaid();
error NonExistentTokenURI();
error WithdrawTransfer();

contract NFT is ERC721, Ownable {

    ERC721 internal immutable nft;

    using Strings for uint256;
    string public baseURI;
    uint256 public currentTokenId;
    uint256 public constant MINT_PRICE = 1 ether;
    address payable payment;

    constructor(
        ERC721 _nft,
        string memory _name,
        string memory _symbol,
        string memory _baseURI,
        address _payment
    ) ERC721(_name, _symbol) {
        nft = _nft;
        baseURI = _baseURI;
        payment = payable(_payment);
    }

    modifier onlyNFTer(){
        require(msg.sender == nft.ownerOf(1) || msg.sender == nft.ownerOf(2) || msg.sender == nft.ownerOf(3));
        _;
    }    

    function mintTo(address recipient) public payable returns (uint256) {
        if (msg.value != MINT_PRICE) {
            revert MintPriceNotPaid();
        }
        uint256 newTokenId = ++currentTokenId;
        _safeMint(recipient, newTokenId);
        return newTokenId;
    }


    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        if (ownerOf(tokenId) == address(0)) {
            revert NonExistentTokenURI();
        }
        return
            bytes(baseURI).length > 0
                ? string(abi.encodePacked(baseURI, tokenId.toString()))
                : "";
    }

    function withdrawPayments() public payable onlyNFTer {
        uint256 balance = address(this).balance;
        (bool transferTx, ) = payable(payment).call{value: balance}("");
        if (!transferTx) {
            revert WithdrawTransfer();
        }
    }
}
