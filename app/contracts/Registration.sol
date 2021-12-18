// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Registration {
    address public owner;

    mapping(address => User) public users;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only admin can perform this acction");
        _;
    }

    function registerUser(
        address _address,
        string memory _name,
        uint8 _age
    ) public onlyOwner {
        users[_address] = User(_name, _age, true);
        emit NewUser(_address, _name, _age);
    }

    function send(uint8 _value) public {
        require(users[msg.sender].registered, "Caller is not registered");
        emit NewValue(msg.sender, _value);
    }

    struct User {
        string user;
        uint8 age;
        bool registered;
    }

    event NewUser(address userAddress, string name, uint8 age);
    event NewValue(address userAddress, uint256 value);
}
