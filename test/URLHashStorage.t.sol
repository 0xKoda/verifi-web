// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/URLHashStorage.sol";

contract URLHashStorageTest is Test {
    URLHashStorage urlHashStorage;
    address testAddress1 = address(0x123);
    address testAddress2 = address(0x456);

    function setUp() public {
        urlHashStorage = new URLHashStorage();
    }

    function testStoreAndRetrieveHash() public {
        urlHashStorage.setApprovedAddressForURL("example.com", testAddress1);
        vm.prank(testAddress1);
        urlHashStorage.storeHash("example.com", "d41d8cd98f00b204e9800998ecf8427e");

        string memory retrievedHash = urlHashStorage.getHash("example.com");
        assertEq(retrievedHash, "d41d8cd98f00b204e9800998ecf8427e", "Stored hash should match retrieved hash");
    }

    function testNonApprovedAddressCannotStoreHash() public {
        urlHashStorage.setApprovedAddressForURL("example.com", testAddress1);
        vm.prank(testAddress2);
        vm.expectRevert("Caller is not approved to store hash for this URL");
        urlHashStorage.storeHash("example.com", "d41d8cd98f00b204e9800998ecf8427e");
    }

    function testOwnerCanSetApprovedAddress() public {
        vm.prank(address(this));
        urlHashStorage.setApprovedAddressForURL("example.com", testAddress1);
        vm.prank(testAddress1);
        urlHashStorage.storeHash("example.com", "d41d8cd98f00b204e9800998ecf8427e");
        string memory retrievedHash = urlHashStorage.getHash("example.com");
        assertEq(
            retrievedHash,
            "d41d8cd98f00b204e9800998ecf8427e",
            "Owner should be able to set approved address and store hash"
        );
    }

    function testFailEmptyURL() public {
        urlHashStorage.storeHash("", "d41d8cd98f00b204e9800998ecf8427e");
        vm.expectRevert("URL is empty");
    }

    function testFailInvalidMD5HashLength() public {
        urlHashStorage.storeHash("example.com", "invalidhashlength");
        vm.expectRevert("Invalid MD5 hash length");
    }
}
