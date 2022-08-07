//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract BranchNFT is ERC721Enumerable, Ownable {
    using Strings for uint256;

    string public baseURI;
    string public baseExtension = ".json";
    uint256 public cost = 0.001 ether;
    uint256 public maxMintAmount = 10;
    bool public paused = false;
    address payable payment;
    address[] public ProductOwner = [0x98dfa9Bb43E698A8559C0e2Cde23EdfCA23Fd73b,0x6eAb15F002D41F90765b16712dE1001d306710d4,0xa7c978247ECB5DD05313d148DFFFc480Bfe7DdEe];


    constructor(
        string memory _name,
        string memory _symbol,
        string memory _initBaseURI,
        address _payment
    ) ERC721(_name, _symbol) {
        setBaseURI(_initBaseURI);
        payment = payable(_payment);
    }

    modifier onlyProductOwner(){
        require(msg.sender == ProductOwner[0] || msg.sender == ProductOwner[1] || msg.sender == ProductOwner[2]);
        _;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function mint(address _to, uint256 _mintAmount) public payable {
        uint256 supply = totalSupply();
        require(!paused);
        require(_mintAmount > 0);
        require(_mintAmount <= maxMintAmount);

        if (msg.sender != owner()) {
                    require(msg.value >= cost * _mintAmount);
                } 

        for (uint256 i = 1; i <= _mintAmount; i++) {
            _safeMint(_to, supply + i);
        }
    }

    function walletOfOwner(address _owner)
        public
        view
        returns (uint256[] memory)
    {
        uint256 ownerTokenCount = balanceOf(_owner);
        uint256[] memory tokenIds = new uint256[](ownerTokenCount);
        for (uint256 i; i < ownerTokenCount; i++) {
            tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
        }
        return tokenIds;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory currentBaseURI = _baseURI();
        return
            bytes(currentBaseURI).length > 0
                ? string(
                    abi.encodePacked(
                        currentBaseURI,
                        tokenId.toString(),
                        baseExtension
                    )
                )
                : "";
    }

    //only owner
    function setCost(uint256 _newCost) public onlyOwner {
        cost = _newCost;
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public onlyOwner override(ERC721, IERC721) {
        _transfer(from, to, tokenId);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) public onlyOwner override(ERC721, IERC721) {
        _safeTransfer(from, to, tokenId, data);
    }

    function setmaxMintAmount(uint256 _newmaxMintAmount) public onlyOwner {
        maxMintAmount = _newmaxMintAmount;
    }

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
    }

    function setBaseExtension(string memory _newBaseExtension)
        public
        onlyOwner
    {
        baseExtension = _newBaseExtension;
    }

    function pause(bool _state) public onlyOwner {
        paused = _state;
    }

    function withdraw() public payable onlyProductOwner() {
        (bool success, ) = payable(payment).call{
            value: address(this).balance
        }("");
        require(success);
    }


}
