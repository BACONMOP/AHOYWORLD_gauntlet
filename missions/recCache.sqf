/*
| Author: 
|
|	Pfc.Christiansen
|_____
|
|   Description: Recover Weapons Crate
|	
|	Created: 26.January 2015
|	Last modified: By: 
|	Made for AhoyWorld.
*/

//Defines+mission name

_missionLocations = ["Recover_Cache","Recover_Cache_1","Recover_Cache_2","Recover_Cache_3","Recover_Cache_4","Recover_Cache_5","Recover_Cache_6","Recover_Cache_7","Recover_Cache_8","Recover_Cache_9","Recover_Cache_10","Recover_Cache_11","Recover_Cache_12","Recover_Cache_13","Recover_Cache_14"];

_dropZone = getMarkerPos "spawn_zone";
call KC_fnc_missionName;
_missionName = KC_missionName;

CRATE_SALV = 0;
CRATE_DEAD = 0;
// Get Random Mission Loc

_missionLoc = _missionLocations call BIS_fnc_selectRandom;



//Spawn In enemies
waituntil{DAC_NewZone == 0};
_DACvalues = ["m8",[3,0,0],[8,4,20,5],[],[],[],[0,0,0,0]];
[getMarkerPos _missionLoc,400,400,0,0,_DACvalues] call DAC_fNewZone;
waituntil{DAC_NewZone == 0};


//Create Crate

wep_crate = createVehicle ["B_supplyCrate_F", getMarkerPos _missionLoc, [], 100, "NONE" ];
wep_crate setVehicleLock "LOCKED";
[wep_crate,false] call AGM_Drag_fnc_makeDraggable;

//Mission Hint+markers

 _misHintText = format
	[
		"<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>A helicopter dropped its slingload of experimental weapons while under fire, secure the cache before OPFOR manages to salvage it! The crate needs to be brought back to the Dropoff zone <br/><br/>",
		_missionName
	];
	
GlobalHint = _misHintText; publicVariable "GlobalHint"; hint parseText GlobalHint;

_marker = createMarker ["mission8_mrk", getMarkerPos _missionLoc ];
"mission8_mrk" setMarkerShape "ICON";
"mission8_mrk" setMarkerType "selector_selectable";
"mission8_mrk" setMarkerColor "ColorBLUFOR";
"mission8_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission8_1", getMarkerPos _missionLoc];
"mission8_1" setMarkerShape "RECTANGLE";
"mission8_1" setMarkerSize [400,400];
"mission8_1" setMarkerBrush "Border";
"mission8_1" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission8_2_mrk", getMarkerPos "AOMarker"];
"mission8_2_mrk" setMarkerShape "ICON";
"mission8_2_mrk" setMarkerType "mil_dot";
"mission8_2_mrk" setMarkerText "A helicopter dropped its slingload of experimental weapons while under fire, secure the cache before OPFOR manage to salvage it. The crate needs to be brought back to the dropoff zone.";

//Trigger for salvaged crate + if crate dies
_trg = createTrigger ["EmptyDetector",_dropZone];
_trg setTriggerArea [20,20,20,false];
_trg setTriggerStatements ["wep_crate distance thistrigger < 10","CRATE_SALV = 1",""];

_trg2 = createTrigger ["EmptyDetector",getMarkerPos _missionLoc];
_trg2 setTriggerArea [20,20,20,false];
_trg2 setTriggerStatements ["!alive wep_crate","CRATE_DEAD = 1",""];


//EndMiss
waitUntil {CRATE_SALV == 1 or CRATE_DEAD == 1};


	if ( CRATE_SALV == 1) then
		{
							_misSUCText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",_missionName];
							GlobalHint = _misSUCText; publicVariable "GlobalHint"; hint parseText GlobalHint;
		};
	if ( CRATE_DEAD == 1) then
		{
							_misFAILText = format ["<t align='center' size='2.2'>OP FAILED</t><br/><t size='1.5' align='center' color='#ff0000'>%1</t><br/>____________________<br/><t align='left'>Tough luck with %1, get ready for new tasking</t>",_missionName];
							GlobalHint = _misFAILText; publicVariable "GlobalHint"; hint parseText GlobalHint;
		};
		
		
		
deleteVehicle _trg;
deleteVehicle _trg2;
deleteMarker "mission8_mrk";
deleteMarker "mission8_1";
deleteMarker "mission8_2_mrk";
sleep 30;
deleteVehicle wep_crate;
sleep 30;
waituntil{DAC_NewZone == 0};
["m8"] call DAC_fDeleteZone;
waituntil{DAC_NewZone == 0};
KC_MISS = false;