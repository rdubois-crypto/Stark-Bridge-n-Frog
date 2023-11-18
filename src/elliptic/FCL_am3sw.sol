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
///* FILE: FCL_elliptic.sol
///*
///*
///* DESCRIPTION: modified XYZZ system coordinates for EVM elliptic point multiplication
///*  optimization
///*
//**************************************************************************************/
// SPDX-License-Identifier: MIT


pragma solidity >=0.8.19 <0.9.0;
 	

import { p, gx, gy, n, pMINUS_2, nMINUS_2 } from "src/include/FCL_field.h.sol"; 
import{ec_AddN, ecAff_IsZero, ec_Normalize} from "src/elliptic/FCL_gensw.sol";
import { pModInv } from "src/modular/FCL_modular.sol"; 

 /* @dev Sutherland2008 doubling
 /* The "dbl-2008-s-1" doubling formulas */
function ec_Dbl(uint256 x, uint256 y, uint256 zz, uint256 zzz)
       pure
        returns (uint256 P0, uint256 P1, uint256 P2, uint256 P3)
    {
        unchecked {
            assembly {
                P0 := mulmod(2, y, p) //U = 2*Y1
                P2 := mulmod(P0, P0, p) // V=U^2
                P3 := mulmod(x, P2, p) // S = X1*V
                P1 := mulmod(P0, P2, p) // W=UV
                P2 := mulmod(P2, zz, p) //zz3=V*ZZ1
                zz := mulmod(3, mulmod(addmod(x, sub(p, zz), p), addmod(x, zz, p), p), p) //M=3*(X1-ZZ1)*(X1+ZZ1)
                P0 := addmod(mulmod(zz, zz, p), mulmod(pMINUS_2, P3, p), p) //X3=M^2-2S
                x := mulmod(zz, addmod(P3, sub(p, P0), p), p) //M(S-X3)
                P3 := mulmod(P1, zzz, p) //zzz3=W*zzz1
                P1 := addmod(x, sub(p, mulmod(P1, y, p)), p) //Y3= M(S-X3)-W*Y1
            }
        }
        return (P0, P1, P2, P3);
    }


  /* homogeneous addition (handles the double case), TBD*/
  function ec_hAdd(uint256 x1, uint256 y1, uint256 zz1, uint256 zzz1, uint256 x2, uint256 y2, uint256 zz2, uint256 zzz2)  pure returns (uint256 x3, uint256 y3, uint256 zz3, uint256 zzz3)
  {


  }

