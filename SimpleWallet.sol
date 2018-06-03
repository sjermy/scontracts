pragma solidity ^0.4.18;

import "github.com/ethereum/solidity/std/mortal.sol";

contract SimpleWallet is mortal {

    mapping(address => Permission) myAddressMapping;

    struct Permission {
        bool isAllowed;
        uint maxTransferAmount;
    }
    
    event someoneAddedSomeoneToTheSendersList(address thePersonWhoAdded, address thePersonWhoIsAllowedNow, uint thisMuchHeCanSend);
    event someoneSentEtherToSomebody(address sender, address receiver, uint amount);
    event someoneIsDeletedSomebodyfromTheList(address thePersonWhoDeleted, address thePersonWhoWasDeleted);
    
    constructor() public payable {}

    function addAddressToSendersList(address permitted, uint maxTransferAmount) public onlyowner {
        myAddressMapping[permitted] = Permission(true, maxTransferAmount);
        emit someoneAddedSomeoneToTheSendersList(msg.sender, permitted, maxTransferAmount);
    }
    
    function removeAddressfromSendersList(address remove) public onlyowner {
        delete myAddressMapping[remove];
        emit someoneIsDeletedSomebodyfromTheList(msg.sender, remove);
    }

    function sendFunds(address receiver, uint amountInWei) public {
        require(myAddressMapping[msg.sender].isAllowed);
        require(myAddressMapping[msg.sender].maxTransferAmount >= amountInWei);
        receiver.transfer(amountInWei);
         // log event
        emit someoneSentEtherToSomebody(msg.sender, receiver, amountInWei);
    }

    function () public payable {}

}
