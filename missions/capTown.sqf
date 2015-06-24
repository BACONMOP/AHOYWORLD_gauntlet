/*
| Author: 
|
|	Josh
|_____
|
|   Description: Capture + Defend Town
|	
|	Created: 13. March 2015
|	Last modified:13. March 2015 By: Pfc. Christiansen
|	Made for AhoyWorld.
*/

//Defines+mission name - 

_missionLocations = ["Cap_Town","Cap_Town_1","Cap_Town_2","Cap_Town_3","Cap_Town_4","Cap_Town_5","Cap_Town_6","Cap_Town_7","Cap_Town_8","Cap_Town_9","Cap_Town_10","Cap_Town_11","Cap_Town_12","Cap_Town_13","Cap_Town_14","Cap_Town_15","Cap_Town_16","Cap_Town_17","Cap_Town_18","Cap_Town_19","Cap_Town_20","Cap_Town_21","Cap_Town_22","Cap_Town_23"];


call KC_fnc_missionName;
_missionName = KC_missionName;

CA_ACT = 0;
// Get Random Mission Loc

_missionLoc = _missionLocations call BIS_fnc_selectRandom;


//Populate deploy zone with enemies
waituntil{DAC_NewZone == 0};
_DACvalues = ["m11",[11,0,0],[8,4,20,5],[3,2,20,5],[2,2,10,5],[],[0,0,0,0]];
[getMarkerPos _missionLoc,400,400,0,0,_DACvalues] call DAC_fNewZone;
waituntil{DAC_NewZone == 0}; 

//Mission Hint
_misHintText = format
	[
		"<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>A town has been occupied, you need to clear it out! Good Luck.<br/><br/>",
		_missionName
	];
	
GlobalHint = _misHintText; publicVariable "GlobalHint"; hint parseText GlobalHint;

//Marker for drop-off point.

_marker = createMarker ["mission13_mrk", getMarkerPos _missionLoc ];
"mission13_mrk" setMarkerShape "ICON";
"mission13_mrk" setMarkerType "selector_selectable";
"mission13_mrk" setMarkerColor "ColorBLUFOR";
"mission13_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission13_1_mrk", getMarkerPos _missionLoc];
"mission13_1_mrk" setMarkerShape "RECTANGLE";
"mission13_1_mrk" setMarkerSize [400,400];
"mission13_1_mrk" setMarkerBrush "Border";
"mission13_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission13_2_mrk", getMarkerPos "AOMarker"];
"mission13_2_mrk" setMarkerShape "ICON";
"mission13_2_mrk" setMarkerType "mil_dot";
"mission13_2_mrk" setMarkerText "A town has been occupied, you need to clear it out! Good Luck.";

//Trigger for detecting lack of opfor in AO

_trg = createTrigger ["EmptyDetector",getMarkerPos _missionLoc];
_trg setTriggerArea [500,500,0,false];
_trg setTriggerActivation ["EAST","NOT PRESENT", false];
_trg setTriggerStatements ["this","CA_ACT = 1",""];

waituntil{CA_ACT == 1};

//Mid hint for counter attack

_misMidHintText = format
	[
		"<t align='center' size='2.2'>Attention!</t><br/><t size='1.5' align='center' color='#FFCF11'></t><br/>____________________<br/>Enemy reinforcements have arrived! Prepare for Counter-Attack!<br/><br/>",
		_missionName
	];
	
GlobalHint = _misMidHintText; publicVariable "GlobalHint"; hint parseText GlobalHint;
sleep 20;
//Enemy Counter-attack

//-------find random pos around objective


_posTrg = createTrigger ["EmptyDetector", getMarkerPos _missionLoc];
_rndPos = [[getMarkerPos _missionLoc, _posTrg],"ground"] call BIS_fnc_selectRandom;



_GRP1 = [_rndPos, EAST, (configfile >> "CfgGroups" >> "East" >> "CSAT" >> "Mechanized_Infantry" >> "Mechanized_Rifle_Squad" )] call BIS_fnc_spawnGroup;
[_GRP1,(getMarkerPos  _missionLoc)] call BIS_fnc_taskAttack;
sleep  15;
_GRP2 = [_rndPos, EAST, (configfile >> "CfgGroups" >> "East" >> "CSAT" >> "Mechanized_Infantry" >> "Mechanized_Rifle_Squad" )] call BIS_fnc_spawnGroup;
[_GRP2,(getMarkerPos  _missionLoc)] call BIS_fnc_taskAttack;
sleep  15;
_GRP3 = [_rndPos, EAST, (configfile >> "CfgGroups" >> "East" >> "CSAT" >> "Mechanized_Infantry" >> "Mechanized_Rifle_Squad" )] call BIS_fnc_spawnGroup;
[_GRP3,(getMarkerPos  _missionLoc)] call BIS_fnc_taskAttack;
sleep 15;
_GRP4 = [_rndPos, EAST, (configfile >> "CfgGroups" >> "East" >> "CSAT" >> "Mechanized_Infantry" >> "Mechanized_Rifle_Squad" )] call BIS_fnc_spawnGroup;
[_GRP4,(getMarkerPos  _missionLoc)] call BIS_fnc_taskAttack;
sleep 20;
 waitUntil{sleep 2; count (units _GRP1) < 4};
 waitUntil{sleep 2; count (units _GRP2) < 4};
 waitUntil{sleep 2; count (units _GRP3) < 4};
 waitUntil{sleep 2; count (units _GRP4) < 4};
_misEndText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",_missionName];
GlobalHint = _misEndText; publicVariable "GlobalHint"; hint parseText GlobalHint;
deleteVehicle _trg;
deleteMarker "mission13_1_mrk";
deleteMarker "mission13_mrk";
deleteMarker "mission13_2_mrk";
sleep 60;
waituntil{DAC_NewZone == 0};
["m11"] call DAC_fDeleteZone;
waituntil{DAC_NewZone == 0}; 

KC_MISS = false;
