pragma solidity 0.8.20; //Do not change the solidity version as it negatively impacts submission grading
// SPDX-License-Identifier: MIT

// import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor {
    uint256 public constant tokensPerEth = 100;

    event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
	error ERC20InsufficientBalance();

    YourToken public yourToken;

    constructor(address tokenAddress) {
        yourToken = YourToken(tokenAddress);
    }

	function buyTokens()  public payable {
		uint256 amountOfTokens = msg.value * tokensPerEth;
		if (yourToken.balanceOf(address(this)) < amountOfTokens) {
			revert ERC20InsufficientBalance();
		}
		yourToken.transfer(msg.sender, amountOfTokens);
		emit BuyTokens(msg.sender, msg.value, amountOfTokens);

	}


	function withdraw() public onlyOwner {
		payable(owner()).transfer(address(this).balance);
	}

	function sellTokens(uint256 _amount) public {
		uint256 ethAmount = _amount / tokensPerEth;
		require(yourToken.transferFrom(msg.sender, address(this), _amount), "Transfer failed");
		payable(msg.sender).transfer(ethAmount);
	}


    // ToDo: create a payable buyTokens() function:

    // ToDo: create a withdraw() function that lets the owner withdraw ETH

    // ToDo: create a sellTokens(uint256 _amount) function:
}
