# URL Hash Storage Contract

## Overview
Too many web2 security issues still affect web3. Recently, DNS takeovers have been in the spotlight with velodrome and aerodrome incidents. This repository contains a Solidity smart contract designed to securely store and verify MD5 hashes of websites. In the DeFi space, DNS takeovers pose a significant threat, often leading to users interacting with malicious webpages and potentially losing funds. By storing MD5 hashes of webpages on chain, we create a provable and immutable record that helps when verifying if a webpage is the same as the one deployed by the protocol owner.

## Getting Started 

```sh
git clone https://github.com/0xkoda/verifi-web.git
cd verifi-web
```

### Run Tests

```sh
forge test
```

## Contributions 
Feel free to contribute.

## ⚠️ Warning 
This is a POC and should not be used in production.


