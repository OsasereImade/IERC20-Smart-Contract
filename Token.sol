// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./IERC20.sol";

/**
    A smart contract that facilitates the exchange of crytocurrency on an 
    Etherum blockchain.
 */

  contract Token is IERC20 {
    
    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowance;

    // Returns the amount of tokens
    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    // Returns the balance of a specific address from a contract
    function balanceOf(address _account) external view returns (uint256) {
        return _balances[_account];
    }

    // Returns the amount of tokens that spender would be abe to spend on behalf of owner.
    function allowance(address owner, address spender) external view returns (uint256){
        return _allowance[owner][spender];
    }

    // Transfers a certain amount of token from the callers address to another address.
    function transfer(address to, uint256 _amount) public returns (bool) {
        require(_amount <= _balances[msg.sender], "Insufficient funds");

        _balances[msg.sender] -= _amount;
        _balances[to] += _amount;

        emit Transfer(msg.sender, to, _amount);
        return true;
    }


    // Goal : Transfer "amount" from "from" to "to"
    // Checks : Does "from" have enough balance to transfer "amount" to "to"

    // It allows a spender to transfer tokens on behalf of the owner to a receipent address
    function transferFrom(address _from, address _to, uint _amount) public returns (bool success){

        // Check if the sender has enough allowance to transfer or give
        require(_amount <= _allowance[_from][msg.sender], "Insufficient allowance");

        // Check if the sender has enough balance to transfer the amount
        require(_amount <= _balances[_from], "Insufficient balance");

        // Subtract the amount from the sender's allowance(the one authorizing the transaction)
        _allowance[_from][msg.sender] -= _amount;

        // Subtract the amount from the sender's balance
        _balances[_from] -= _amount;

        // Add the amount to the recipent's balance
        _balances[_to] += _amount;

        //emit the transfer event
        emit Transfer(_from, _to, _amount);
        
        return true;
    }
    
    // Allows owner to authorize a spender to transfer up to a certain amount
    function approve(address spender, uint256 amount) external returns (bool){

        _allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    

}