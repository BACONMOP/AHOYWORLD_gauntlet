/*
@filename: initPlayerLocal.sqf
Author:
	
	Quiksilver

Last modified:

	11/06/2015 by BACONMOP
	
	For use in Gauntlet
	
Description:

	Client scripts and event handlers.
______________________________________________________*/

enableSentences FALSE;															
enableSaving [FALSE,FALSE];
player enableFatigue FALSE;

//------------------------------------------------ Handle parameters

for [ {_i = 0}, {_i < count(paramsArray)}, {_i = _i + 1} ] do {
	call compile format
	[
		"PARAMS_%1 = %2",
		(configName ((missionConfigFile >> "Params") select _i)),
		(paramsArray select _i)
	];
};


_null = [] execVM "scripts\restrictions.sqf"; 									// gear restrictions and safezone
_null = [] execVM "scripts\pilotCheck.sqf"; 									// pilots only
_null = [] execVM "scripts\icons.sqf";											// blufor map tracker Quicksilver

[] call QS_fnc_respawnPilot;


enableEngineArtillery false;
if (player isKindOf "B_support_Mort_f") then {
	enableEngineArtillery true;
};
if (player isKindOf "B_support_AMort_F") then {
	enableEngineArtillery true;
};


_infoArray = squadParams player;    
_infoSquad = _infoArray select 0;
_squad = _infoSquad select 1;
_infoName = _infoArray select 1;
_name = _infoName select 1; 
_email = _infoSquad select 2;


// replace line below with your Squad xml's email
if (_email == "arma@ahoyworld.co.uk") then {

GlobalHint = format["<t align='center' size='2.2' color='#FF0000'>%1<br/></t><t size='1.4' color='#33CCFF'>%2</t><br/>has joined the server, To get involved in the Ahoy World community, register an account at www.AhoyWorld.co.uk and get stuck in!</t><br/>",_squad,_name];

hint parseText GlobalHint; publicVariable "GlobalHint";
} else {};