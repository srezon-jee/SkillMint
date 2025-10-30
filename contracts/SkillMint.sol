// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SkillMint is ERC721, Ownable {
    uint256 private _nextTokenId = 1;

    struct Skill {
        string name;
        string description;
        address recipient;
        uint256 issuedAt;
    }

    mapping(uint256 => Skill) private _skills;

    constructor() ERC721("SkillMint", "SKM") Ownable(msg.sender) {}

    function mintSkill(
        address recipient,
        string memory skillName,
        string memory description
    ) external onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(recipient, tokenId);

        _skills[tokenId] = Skill({
            name: skillName,
            description: description,
            recipient: recipient,
            issuedAt: block.timestamp
        });
    }

    function getSkill(uint256 tokenId)
        external
        view
        returns (Skill memory)
    {
        require(_ownerOf(tokenId) != address(0), "Skill NFT does not exist");
        return _skills[tokenId];
    }

    function totalMinted() external view returns (uint256) {
        return _nextTokenId - 1;
    }
}
