
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AlejandroToken is ERC20 {
    address private _alejandro; 

    constructor(string memory name) ERC20(name, "ALJDRO") {
        _alejandro = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == _alejandro, "Only owner can call this function");
        _;
    }

    function mint(address account, uint256 amount) external onlyOwner { 
        _mint(account, amount);
    }

   
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(recipient != address(0), "ERC20: Transfer to the zero address is not allowed");
        _transfer(_msgSender(), recipient, amount); 
        return true;
    }


    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(recipient != address(0), "ERC20: Transfer to the zero address is not allowed");
        _transfer(sender, recipient, amount);
        uint256 currentAllowance = allowance(sender, _msgSender()); 
        require(currentAllowance >= amount, "ERC20: Transfer amount exceeds allowance");
        _approve(sender, _msgSender(), currentAllowance - amount);
        return true;
    }

   
    function burn(uint256 amount) public {
        _burn(_msgSender(), amount); 
    }
}
