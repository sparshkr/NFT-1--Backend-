// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC721, ERC721Enumerable, Ownable {
    uint256 private _nextTokenId;
    uint256 maxSupply = 3;

    constructor()
        ERC721("MyToken", "MTK")
        Ownable(msg.sender) 
    {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://yellow-accessible-marten-682.mypinata.cloud/ipfs/QmcTA74HmVZkD9iMo1cP94DJNSqLuZ5P1EMwd4fCHbQNju/";
    }

    function publicMint() public payable {
        require(msg.value == 0.1 ether, "Not Enough Funds");
        require(totalSupply() < maxSupply, "Cannot Mint More");
        uint256 tokenId = _nextTokenId++;
        _safeMint(msg.sender, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Enumerable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._increaseBalance(account, value);
    }

    function withdraw(address to) external onlyOwner{
        uint256 balance = address(this).balance;
        payable(to).transfer(balance);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
