# Tenancy
Smart Rental Agreements

Product Installation & Demo: https://drive.google.com/file/d/1p-czZieCye32TF8j7jSzMbl344j4MSfT/view?usp=sharing

Personas:

Government Admin - Owner of the Smart Contract - Address: 0x84af7bbDc9AFA7b97a11aC0a9ad0E54e2A704C01 - Account 1
Landlord - Alice - Address: 0x493daAF83A5FAfc3adE54418941B83233320852C - Account 2
Tenant - Bob - Address: 0x21D30B7B2Dd00879fB7f1F264384F60f0F118A6A - Account 3

Key Features:

1. The website can be translated to multiple languages
2. The property location can be tagged to it's Digital Identity
3. Coinbase exchange is used to transform local currency to Ethers

Technical Stack:

Front End - HTML, CSS, Javascript
Back End - Node.js
Blockchain Platform - Ethereum
Smart Contracts - Solidity (Deployed using remix.ethereum.org at Contract Address: 0x4d408908e19f15675ab82230eb647b49fc7060b2)
Blockchain Explorer: Etherscan
Blockchain Network: Kovan (Public Testnet)
Consensus: Proof of Authority
Wallet - Metamask Chrome Extension
IDE - Visual Studio Code
OS - Ubuntu 19.10
Repository - GitHub

Steps to locally run the application:

1. npm install - Install all dependencies
2. npm build - Building the application
3. npm run dev - Locally deploy and run the application

Important Definitions:

1. Ethereum: It is an open source, public, blockchain-based distributed computing platform and operating system featuring smart contract functionality. It supports a modified version of Nakamoto consensus via transaction-based state transitions. 
2. Smart Contracts: A smart contract is a computer protocol intended to digitally facilitate, verify, or enforce the negotiation or performance of a contract. Smart contracts allow the performance of credible transactions without third parties.These transactions are trackable and irreversible.
3. Metamask Wallet: It is a self-hosted wallet to store, send and receive ETH and ERC20. It allows you to control your funds as it is an HD wallet that provides a mnemonic phrase that you can keep as a backup.
4. Kovan: It is a new testnet for Ethereum using Parity's Proof of Authority consensus engine, with benefits over Ropsten: Immune to spam attacks (as Ether supply is controlled by trusted parties).
5. DApp: A decentralized application is a computer application that runs on a distributed computing system. 

Scope of Improvement:

1. Smart Contracts can hold the Security Deposit in an Escrow Account and release it when the Contract Expires or when the parties involved provide their approval. This amount can be invested in a Decentralized Finance platforms to generate positive returns.
2. Rental Agreement online documents can be generated and stored on IPFS(InterPlanetary File System). It is a protocol and peer-to-peer network for storing and sharing data in a distributed file system. IPFS uses content-addressing to uniquely identify each file in a global namespace connecting all computing devices.
3. Once the proposed duration ends, smart contract terminates automatically.
4. The application can be integrated with property applications like Myvilla and can be extended for Buying/Selling properties as well.
5. The application can be used for rent payments and other flow of funds (e.g. maintenance of ad-hoc repairs). Tenancy can be integrated with community apps like 'Real Cube'.
6. No crypto-currency is used for processing payments, instead contracts interface directly with banking systems to process payments in real fiat currencies (USD, EUR, GBP etc).

Disclaimer:

1. This application is just a Proof of Concept(PoC) and cannot be used in any government trials and procedures.
2. The project will be scrapped after demonstration to 'Exalogic Consulting'.

References:

https://files.ifi.uzh.ch/CSG/staff/Rafati/Purchase-Rental-APP-SC.pdf
https://github.com/shankermjj/Rental-Agreement
https://midasium.herokuapp.com/smart-tenancy
https://medium.com/@anudishjain/chartercontracts-998050251176
https://medium.com/@naqvi.jafar91/converting-a-property-rental-paper-contract-into-a-smart-contract-daa054fdf8a7
