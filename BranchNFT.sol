//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "./contracts/access/Ownable.sol";

contract BranchNFT is ERC721Enumerable, Ownable {
    using Strings for uint256;

    string public baseURI;
    string public baseExtension = ".json";
    uint256 public cost = 0.001 ether;
    uint256 public maxMintAmount = 10;
    bool public paused = false;
    address payable payment;
    address[] public NFTer = [0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,0x5B38Da6a701c568545dCfcB03FcB875f56beddC4];


    constructor(
        string memory _name,
        string memory _symbol,
        string memory _initBaseURI,
        address _payment
    ) ERC721(_name, _symbol) {
        setBaseURI(_initBaseURI);
        payment = payable(_payment);
    }

    modifier onlyNFTer(){
        require(msg.sender == NFTer[0] || msg.sender == NFTer[1] || msg.sender == NFTer[2]);
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

    function withdraw() public payable onlyOwner() {
        (bool success, ) = payable(payment).call{
            value: address(this).balance
        }("");
        require(success);
    }
}
