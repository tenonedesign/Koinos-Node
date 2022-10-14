# Koinos-Node
Mac app for running a full Koinos node.  Requires macOS 10.11 El Capitan, Docker Desktop, and Git.  More information about Koinos may be found at [Koinos.io](https://koinos.io) and [GitHub](https://github.com/koinos/koinos).

## Install Koinos Node

Download the disk image for the latest tag, open the image, then drag the app to your Applications folder.  If necessary, it will prompt you to install Docker Desktop and Git.

## Configure your node for mining

It’s easy to mine Koin using your node.  You’ll need to have an existing Koinos wallet with VHP (more is better).
 - Paste your wallet’s address into the Koinos Node miner preferences
 - Click the "Generate new key pair" button to create a new private and public key for your miner.
 - Open the Koinos CLI wallet and enter the following commands
    - `connect https://api.koinosblocks.com/`
    - `open "/Users/your-username/your-koinos-wallet" your-wallet-password`
    - `register pob 198RuEouhgiiaQm7uGfaXS6jqZr6g6nyoR` (this contract address may change for mainnet)
    - `pob.register_public_key <your-wallet-address> <public-key-from-Koinos-Node-preferences>`
    
Start the node, and you’re done.
