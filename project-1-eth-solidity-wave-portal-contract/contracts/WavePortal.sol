// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    //public integer totalWaves
    uint256 public totalWaves;

    // private int seed;
    uint256 private seed;

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

    /* mapping
     * https://medium.com/upstate-interactive/mappings-in-solidity-explained-in-under-two-minutes-ecba88aff96e
     */
    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        //seed is a random number used to determine if someone wins the prizeAmount
        seed = (block.timestamp + block.difficulty) % 100;
    }

    // This is the function that will be called when someone sends a wave msg in the portal.
    function wave(string memory _message) public {
        /*
         * We need to make sure the current timestamp is at least 30 seconds after the last timestamp we stored
         */
        require(
            lastWavedAt[msg.sender] + 30 seconds < block.timestamp,
            "Please wait at least 30s"
        );

        /*
         * Update the current timestamp we have for the user
         */
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves++;

        // push a new Wave struct to the waves array
        waves.push(Wave(msg.sender, _message, block.timestamp));

        // generate a new seed for the next person who sends a way
        seed = (block.difficulty + block.timestamp + seed) % 100;

        if (seed <= 30) {
            uint256 prizeAmount = 0.00001 ether;

            require(seed <= 30, "You won some ETH!");

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
        // emit the NewWave event
        emit NewWave(msg.sender, block.timestamp, _message);
    }

    // get the msgs from the waves array
    function getAllWaveMsgs() public view returns (Wave[] memory) {
        return waves;
    }

    // get the total number of waves
    function getTotalWaves() public view returns (uint256) {
        return totalWaves;
    }
}
