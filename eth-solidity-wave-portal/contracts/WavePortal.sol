// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 public totalWaves;

    // events for the portal ... need to review
    event NewWave(address indexed from, uint256 timestamp, string message);

    /*
     A struct is similar to an interface in TypeScript. Essentially it's a custom datatype where we can customize what is held inside it.
     */
    struct Wave {
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    }

    /*
     * waves is a variable to store an array of struct. This is what lets me hold all the waves anyone ever sends to me!
     */
    Wave[] waves;

    constructor() payable {
        console.log("gm Buildspace.. Wave!");
    }

    // This is the function that will be called when someone sends a wave msg in the portal.
    function wave(string memory _message) public {
        totalWaves++;
        console.log("%s, gm Wave!", msg.sender);

        // push a new Wave struct to the waves array
        waves.push(Wave(msg.sender, _message, block.timestamp));

        // emit the NewWave event
        emit NewWave(msg.sender, block.timestamp, _message);

        uint256 prizeAmount = 0.0001 ether;

        // require the prizeAmount to be sent to the sender
        // require will throw an error if the condition is not met and the transaction will be reverted
        require(
            prizeAmount <= address(this).balance,
            "Trying to withdraw more money than the contract has."
        );

        // send the prizeAmount to the sender
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");

        // check if the transaction succeeded otherwise cancel the transaction
        require(success, "Failed to withdraw money from contract.");
    }

    // get the msgs from the waves array
    function getAllWaveMsgs() public view returns (Wave[] memory) {
        return waves;
    }

    // get the total number of waves
    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total gm's!", totalWaves);
        return totalWaves;
    }
}
