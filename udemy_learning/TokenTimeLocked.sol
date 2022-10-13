// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract Token {
    
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowance;
    
    uint public totalSupply = 10000 * 10 ** 18;
    string public name = "CursoCompleto";
    string public symbol = "CCT";
    uint public decimals = 18;

    uint256 public currentTimerStamp;
    uint256 public timeblock = 2629743; // Um mes de bloqueio
    
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
    
    constructor() {
        balances[msg.sender] = totalSupply;
        currentTimerStamp = block.timestamp;
    }
    
    function balanceOf(address owner) public view returns(uint) {
        return balances[owner];
    }
    
    modifier checkBlock() {
         require(block.timestamp > currentTimerStamp+timeblock, 'Aguarde um mes para transferir');
         _;
    }

    function transfer(address to, uint value) public checkBlock returns(bool) {
        require(balanceOf(msg.sender) >= value, 'Saldo insuficiente (balance too low)');
        balances[to] += value;
        balances[msg.sender] -= value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    
    function transferFrom(address from, address to, uint value) public returns(bool) {
        require(balanceOf(from) >= value, 'Saldo insuficiente (balance too low)');
        require(allowance[from][msg.sender] >= value, 'Sem permissao (allowance too low)');
        balances[to] += value;
        balances[from] -= value;
        emit Transfer(from, to, value);
        return true;
    }
    
    function approve(address spender, uint value) public returns(bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
    
}