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


import {Schnorr_verify} from  "@solidity/protocols/FCL_schnorr.sol"; 


contract FCL_schnorr_stark{


/* basic shamir's trick */
   function verify(bytes32 message, uint256 r, uint256 s, uint256 qx, uint256 qy) external view returns (bool) {
        return Schnorr_verify(message, r, s , qx,  qy);
    }



}
