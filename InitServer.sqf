/*
@filename: initServer.sqf
Author:
	
	Quiksilver

Last modified:

	11/06/2015 by BACONMOP
	
	For use in Gauntlets
	
Description:

	Server scripts such as missions, modules, third party and clean-up.
	
______________________________________________________*/

//------------------------------------------------ Handle parameters

for [ {_i = 0}, {_i < count(paramsArray)}, {_i = _i + 1} ] do {
	call compile format
	[
		"PARAMS_%1 = %2",
		(configName ((missionConfigFile >> "Params") select _i)),
		(paramsArray select _i)
	];
};

_null = [] execVM "scripts\misc\cleanup.sqf";															// cleanup
adminCurators = allCurators;