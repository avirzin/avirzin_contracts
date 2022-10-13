// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2; // Compiler version

contract TokenBasico { // Contract name - same as the file name
    
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowance;
    
    // Total qty of the tokens
    uint public totalSupply = 100000 * 10 ** 18;
    string public name = "CursoCompleto"; // Token name
    string public symbol = "CCT"; // Token symbol
    uint public decimals = 18; // Token decimals (18 is the most common). If you change this, 
    //you need to change the totalSupply
    
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
    
    // Constructor - executed only once when the contract is created
    constructor() {
        balances[msg.sender] = totalSupply; // msg.sender is the address of the account that deployed the contract
    }
    
    // Function to transfer tokens
    function balanceOf(address owner) public view returns(uint) {
        return balances[owner];
    }
    
    // Function to transfer tokens
    function transfer(address to, uint value) public returns(bool) {
        require(balanceOf(msg.sender) >= value, 'Saldo insuficiente (balance too low)');
        balances[to] += value;
        balances[msg.sender] -= value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
    
    // Function to transfer tokens from another account
    function transferFrom(address from, address to, uint value) public returns(bool) {
        require(balanceOf(from) >= value, 'Saldo insuficiente (balance too low)');
        require(allowance[from][msg.sender] >= value, 'Sem permissao (allowance too low)');
        balances[to] += value;
        balances[from] -= value;
        emit Transfer(from, to, value);
        return true;
    }
    
    // Function to approve another account to transfer tokens from your account
    function approve(address spender, uint value) public returns(bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
    
}