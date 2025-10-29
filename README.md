// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ✅ Correct imports for OpenZeppelin v5.x
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

    // Mapping from token ID to skill details
    mapping(uint256 => Skill) private _skills;

    // ✅ Proper constructor (no arguments to Ownable in v5)
    constructor() ERC721("SkillMint", "SKM") Ownable(msg.sender) {}

    /// @notice Mint a new verified skill NFT for a recipient
    /// @param recipient Address that will receive the NFT
    /// @param skillName Name of the skill (e.g., "Solidity Developer")
    /// @param description Short description (e.g., "Completed smart contract bootcamp")
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

    /// @notice View details of a skill NFT
    /// @param tokenId ID of the NFT
    function getSkill(uint256 tokenId)
        external
        view
        returns (Skill memory)
    {
        require(_ownerOf(tokenId) != address(0), "Skill NFT does not exist");
        return _skills[tokenId];
    }

    /// @notice Returns the total number of NFTs minted so far
    function totalMinted() external view returns (uint256) {
        return _nextTokenId - 1;
    }
}
