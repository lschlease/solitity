// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.24 and less than 0.9.0
pragma solidity ^0.8.24;

contract founMe {
    // 声明一个地址变量
    address public onwer;

    // 声明一个捐款人的数组
    address[] public founders;

    // 声明一个mapping元素的变量 ， 记录每一个捐款人，对应的捐了多少资产
    mapping(address => uint256) public addressToEth;

    constructor() {
        // 将合约的创作者的地址 赋值
        onwer = msg.sender;
    }

    //用modify管理字 封装成一个函数，当作修饰符在别的地方用
    modifier onlyOnwer() {
        // 判断取款人是不是合约的部署者
        require(onwer == msg.sender, "not onwer");
        _;
    }

    // 定义一个 捐款函数 payable关键字允许捐款
    function fund() public payable {
        // 将捐款人的地址保存下来
        founders.push(msg.sender);

        // 将捐款人的地址对应捐了多少资产存在mapping中
        addressToEth[msg.sender] = msg.value;
    }

    // 定义一个提取资产的函数
    function withdrawal() public onlyOnwer {
        // 如何是合约的部署者，则把所有资产转移到合约部署者的地址中
        payable(msg.sender).transfer(address(this).balance);

        //提取完资产以后，将记录清空，先清空mapping
        for (uint256 i = 0; i < founders.length; i++) {
            addressToEth[founders[i]] = 0;
        }

        //然后再将 记录地址的变量初始化
        founders = new address[](0);
    }

    //没有通过fund函数直接转到合约里来的 需要定义receive函数 ，才能接收
    receive() external payable {
        fund();
    }

    // 有交互信息的时候 会调用 fallback
    fallback() external payable {
        fund();
    }
}
