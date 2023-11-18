//********************************************************************************************/
//  ___           _       ___               _         _    _ _
// | __| _ ___ __| |_    / __|_ _ _  _ _ __| |_ ___  | |  (_) |__
// | _| '_/ -_|_-< ' \  | (__| '_| || | '_ \  _/ _ \ | |__| | '_ \
// |_||_| \___/__/_||_|  \___|_|  \_, | .__/\__\___/ |____|_|_.__/
//                                |__/|_|
///* Copyright (C) 2022 - Renaud Dubois - This file is part of FCL (Fresh CryptoLib) project
///* License: This software is licensed under MIT License
///* This Code may be reused including license and copyright notice.
///* See LICENSE file at the root folder of the project.
///* FILE: FCL_schnorr.sol
///*
///*
///* DESCRIPTION: Schorr minimal protocol
///*  
///*
//**************************************************************************************/
// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19 <0.9.0;

import { p, gx, gy, n, pMINUS_2, nMINUS_2 } from "@solidity/include/FCL_field.h.sol"; 
import { nModInv } from "@solidity/modular/FCL_modular.sol"; 
import {ec_mulmuladdX} from  "@solidity/include/FCL_ecmulmuladd.h.sol"; 




function Schnorr_verify(bytes32 message, uint256 s, uint256 e, uint256 qx, uint256 qy) view returns (bool) 
{
    uint256 rxv=ec_mulmuladdX( qx, qy, s, e) ;//sG+eQ
    uint256 ev=addmod(uint256(sha256(abi.encodePacked(rxv, message ))),0,n);//H(r||M)

    return (ev==e);
}

/******************* OFF CHAIN FUNCTIONS (sensitive data)*/
/* Warning : Offchain code is not meant to be used with funds ! It is for demonstration/testing only as private keys shall never
exist on chain*/
function Schnorr_sign(bytes32 message, uint256 kpriv) view returns
(uint256 s, uint256 e)
{
 //randomness is deterministically derived as in eddsa
 uint256 k=addmod(uint256(sha256(abi.encodePacked(kpriv, message ))),0,n);

 uint256 rx=ec_mulmuladdX( 0,0,k, 0) ;//kG
 e=addmod(uint256(sha256(abi.encodePacked(rx, message ))),0,n);//H(r||M)

 s=addmod( k, n-mulmod(kpriv, e,n), n);//k-xe

 return (s,e);
}




//version using an ecrecover as oracle for the mul for the verification 
//WIP, do not use
/*
function schnorr_verify_oraclemul(bytes32 message, uint256 s, uint256 e, uint256 qx, uint256 qy, uint256 oracle_r) view returns (bool) 
{
    uint256 h=ecmulmuladd_oracle( qx, qy, s, e) ;
    //todo check that oracle didn't lie
   
    uint256 ev=uint256(sha256(abi.encodePacked(oracle_r, message)));

    return false;//WIP
    return (ev==e);
}
*/
