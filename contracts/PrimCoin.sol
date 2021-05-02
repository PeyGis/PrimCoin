
 pragma solidity >=0.7.0 <0.9.0;
 
 /**
 * Author: Pages Coffie
 * Date: May 02, 2021
 * Project: A Stablecoin called PrimCoin
 */
 
 contract PrimCoin {
     
     //define instance variables
     string public name = "PrimCoin";
     string public symbol = "PCN";
     uint256 public totalSupply = 10000;
     uint256 public decimals = 18;
     
     //mappings
     mapping(address => uint256) public balances;
     mapping(address => mapping(address => uint256)) public allowance;

     //events
     event Transfer(address indexed _from, address indexed _to, uint256 _value);
     event Approval(address indexed _owner, address indexed _spender, uint256 _value);
     
     //constructor
     constructor (){
         balances[msg.sender] = totalSupply;
     }
     
     //Returns the account balance of another account with address _owner
     function balanceOf(address _owner) public view returns(uint256){
         return balances[_owner];
     }
     
     //Transfers _value amount of tokens to address _to, and MUST fire the Transfer event
     function transfer(address _to, uint256 value) public returns(bool success){
         require(balanceOf(msg.sender) >= value, 'insufficient balance');
         balances[_to] +=value;
         balances[msg.sender] -= value;
         emit Transfer(msg.sender, _to, value);
         success = true;
     }
     
     // Allows _spender to withdraw from your account multiple times, up to the _value amount
     function approve(address _spender, uint256 _value) public returns (bool success){
         require(balanceOf(msg.sender) >= _value, 'balance too low to delegate');
         allowance[msg.sender][_spender] = _value;
         emit Approval(msg.sender, _spender, _value);
         success = true;
     }
     
     //Transfers _value amount of tokens from address _from to address _to
     function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
         require(balanceOf(_from) >= _value, 'balance too low to transfer');
         require(allowance[_from][msg.sender] >= _value, 'cannot withdraw beyond your delegated limit');
         balances[_to] += _value;
         balances[_from] -= _value;
         emit Transfer(_from, _to, _value);
         success = true;
     }
     
 }