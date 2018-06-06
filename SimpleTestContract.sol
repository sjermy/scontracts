pragma solidity ^0.4.24;
contract MyContract {
    address creator;
    uint256 myNumber;

    constructor() public {
        creator = msg.sender;
        myNumber = 3;
    }

    function getCreator() public view returns(address) {
        return creator;
    }

    function getMyNumber() public view returns(uint256) {
        return myNumber;
    }

    function setMyNumber(uint256 myNewNumber) public {
        myNumber = myNewNumber;
    }

    function kill() public {
        if(msg.sender == creator) {
            selfdestruct(creator);
        }
    }
}
