// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.24 and less than 0.9.0
pragma solidity ^0.8.24;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

//  0x1c91347f2A44538ce62453BEBd9Aa907C662b4bD.   合约
// 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4。 账户地址

contract founMe {
    address public onwer;
    AggregatorV3Interface internal dataFeed;

    uint256 minETH = 1 ether;

    constructor() {
        onwer = msg.sender;
        dataFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
    }

    function fund() public payable {
        require(msg.value > minETH, "must then 1 eth");
    }

    function give() public view {
        require(onwer == msg.sender, "not onwer");
    }

    function ETHTOUSD() public view returns (int256) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();

        return price;
    }
}
