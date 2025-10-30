# 🪙 SkillMint – Verified Skill NFT Certification DApp

SkillMint is a decentralized application that mints **NFT-based certificates** for verified skills directly on the blockchain.  
Each NFT represents a unique, tamper-proof proof of achievement, allowing anyone to **verify skills publicly and securely**.

---

## 📸 Deployment Screenshot

Below is the screenshot of the successful contract deployment on the **Celo Sepolia Testnet**:  

<img width="2880" height="1620" alt="screenshot.png" src="https://github.com/user-attachments/assets/14bbf29e-8892-4896-937e-c34e98363a9f" />


---

## 📜 Project Description

SkillMint is a blockchain-based certification system that issues verified skill NFTs to learners, developers, and professionals.  
When someone completes a verified course or program, the admin (contract owner) can mint a **Skill NFT** containing details such as the skill name, description, recipient address, and issue date.

This ensures **authentic, permanent proof of skill verification** — completely on-chain, without relying on centralized servers or certificates.

---

## ⚙️ What It Does

- 🎓 Mints a verified skill NFT for any recipient address  
- 🪪 Each NFT stores name, description, recipient, and issue timestamp  
- 🔍 Skill data is viewable on-chain through a public function  
- 👑 Only the contract owner can issue new skill NFTs  
- 🌐 Fully decentralized — powered by the Celo blockchain  

In short: **SkillMint = Blockchain-Powered Certificates of Achievement**

---

## 🌟 Features

✅ **On-Chain Verification** – Skill proof lives permanently on blockchain  
✅ **NFT-based Certificates** – Each certificate is a unique ERC-721 token  
✅ **Transparent Records** – Anyone can verify the authenticity anytime  
✅ **Open-Source Solidity Code** – Clean, beginner-friendly contract  
✅ **Secure Ownership** – Only the deployer (admin) can mint new skill NFTs  

---

## 📄 Smart Contract Details

- **Network:** Celo Sepolia Testnet  
- **Contract Name:** `SkillMint`  
- **Language:** Solidity ^0.8.20  
- **Deployed Address:** [`0xe5ddC08ed9bE80DAc4d6c432955cb14D6c82F6B4`](https://celo-sepolia.blockscout.com/address/0xe5ddC08ed9bE80DAc4d6c432955cb14D6c82F6B4)  
- **Transaction Explorer:** [View on Celo Blockscout](https://celo-sepolia.blockscout.com/address/0xe5ddC08ed9bE80DAc4d6c432955cb14D6c82F6B4)  

---

## 💻 Smart Contract Code

```solidity
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

