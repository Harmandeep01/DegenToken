// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts v5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, ERC20Burnable, Ownable {
    string[] private items;
    event redeemLog(string RedeemMessage);
    
    constructor(address initialOwner)          
    ERC20("Degen", "DGN")
    Ownable(initialOwner){
        items.push("1. NFT");
        items.push("2. Ghost-Skin");
    }
// string[] private items;
   function decimals() public view virtual override returns (uint8) {
        return 0;
    }
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    

   function itemList() external view returns (string[] memory) {
    return items;
   }
    function redeemItem(uint8 itemCode) external {
        uint256 valueOfNFT = 100;
        uint256 valueOfGhostSkin = 250;
        require(balanceOf(msg.sender)>100);
        if (itemCode == 1) {
              _transfer(msg.sender, owner(), valueOfNFT);
              emit redeemLog("Woah! Congratulations you have purchased NFT worth 100 AVAX!");
        }
        else if(itemCode == 2) {
            _transfer(msg.sender, owner(), valueOfGhostSkin);
            emit redeemLog("Whoohoo! You purchased Ghost Skin worth 250 AVAX!");
        }
        
    }


}
