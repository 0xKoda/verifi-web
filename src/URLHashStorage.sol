pragma solidity ^0.8.0;

// Contract for storing and retrieving MD5 hashes of URLs with enhanced owner verification
contract URLHashStorage {
    address public contractOwner;
    // Mapping from URL string to MD5 hash string
    mapping(string => string) private urlToHash;
    // Mapping to store the Ethereum address approved to store the hash for each URL
    mapping(string => address) private approvedAddressForURL;

    // Constructor sets the contract deployer as the contract owner
    constructor() {
        contractOwner = msg.sender;
    }

    // Modifier to restrict function execution to only the contract owner
    modifier onlyContractOwner() {
        require(msg.sender == contractOwner, "Only the contract owner can call this function");
        _;
    }

    // Function for the contract owner to set the approved address for a URL
    function setApprovedAddressForURL(string memory url, address approvedAddress) public onlyContractOwner {
        approvedAddressForURL[url] = approvedAddress;
    }

    // Function to store the MD5 hash of a URL, restricted to the approved address
    function storeHash(string memory url, string memory hash) public {
        require(bytes(url).length > 0, "URL is empty");
        require(bytes(hash).length == 32, "Invalid MD5 hash length"); // MD5 hashes are 32 characters
        require(msg.sender == approvedAddressForURL[url], "Caller is not approved to store hash for this URL");

        urlToHash[url] = hash;
    }

    // Public view function to retrieve the MD5 hash for a given URL
    function getHash(string memory url) public view returns (string memory) {
        require(bytes(urlToHash[url]).length > 0, "No hash found for URL");
        return urlToHash[url];
    }
}
