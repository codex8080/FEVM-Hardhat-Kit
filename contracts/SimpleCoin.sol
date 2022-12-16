// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


error SimpleCoin__NotEnoughBalance();

contract SimpleCoin {
        mapping (address => uint) balances;
        uint256 private i_tokensToBeMinted;


        constructor(uint256 tokensToBeMinted) {
                balances[tx.origin] = tokensToBeMinted;
                i_tokensToBeMinted= tokensToBeMinted;
        }
        
        function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
                if (balances[msg.sender] < amount) {
                // return false;
                revert SimpleCoin__NotEnoughBalance();
                }

                balances[msg.sender] -= amount;
                balances[receiver] += amount;
                return true;
        }

        function getBalanceInEth(address addr) public view returns(uint){
                return getBalance(addr) * 2;
        }

        function getBalance(address addr) public view returns(uint) {
                return balances[addr];
        }

        function getMintedTokenBalance() public view returns(uint256){
                return i_tokensToBeMinted;
        }


        // 向合约账户转账 
        function toContract() payable public {
            payable(address(this)).transfer(msg.value);
        }
        
        // 向调用账户转账 
        function fromContract(address receiver, uint amount) payable public {
            payable(address(receiver)).transfer(amount);
        }
        
        // 获取合约账户余额 
        function getBalanceOfContract() public view returns (uint256) {
            return address(this).balance;
        }

        // 获取账户余额 
        function getBalanceOf(address addr) public view returns (uint256) {
            return address(addr).balance;
        }
        
        fallback() external payable {}
        
        receive() external payable {}

}