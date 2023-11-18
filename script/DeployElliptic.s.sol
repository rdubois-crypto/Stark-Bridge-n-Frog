// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19 <0.9.0;


import {BaseScript} from "./BaseScript.sol";

/*
import { p, gx, gy, n, pMINUS_2, nMINUS_2 } from "@solidity/include/FCL_field.h.sol"; 
import { nModInv } from "@solidity/modular/FCL_modular.sol"; 
import {ec_mulmuladdX} from  "@solidity/include/FCL_ecmulmuladd.h.sol"; 
import {Schnorr_verify, Schnorr_sign} from  "@solidity/protocols/FCL_schnorr.sol"; 
import {ec_scalarmulN} from "@solidity/include/FCL_elliptic.h.sol";
*/

import {Schnorr_verify, Schnorr_sign} from  "@solidity/protocols/FCL_schnorr.sol"; 


contract FCL_Stark {
  function SchnorrSign(bytes32 message, uint256 kpriv) public view returns (uint256 s, uint256 e) {
        return Schnorr_sign(message, kpriv);
    }

/* basic shamir's trick */
   function SchnorrVerify(bytes32 message, uint256 r, uint256 s, uint256 qx, uint256 qy) public view returns (bool) {
        return Schnorr_verify(message, r, s , qx,  qy);
    }
/*
    //Naive multiplication over starkcurve
    function ecMul(uint256 scalar_u, uint256 Px, uint256 Py ) public view returns (uint256 x, uint256 y){
        return ec_scalarmulN(scalar_u, Px, Py);
    }

    //Optimized double multiplicatoin over starkcurve
    function ecMulmuladd(uint256 scalar_u, uint256 Px, uint256 Py ) public view returns (uint256 x, uint256 y){
        return ec_scalarmulN(scalar_u, Px, Py);
    }*/
}


contract Script_Deploy_FCL_all is BaseScript {
    function run() external broadcast returns (address addressOfLibrary) {
        // deploy the library contract and return the address
        addressOfLibrary = address(new FCL_Stark{salt:0}());
    }
}

/*
    In the tests/WebAuthn_forge/script directory, run the following command to deploy the library:

    ℹ️ RUN THIS SCRIPT USING A LEDGER:
    forge script DeployElliptic.s.sol:MyScript --rpc-url <RPC_URL> --ledger --sender <ACCOUNT_ADDRESS> \
    [--broadcast]

    ℹ️ RUN THIS SCRIPT WITH AN ARBITRARY PRIVATE KEY (NOT RECOMMENDED):
    PRIVATE_KEY=<PRIVATE_KEY> forge script DeployElliptic.s.sol:MyScript --rpc-url <RPC_URL> [--broadcast]

    ℹ️ RUN THIS SCRIPT ON ANVIL IN DEFAULT MODE:
    forge script DeployElliptic.s.sol:MyScript --rpc-url http://127.0.0.1:8545 --broadcast --sender \
    0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 --mnemonics "test test test test test test test test test test test junk"

    ℹ️ CALL THE LIBRARY ONCE DEPLOYED:
    cast call <CONTRACT_ADDRESS> verify(bytes32,uint256,uint256,uint256,uint256)" <MESSAGE> <R> <S> <QX> <QY>

  
*/
/*related PR:*/
/*related PR:*/
/*related PR:*/
/*related PR:*/
/*related PR:*/
