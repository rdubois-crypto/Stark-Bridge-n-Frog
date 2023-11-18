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

struct random_ctx{
 uint256 state;
}

/* A basic DRNG */
function FCL_Random_Init(bytes memory random_initiator) view returns (random_ctx memory RandomCtx) 
{
 RandomCtx.state=uint256(keccak256(random_initiator))^block.prevrandao;
 return RandomCtx;
}


function FCL_Random_Update(bytes memory random_updater, random_ctx memory RandomCtx) view returns (random_ctx memory NewRandomCtx) 
{
 RandomCtx.state=RandomCtx.state ^uint256(keccak256(random_updater))^block.prevrandao;
 return RandomCtx;
}

function FCL_RandomUint256_Generate( random_ctx memory RandomCtx) view returns (random_ctx memory NewRandomCtx, uint256 rand)
{
  rand=uint256(keccak256(abi.encodePacked(RandomCtx.state)))^block.prevrandao;
  NewRandomCtx=FCL_Random_Update(bytes("Update"),RandomCtx);
}

