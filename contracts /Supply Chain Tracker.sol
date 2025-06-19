// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChainTracker {
    enum Status { Manufactured, InTransit, Delivered }

    struct Product {
        uint256 id;
        string name;
        address owner;
        Status status;
    }

    mapping(uint256 => Product) public products;
    uint256 public productCount;

    event ProductAdded(uint256 id, string name, address indexed owner);
    event ProductStatusUpdated(uint256 id, Status newStatus);

    function addProduct(string memory _name) public {
        productCount++;
        products[productCount] = Product(productCount, _name, msg.sender, Status.Manufactured);
        emit ProductAdded(productCount, _name, msg.sender);
    }

    function updateStatus(uint256 _id, Status _status) public {
        require(products[_id].owner == msg.sender, "Not the product owner");
        products[_id].status = _status;
        emit ProductStatusUpdated(_id, _status);
    }

    function getProduct(uint256 _id) public view returns (Product memory) {
        return products[_id];
    }
}

