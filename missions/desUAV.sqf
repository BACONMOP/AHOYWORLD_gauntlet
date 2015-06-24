/*
| Author: 
|
|	Pfc.Christiansen
|_____
|
|   Description: Destroy crashlanded UAV.
|	
|	Created: 27.January 2015
|	Last modified: 13. May 2015 By: Pfc. Christiansen Reason: Reworked spawning of UAV
|	Made for AhoyWorld.
*/

//Defines+mission name

_missionLocations = ["Destroy_UAV","Destroy_UAV_1","Destroy_UAV_2","Destroy_UAV_3","Destroy_UAV_4","Destroy_UAV_5","Destroy_UAV_6","Destroy_UAV_7","Destroy_UAV_8","Destroy_UAV_9","Destroy_UAV_10","Destroy_UAV_11","Destroy_UAV_12"];
_dropZone = getMarkerPos "spawn_zone";
call KC_fnc_missionName;
_missionName = KC_missionName;

COUNTER_ATK = 0;

// Get Random Mission Loc

_missionLoc = _missionLocations call BIS_fnc_selectRandom;


//Create Trigger for Blufor

_trg = createTrigger ["EmptyDetector",getMarkerPos _missionLoc];
_trg setTriggerArea [400,400,0,false];
_trg setTriggerActivation ["WEST","PRESENT", false];
_trg setTriggerStatements ["this","COUNTER_ATK = 1",""];



//Mission Hint

 _misHintText = format
	[
		"<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>A UAV has crashlanded, destroy it before the enemies can retrieve it. <br/><br/>",
		_missionName
	];
	
GlobalHint = _misHintText; publicVariable "GlobalHint"; hint parseText GlobalHint;

_marker = createMarker ["mission9_mrk", getMarkerPos _missionLoc ];
"mission9_mrk" setMarkerShape "ICON";
"mission9_mrk" setMarkerType "selector_selectable";
"mission9_mrk" setMarkerColor "ColorBLUFOR";
"mission9_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission9_1_mrk", getMarkerPos _missionLoc];
"mission9_1_mrk" setMarkerShape "ELLIPSE";
"mission9_1_mrk" setMarkerSize [500,500];
"mission9_1_mrk" setMarkerBrush "Border";
"mission9_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission9_2_mrk", getMarkerPos "AOMarker"];
"mission9_2_mrk" setMarkerShape "ICON";
"mission9_2_mrk" setMarkerType "mil_dot";
"mission9_2_mrk" setMarkerText "A UAV has crashlanded, destroy it before the enemies can retrieve it.";

//Find safe pos for uav
_cntPos = getMarkerPos _missionLoc;
_safePos = [_cntPos, 0, 400, 3, 0, 10, 0] call BIS_fnc_findSafePos;
//Create UAV

k_uav = createVehicle ["B_UAV_02_F", _safePos, [], 100, "NONE" ];


//Wait for blufor to get near uav

waitUntil {COUNTER_ATK == 1};

//Hint East are approaching

_misMidHintText = format
	[
		"<t align='center' size='2.2'>Attention!</t><br/><t size='1.5' align='center' color='#FFCF11'></t><br/>____________________<br/>OPFOR Forces are nearing the crash site, take them out before destroying the UAV<br/><br/>",
		_missionName
	];
	
GlobalHint = _misMidHintText; publicVariable "GlobalHint"; hint parseText GlobalHint;

// Spawn enemy COUNTER_ATK

_rndPos  =  [getMarkerPos _missionLoc, 1000] call CBA_fnc_randPos;


_GRP1 = [_rndPos, EAST, (configfile >> "CfgGroups" >> "East" >> "CSAT" >> "Mechanized_Infantry" >> "Mechanized_Rifle_Squad" )] call BIS_fnc_spawnGroup;
[_GRP1,(getPos k_uav)] call BIS_fnc_taskAttack;

sleep  15;

_rndPos2 =  [getMarkerPos _missionLoc, 1000] call CBA_fnc_randPos;

_GRP2 = [_rndPos2, EAST, (configfile >> "CfgGroups" >> "East" >> "CSAT" >> "Mechanized_Infantry" >> "Mechanized_Rifle_Squad" )] call BIS_fnc_spawnGroup;
[_GRP2,(getPos k_uav)] call BIS_fnc_taskAttack;

sleep  15;

_rndPos3  =  [getMarkerPos _missionLoc, 1000] call CBA_fnc_randPos;

_GRP3 = [_rndPos3, EAST, (configfile >> "CfgGroups" >> "East" >> "CSAT" >> "Mechanized_Infantry" >> "Mechanized_Rifle_Squad" )] call BIS_fnc_spawnGroup;
[_GRP3,(getPos k_uav)] call BIS_fnc_taskAttack;



waitUntil{!alive k_uav};

_misSUCText = format 

	[
	
	"<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",
	_missionName
		
	];
GlobalHint = _misSUCText; publicVariable "GlobalHint"; hint parseText GlobalHint;

sleep 15;
deleteVehicle k_uav;
deleteVehicle _trg;
deleteMarker "mission9_mrk";
deleteMarker "mission9_1_mrk";
deleteMarker "mission9_2_mrk";

KC_MISS = false;



