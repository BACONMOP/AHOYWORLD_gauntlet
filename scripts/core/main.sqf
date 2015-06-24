

/*
| Author: 
|
|	Pfc.Christiansen
|_____
|
|   Description: 
|	
|	Created: 1.November 2014
|	Last modified: 17. March 2015 By: Pfc. Christiansen Reason: Rewritten to be truly random selected and to not select the same mission twice.
|	Coded for AhoyWorld.
*/

//Check for server and wait for DAC to init
if (!isServer) exitWith {}; 
waituntil{DAC_Basic_Value == 1} ;
sleep 15;

//---------------------------------- Define missions.
_allMissions = [

"capBall",
"capTown",
"depComarray",
"desRadio",
"desTankplt",
"desUAV",
"guerMeet",
"recCache",
"resTruck"


]; 

//---------------------------------- Copy Missionlist.
_missionsRuntime = _allMissions;

//----------------------------------Variables.
KC_MISS = false; 
publicVariable "KC_MISS";
//---------------------------------- Start Main Loop.
while {true} do { 

	waitUntil {!KC_MISS}; 
	sleep 5;
	
//----------------------------------Check if runtime is nearing empty and repopulate array if near empty except the last called mission
																		if ((count _missionsRuntime) < 2) then {
																																							_missionsRuntime = _allMissions;
																																							_missionsRuntime = _missionsRuntime - [_currentMission];
																																						};
//----------------------------------- Get truly random mission and execute it.
																		_mission = _missionsRuntime  select (floor (random (count _missionsRuntime)));
																		_currentMission = execVM format["missions\%1.sqf", _mission]; 							
																									
																									
																									
																									
    
    
    KC_MISS = true;
	publicVariable "KC_MISS";	
};
