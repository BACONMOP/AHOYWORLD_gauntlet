/*
@filename: fn_vSetup02.sqf
Author:

	???
	
Last modified:

	22/10/2014 ArmA 1.32 by Quiksilver
	
Description:

	Apply code to vehicle
	vSetup02 deals with code that is already applied where it should be.
_______________________________________________*/

//============================================= CONFIG

private ["_u","_t"];

_u = _this select 0;
_t = typeOf _u;

if (isNull _u) exitWith {};

//============================================= ARRAYS

_ghosthawk = ["B_Heli_Transport_01_camo_F","B_Heli_Transport_01_F"]; 			// ghosthawk
_strider = ["I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"];					// strider
_blackVehicles = ["B_Heli_Light_01_armed_F"];									// black skin
_wasp = ["B_Heli_Light_01_F","B_Heli_Light_01_armed_F"];						// MH-9
_orca = ["O_Heli_Light_02_unarmed_F"];											// Orca
_mobileArmory = ["B_Truck_01_ammo_F"];											// Mobile Armory
_noAmmoCargo = ["B_APC_Tracked_01_CRV_F","B_Truck_01_ammo_F"];					// Bobcat CRV
_slingHeli = ["I_Heli_Transport_02_F","B_Heli_Transport_01_camo_F","B_Heli_Transport_01_F"];											// sling capable
_slingable = ["B_Heli_Light_01_F"];												// slingable
_notSlingable = ["B_Heli_Light_01_armed_F", "B_Heli_Attack_01_F"];				// not slingable
_dropHeli = ["B_Heli_Transport_01_camo_F","B_Heli_Transport_01_F"]; 			// drop capable
_uav = ["B_UAV_02_CAS_F","B_UAV_02_F","B_UGV_01_F","B_UGV_01_rcws_F"];			// UAVs
_ammoBox = ["Box_NATO_AmmoVeh_F"];												// Ammobox

//============================================= SORT

if (_t in _mobileArmory) then {
		[_u] execVM "scripts\VAserver.sqf";
};

if (_t in _ammobox)	then {
		_u addWeaponCargoGlobal ["Binocular", 5];
		_u addMagazineCargoGlobal ["150Rnd_762x54_Box", 15];
		_u addMagazineCargoGlobal ["20Rnd_762x51_Mag", 15];
		_u addWeaponCargoGlobal ["arifle_MX_F", 5];
		_u addWeaponCargoGlobal ["arifle_MX_GL_ACO_F", 5];
		_u addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 15];
		_u addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer", 15];
};

//===== Add to Zeus

{_x addCuratorEditableObjects [[_u],false];} count allCurators;

