// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Base64.sol";

contract StuntImageNFT is ERC721Enumerable, Ownable {
  using Strings for uint256;

  constructor() ERC721("StuntImageNFT", "SINFT") {}

  // public
  function mint() public payable {
    uint256 supply = totalSupply();
    require(supply + 1 <= 10000);

    if (msg.sender != owner()) {
      require(msg.value >= 0.005 ether);
    }

    _safeMint(msg.sender, supply + 1);
    
  }

  function buildImage() public pure returns(string memory){
    return Base64.encode(bytes(abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" width="800" height="600" viewBox="0 0 1280.000000 1600.000000" preserveAspectRatio="xMidYMid meet">',             
            '<title> Stunt SVG </title>',
            '<g transform="translate(0.000000,1600.000000) scale(0.100000,-0.100000)" fill="#000000">',
            '</g>',
            '</svg>'
            )));
  }

  function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
    require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
    return string(abi.encodePacked('data:application/json;base64,', 
                                   Base64.encode(bytes(abi.encodePacked(
                                   '{"name":"',
                                   "REPLACE",
                                   '", "description":"',
                                   "REPLACE",
                                   '", "image": "',
                                   'data:image/svg+xml;base64,',
                                   buildImage(),
                                   '"}')))));
  }

}
