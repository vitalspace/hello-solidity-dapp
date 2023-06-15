// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract HelloContract {
    string public message;

    constructor() {
        message = "Hello world!";
    }

    function getMessage() public view returns (string memory) {
        return message;
    }

    function updateMessaje(string memory newMessage) public {
        message = newMessage;
    }
}
