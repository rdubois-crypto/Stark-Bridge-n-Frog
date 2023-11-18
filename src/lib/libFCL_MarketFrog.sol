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
///* DESCRIPTION: Market Frog
///*  
///*
//**************************************************************************************/
// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19 <0.9.0;



import { p, gx, gy, n, pMINUS_2, nMINUS_2 } from "@solidity/include/FCL_field.h.sol"; 
import { nModInv } from "@solidity/modular/FCL_modular.sol"; 
import {ec_mulmuladdX} from  "@solidity/include/FCL_ecmulmuladd.h.sol"; 


import {Schnorr_verify} from  "@solidity/protocols/FCL_schnorr.sol"; 

uint constant _COMMON_RARITY=1;
uint constant _RARE_RARITY=10;
uint constant _EPIC=100;
uint constant _LEGENDARY=1000;
uint constant _MYTHIC=5000;


struct Frog {
    uint frogID;
    uint biome;
    uint jump;
    uint intelligence;
    uint beauty;
    uint speed;
    
}


contract FCL_MarketBridge{
   
   // Mapping from address to uint
   mapping(address => uint) public FrogMap;
   mapping(address => uint) public CommitMap;


   //get rarity from ID
   function get_rarity(uint frogID) internal pure returns (uint rarity){
      if(frogID<41)
      {
         return 1;
      }



   }

   //how to check that a frog is not commited twice ? We could imagine a fraud proof mechanism using L2<->L2 message
   function importFrog() external view returns (bool) {
        
   }
   	
   function MoveFrog() public view returns (bool){
   
   }
  
   //You get FROG tokens by sacrificing frogs
   function SacrificeFrog() public view returns (bool){
   
   }
   
   

}
