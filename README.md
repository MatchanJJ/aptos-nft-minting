# NFT Minting Project

A sequential NFT minting smart contract for the Aptos blockchain.

## Environment Setup

This guide walks you through setting up the development environment and deploying the NFT minting contract.

### Prerequisites

- [Aptos CLI](https://aptos.dev/cli-tools/aptos-cli-tool/install-aptos-cli)
- [Git](https://git-scm.com/downloads) (optional, for version control)
- [NodeJS](https://nodejs.org/) (optional, for frontend development)

## Project Setup

### Create a New Project

```bash
# Create a new Move project with your desired name
aptos move init --name nft-mint

# Navigate to the project directory
cd nft-mint
```

### Configure Your Aptos Account

```bash
# Initialize Aptos configuration
aptos init
```

During initialization:
- Choose your network (devnet, testnet, or mainnet)
- Create a new account or import an existing one

This creates a `.aptos` folder with your configuration and keys.


## Development

### Updating Dependencies

Ensure your `Move.toml` has the correct dependencies:

```toml
[package]
name = "nft-mint"
version = "1.0.0"

[addresses]
matchan_addr = "YOUR_ADDRESS_PLACEHOLDER"

[dependencies]
AptosFramework = {git = "https://github.com/aptos-labs/aptos-framework.git", subdir = "aptos-framework", rev = "mainnet"}
AptosTokenObjects = {git = "https://github.com/aptos-labs/aptos-framework.git", subdir = "aptos-token-objects", rev = "mainnet"}
```

### Writing the Smart Contract

Create your NFT contract in `sources/myNFT.move` with the following core functions:
- `init`: Initialize the counter (owner only)
- `create_collection`: Create an NFT collection
- `mint_token`: Mint a new token with sequential numbering

## Testing

Run tests to verify your contract functionality:

```bash
# Run all tests
aptos move test
```

Create custom tests in the `tests/` directory to validate specific behaviors.

## Deployment

### Compile Your Contract

```bash
# Compile the Move modules
aptos move compile
```

### Publish to the Blockchain

```bash
# Deploy your contract to the blockchain
aptos move publish
```

## Usage

After deployment, interact with your contract:

### Initialize the Counter (Owner Only)

```bash
aptos move run --function-id YOUR_ADDRESS::NFTMinterV3::init
```

### Create a Collection

```bash
aptos move run --function-id YOUR_ADDRESS::NFTMinterV3::create_collection
```

### Mint an NFT

```bash
aptos move run --function-id YOUR_ADDRESS::NFTMinterV3::mint_token
```

## Troubleshooting

### Common Issues

1. **Dependency errors**: Check your `Move.toml` for correct dependencies
2. **Address errors**: Ensure addresses in code match your Aptos account
3. **Permission errors**: Verify you have the proper permissions for restricted functions

### Resources

- [Aptos Documentation](https://aptos.dev/)
- [Move Language Reference](https://move-language.github.io/move/)
- [Aptos Discord](https://discord.gg/aptoslabs)

## License

MIT