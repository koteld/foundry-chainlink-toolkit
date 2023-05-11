// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.2 <0.9.0;

import "forge-std/Script.sol";
import "../src/interfaces/ChainlinkDirectRequestConsumerInterface.sol";

contract ChainlinkDirectRequestConsumerScript is Script {
  function run() external view {
    console.log("Please run deploy() method.");
  }

  function deploy(address linkTokenAddress) external returns(address) {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(deployerPrivateKey);

    address chainlinkConsumer = deployCode("ChainlinkDirectRequestConsumer.sol:ChainlinkDirectRequestConsumer", abi.encode(linkTokenAddress));

    vm.stopBroadcast();

    return chainlinkConsumer;
  }

  function requestEthereumPrice(address consumerAddress, address oracleAddress, string memory jobId) public {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(deployerPrivateKey);

    ChainlinkDirectRequestConsumerInterface chainlinkConsumer = ChainlinkDirectRequestConsumerInterface(consumerAddress);
    chainlinkConsumer.requestEthereumPrice(oracleAddress, jobId);

    vm.stopBroadcast();
  }

  function getEthereumPrice(address consumerAddress) external view returns(uint256) {
    ChainlinkDirectRequestConsumerInterface chainlinkConsumer = ChainlinkDirectRequestConsumerInterface(consumerAddress);
    return chainlinkConsumer.currentPrice();
  }
}