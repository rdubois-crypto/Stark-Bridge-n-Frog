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
import {random_ctx, FCL_RandomUint256_Generate} from "@solidity/include/FCL_DRNG.h.sol";


uint constant _COMMON=1;
uint constant _RARE=10;
uint constant _EPIC=100;
uint constant _LEGENDARY=1000;
uint constant _MYTHIC=5000;
uint constant _MASKDRNG=0x3ff;
uint constant _BONUS_DEFENDER=2;
uint constant _BATTLE_RANDSPREAD=8;

struct Frog {
    uint TimeStampSigned;//when the PDC was issued
    uint frogID;
    uint biome;
    uint jump;
    uint intelligence;
    uint beauty;
    uint speed;
    address owner;
}


contract FCL_Amphibius{
   
   // Mapping from address to uint
   mapping(uint => address) public FrogMap;   //who that frogs belongs, associate iD to owner's address
   mapping(uint => Frog) public StakeMap; //associate Staking slot to a frog
   mapping(uint => Frog) public WitheringVoid;//associate Withering Void with a trapped Frog 
   uint WitheringVoidSize;//number of poor sacrificed frogs to Apocalypse Frog
   random_ctx RandCtx; // A random generator state

   //get rarity from ID
   function get_rarity(uint frogID) internal pure returns (uint rarity){
      if(frogID<41)
      {
         return _COMMON;
      }
      if(frogID<56){
          return _RARE;
      }
      if(frogID<61)
      {
         return _EPIC;
      }
      if(frogID<63)
      {
         return _LEGENDARY;
      }
      if(frogID==63)
      {
         return _MYTHIC;
      }
      if(frogID<67)
      {
         return _LEGENDARY;
      }
      if(frogID==67)
      {
         return _MYTHIC;
      }
      if(frogID<71)
      {
         return _LEGENDARY;
      }
      
      return _RARE;
   }

   //how to check that a frog is not commited twice ? We could imagine a fraud proof mechanism using L2<->L2 message
   function importFrog() external view returns (bool) {
        
   }

   //Send a Frog to another player, shame on u slaver !	
   function SellFrog() public view returns (bool){
   
   }
   
   
   //for now battle is quite simple and no risk for the attacker
   function BattleFrog(Frog memory Contender, Frog memory Challenger) public {
   	uint256 attack_roll;
   	(RandCtx, attack_roll)=FCL_RandomUint256_Generate(RandCtx);
      attack_roll=attack_roll%_BATTLE_RANDSPREAD;

   	uint256 def_roll;
   	
   	
   	(RandCtx, def_roll)=FCL_RandomUint256_Generate(RandCtx);
   	def_roll=(def_roll%_BATTLE_RANDSPREAD)+_BONUS_DEFENDER;
   	attack_roll=attack_roll+Challenger.jump+Challenger.intelligence+Challenger.speed;
   	def_roll=def_roll+Challenger.jump+Challenger.intelligence+Challenger.speed;
   	
   	if(attack_roll>def_roll){
   	  StakeMap[Contender.frogID]=Challenger;
   	}
   	
   } 
   
   //try to save a frog from the Void, probability will depends of number of frogs in the void
   function SaveFrog(address savior) internal{
   	uint256 random;
	(RandCtx, random)=FCL_RandomUint256_Generate(RandCtx);
	Frog memory F;
	
	//if random is high enough, save a random frog from Void
	if((random&uint256(_MASKDRNG))>1023-WitheringVoidSize)
	{
		random=random%WitheringVoidSize;//as random is 256 bits, bias in distribution is negligible here
		F=WitheringVoid[random];
		delete(WitheringVoid[random]);
	}
	FrogMap[F.frogID]=savior;
   }

   //You get FROG tokens by sacrificing frogs
   function SacrificeFrogValue(Frog memory F) public pure returns (uint256){
      return get_rarity(F.frogID)*(5*F.intelligence+10*F.beauty);
   }
   
   //look at StakeMap, if empty, StakeFrog
   function StakeFrog(Frog memory F) internal{
      if(StakeMap[F.frogID].frogID!=0){//if the slot is free, 
         StakeMap[F.frogID]=F;
      }
      else{//here will happen a BATTLE of FROGS !!!
	BattleFrog(StakeMap[F.frogID], F);
      }
   }

}
