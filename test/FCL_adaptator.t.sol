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
///* DESCRIPTION: simulating a Swap
///*  
///*
//**************************************************************************************/
// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19 <0.9.0;


import { p, gx, gy, n, pMINUS_2, nMINUS_2 } from "@solidity/include/FCL_field.h.sol"; 
import { nModInv } from "@solidity/modular/FCL_modular.sol"; 

import {_STARKCURVE} from "@solidity/include/FCL_mask.h.sol";
import {FIELD_OID} from "@solidity/include/FCL_field.h.sol";
import {ec_mulmuladdX} from "@solidity/include/FCL_ecmulmuladd.h.sol";
import {ec_scalarmulN} from "@solidity/include/FCL_elliptic.h.sol";
import {Schnorr_sign, Schnorr_verify} from "@solidity/protocols/FCL_schnorr.sol";

import "forge-std/Test.sol";

import "@solidity/lib/libFCL_starkSchnorr.sol";

import {random_ctx , FCL_RandomUint256_Generate } from "@solidity/include/FCL_DRNG.h.sol";


contract FCL_AdaptatorTest is Test {
  random_ctx RandCtx;
  
  //we admit having an Offline implementation of Musig2 for now, providing couples (kpriv, nonce) to both participants
  /*
  function Musig2Oracle() public returns (uint256 secA, uint256 secB, uint256 rA, uint256 rb, uint256 Rx, uint256 Px)
  { 
    (RandCtx, rA)=FCL_RandomUint256_Generate(RandCtx);
    (RandCtx, rB)=FCL_RandomUint256_Generate(RandCtx);
    
    //slow version to derive key
    (QAx, QAy)=ec_scalarmulN(rA, gx, gy);
    (QBx, QBy)=ec_scalarmulN(rB, gx, gy);
    (Rx, Ry)=ec_AddAff();
    
  }

  function test_FCLAdaptator() public returns (bool){

    


  }
  
*/

}
