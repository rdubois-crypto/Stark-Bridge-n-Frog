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


//choose the elliptic library to import

import { p, gx, gy, n, pMINUS_2, nMINUS_2, MINUS_1 } from "@solidity/include/FCL_field.h.sol";
//import { ec_Aff_Add} from "@solidity/elliptic/SCL_am3sw.sol"; //minimal version for libsecp256r1 without prec
import { ec_Dbl} from "@solidity/elliptic/FCL_am3sw.sol";
import { ec_AddN,  ec_Add, ec_Normalize, ecAff_IsZero} from "@solidity/elliptic/FCL_gensw.sol";
import{ec_scalarmulN, ec_Aff_Add, ec_TestEq, ec_SetPrec8 as ec_SetPrec, ecAff_isOnCurve,  ec_scalarPow2mul} from "@solidity/elliptic/FCL_ecutils.sol";

