# Stark-Bridge-n-Frog
Multichain Swap using Starkcurve over any EVM Layer and Starknet

Hackaton Istanbul EthGlobal 11/23.


## Compiling and testing

This is a forge repo. Just type forge test at root folder.

The test of the stark curve has been made using the sagemath code of FCL. The one that allow us to break the DNA challenge of CTF Eth Lisbonn. 
with a baby step giant step over starkcurve.






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
* https://sepolia-blockscout.scroll.io/address/0x84655393c2D6492a5eb41Bb0d2c2ee3f29360c17
### No Create2 chain
* stylus [0xbBc76f5b09462e397FBA811E1aAa738874bCD839](https://stylus-testnet-explorer.arbitrum.io/address/0xbBc76f5b09462e397FBA811E1aAa738874bCD839/contracts#address-tabs)

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

## Starkcurve commands

The following commands provide an example of a successfull signing/verifying sequence. One can easily tweak the inputs for additional tests.

(Same sequence as in libFCL.stark.t.sol).

SCROLL_RPC=https://scroll-sepolia.blockpi.network/v1/rpc/public

FCLSTARK_ADDRESS=0x84655393c2D6492a5eb41Bb0d2c2ee3f29360c17 #This FCLStark available on Scroll(sepolia), mantle, celo, OP, polygon testnets

RPC=$SCROLL_RPC

MESSAGE=0x1e6dfaf38752b25a1eb0c2c57b12b9099edcba342f79159679e20f5c3c28d379

KPRIV=0x800000000000010ffffffffffffffffb781126dcae7b2321e66a241adc64d23 
 
KPUBx=0x66276b22edf076517b8fa9287280242555afda9ed00e78eedc9f99be8542aa3

KPUBy=0x2782b3e9bd943e5db3bece635cde338cdaca652c3643b9a1cf146f875a3ffd7

SIG_S=0x1f0f9fabe88886318f61016eb335fe0a2fd7d34f4a287d130eecae7e54a4c91

SIG_E=0x24ad5d150c53c817cc16786ed19ed9582bd77470f07fd94d45066d6308b1bdb

cast call --trace --verbose --legacy --rpc-url $RPC $FCLSTARK_ADDRESS "SchnorrSign(bytes32,uint256)" $MESSAGE $KPRIV

cast call --trace --verbose --legacy --rpc-url $RPC 0x84655393c2D6492a5eb41Bb0d2c2ee3f29360c17 "SchnorrVerify(bytes32, uint256, uint256, uint256, uint256)" $MESSAGE $SIG_S $SIG_E $KPUBx $KPUBy






