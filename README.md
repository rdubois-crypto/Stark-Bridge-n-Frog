# Stark-Bridge-n-Frog
Multichain Swap using Starkcurve over any EVM Layer and Starknet


## Frogchitecture

![image](https://github.com/rdubois-crypto/Stark-Bridge-n-Frog/assets/103030189/0fa55d18-6358-41e0-a1e9-f2b8cc650ffd)


## What the frog did we ?

We implemented an optimized solidity version of the starkcurve, the Starknet native Curve. We build a Schnorr mechanism scheme on top.
Scheme signatures enables MPC, but also atomic swap, enabling private exchange of tokens between chain, building a Permisionless bridge.
Atomic Swaps are very well described here:
https://medium.com/crypto-garage/adaptor-signature-on-schnorr-cross-chain-atomic-swaps-3f41c8fb221b

We deployed using create2, so the address is the same on all networks:
### First batch
* https://sepolia.etherscan.io/address/0xd308678e13f435f55292a76ad7abd45a844aa4f4#code
* https://explorer.goerli.linea.build/address/0xd308678E13f435f55292A76AD7aBD45A844aa4F4/contracts#address-tabs
* https://goerli.basescan.org/address/0xd308678e13f435f55292a76ad7abd45a844aa4f4#code

### Second batch
* https://testnet.mantlescan.org/address/0x84655393c2D6492a5eb41Bb0d2c2ee3f29360c17
* https://explorer.celo.org/alfajores/address/0x84655393c2D6492a5eb41Bb0d2c2ee3f29360c17/contracts#address-tabs
* optimism-testnet (todo: find link)
* https://mumbai.polygonscan.com/address/0x84655393c2d6492a5eb41bb0d2c2ee3f29360c17#code
* scroll testnet ?

We did this by using our FCL implementation as described in https://eprint.iacr.org/2023/939, then optimized it further for the specific shape
of starkcurve. We had the fastest EIP7212 implementation, now we brought the fastest starkcurve implementation.

## So what about Frogs?

As explained, atomic swaps enables to transfer tokens, in our game design, we plan to burn and mint frog to distribute $CROACROA tokens.
![image](https://github.com/rdubois-crypto/Stark-Bridge-n-Frog/assets/103030189/1a8d66ba-e746-4886-ab48-ead2935eb0aa)

So we minted frogs to opensea buy verifying the zkPCDproof develooped by the EF (verifier.sol).
Only after verifying the validity of the Frog, we minted it resoecting ERC721 standard:

https://testnets.opensea.io/assets/sepolia/0x9dea353bbca84a12d6b49f16c415e616a2e08fa1/111674470498115766391113688046808700390558580121109134455450395313003599686822

![image](https://github.com/rdubois-crypto/Stark-Bridge-n-Frog/assets/103030189/b9249102-2ed2-4def-a376-4c5a5c4c151d)

## What's next, what is the retex ?

Damn those frogs are so fun, i couldn't resist to chase two rabbits. I want the whole game working, for the moment you have a starkcurve. But I can't wait to see them battlle.





