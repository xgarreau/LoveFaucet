// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LoveFaucet is Ownable, ReentrancyGuard {
    // Interface to the $LOVE token on Yuma
    IERC20 private iLOVE = IERC20(0xfc9C392A7e3e9F44f1a2FcFb173cD2d80de27b34);

    constructor () {}

    // How many tokens are in one drop ?
    // 20 $LOVE in one Drop
    uint public dropAmount = 20 * 10 ** 18;

    // Store each address last airdrop time
    mapping (address => uint) usersLastTime;

    // Check if the sender claimed in the last 24h (86400s)
    function canClaim() public view returns (bool) {
        return (block.timestamp > usersLastTime[msg.sender] + 86400);
    }

    // Check the balance of the smartContract
    function balance() public view returns (uint) {
        return iLOVE.balanceOf(address(this));
    }

    // Withdraw the remaining love (contract owner only)
    function withdrawFunds() external onlyOwner {
        require (iLOVE.balanceOf(address(this)) > 0, "Empty balance");
        require (iLOVE.transfer(msg.sender, balance()), "Withdrawal failed");
    } 

    // Method to call to get a drop of $LOVE
    // Need some tZEN to pay the fees
    function getLove() external nonReentrant {
        require (iLOVE.balanceOf(address(this)) >= dropAmount, "The faucet ran out of $LOVE");
        require (canClaim(), "Only once a day baby");
        require (iLOVE.transfer(msg.sender, dropAmount), "Ooops, Drop failed !");
        usersLastTime[msg.sender] = block.timestamp;
    }
}
