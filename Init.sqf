/*
| Author: 
|
|	Pfc.Christiansen
|_____
|
|   Description: Init for server\player
|	
|	Created: 1.December 2014
|	Last modified: 17. March 2015 By: Pfc.Christiansen Reason: Added EH for respawnWave
|	Made for AhoyWorld.
*/



//---------------------------------- Variables and settings

enableSaving [false,false];
DAC_Basic_Value = 0;execVM "DAC\DAC_Config_Creator.sqf"; // DAC
call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";		// revive

for [ {_i = 0}, {_i < count(paramsArray)}, {_i = _i + 1} ] do {
	call compile format
	[
		"PARAMS_%1 = %2",
		(configName ((missionConfigFile >> "Params") select _i)),
		(paramsArray select _i)
	];
};


//---------------------------------- Server Script Calls
if (isServer) then 
{			

			execVM "scripts\misc\Supply_Box_Refiller.sqf";					    // Supply Depot Reloader
			execVM "scripts\core\main.sqf";												    // Mission selector engine
			execVM "scripts\core\AI_Machine.sqf";									    // Ambient AI
			execVM "scripts\core\ambient_heli.sqf";								    // Ambient Airpatrols
			execVM "scripts\misc\clean.sqf";												    // Cleanup script

	
};

//---------------------------------- Time Of Day
if isServer then {definedTime = (paramsArray select 0)};
if isServer then {skipTime definedTime;};

waitUntil {!isNull player};

//----------------------------------Stuff for player-end


if !(isServer) then {
	null = [] execVM "scripts\misc\diary.sqf";					//Diary
};

//EHs
"GlobalHint" addPublicVariableEventHandler
{
	private ["_GHint"];
	_GHint = _this select 1;
	hint parseText format["%1", _GHint];
};

//---------------------------------- Check for Gamenight Param
		GAMENIGHT = "Gamenight" call BIS_fnc_getParamValue;
		publicVariable "Gamenight";
		if (GAMENIGHT == 1 ) then 
		{ 					
			[] execVM "CSSA3\CSSA3_init.sqf";  //Spectator script
			[] execVM "scripts\core\waveRespawn.sqf"; // Respawned when current mission ends.
			sleep 5;
			setPlayerRespawnTime  9999999; // Set respawn time to infinite for the spec script to work.
		}
		else 
		{
															
			[] execVM "scripts\misc\VA.sqf";  //Add VA to box in spawn
															
		};

