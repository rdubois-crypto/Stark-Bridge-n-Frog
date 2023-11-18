# Stark-Bridge-n-Frog
Multichain Swap using Starkcurve over any EVM Layer and Starknet


## Frogchitecture

![image](https://github.com/rdubois-crypto/Stark-Bridge-n-Frog/assets/103030189/0fa55d18-6358-41e0-a1e9-f2b8cc650ffd)


## What the frog did we ?

We implemented an optimized solidity version of the starkcurve, the Starknet native Curve. We build a Schnorr mechanism scheme on top.
Scheme signatures enables MPC, but also atomic swap, enabling private exchange of tokens between chain, building a Permisionless bridge.
Atomic Swaps are very well described here:
https://medium.com/crypto-garage/adaptor-signature-on-schnorr-cross-chain-atomic-swaps-3f41c8fb221b

We did this by using our FCL implementation as described in https://eprint.iacr.org/2023/939, then optimized it further for the specific shape
of starkcurve. We had the fastest EIP7212 implementation, now we brought the fastest starkcurve implementation.

## So what about Frogs?

As explained, atomic swaps enables to transfer tokens, in our game design, we plan to burn and mint frog to distribute $CROACROA tokens.
![image](https://github.com/rdubois-crypto/Stark-Bridge-n-Frog/assets/103030189/1a8d66ba-e746-4886-ab48-ead2935eb0aa)

So we minted frogs to opensea buy verifying the zkPCDproof develooped by the EF (verifier.sol).
Only after verifying the validity of the Frog, we minted it resoecting ERC721 standard:

https://testnets.opensea.io/assets/sepolia/0x9dea353bbca84a12d6b49f16c415e616a2e08fa1/111674470498115766391113688046808700390558580121109134455450395313003599686822

## 





