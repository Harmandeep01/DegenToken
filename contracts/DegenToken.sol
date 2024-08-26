// SPDX-License-Identifier: MIT
pragma solidity >0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DegenToken is ERC20 {
    address private owner;
    string[2] private items = ["NFT", "Ghost-Skin"];
    uint[2] private prices = [1000, 500];
    mapping(address => string[]) private ownedAssets;

    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Redeem(address indexed from, string item, uint256 price);

    constructor() ERC20("Degen", "DGN") {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Only owner can access");
        _;
    }

    function mintTo(address _to, uint256 _val) public onlyOwner() {
        _mint(_to, _val);
        emit Mint(_to, _val);
    }

    function burnFrom(uint256 _val) public {
        _burn(msg.sender, _val);
        emit Burn(msg.sender, _val);
    }

    function redeem(uint256 _item) public {
        require(_item > 0 && _item <= items.length, "Item index out of bounds");
        uint256 price = prices[_item - 1];
        _burn(msg.sender, price);
        ownedAssets[msg.sender].push(items[_item - 1]);
        emit Redeem(msg.sender, items[_item - 1], price);
    }

    function transferTo(address _to, uint256 _val) public {
        _transfer(msg.sender, _to, _val);
    }

    function getOwnedAssets(address _owner) public view returns (string[] memory) {
        return ownedAssets[_owner];
    }

    function getAvailableItems() public view returns (string[] memory, uint256[] memory) {
    
        string[] memory itemsArray = new string[](items.length);
        uint256[] memory pricesArray = new uint256[](prices.length);

        for (uint256 i = 0; i < items.length; i++) {
            itemsArray[i] = items[i];
            pricesArray[i] = prices[i];
        }

        return (itemsArray, pricesArray);
    }
}
