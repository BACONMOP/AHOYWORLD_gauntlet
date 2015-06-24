/*
| Author: 
|
|	Josh
|_____
|
|   Description: Capture enemy ballistic missile launcher
|	
|	Created: 11.March 2015
|	Last modified:13. March 2015 By: Pfc.Christiansen
|	Made for AhoyWorld.
*/


//Defines+locations+missioncall

_missionLocations = ["Cap_Ballistic","Cap_Ballistic_1","Cap_Ballistic_2","Cap_Ballistic_3","Cap_Ballistic_4","Cap_Ballistic_5","Cap_Ballistic_6","Cap_Ballistic_7","Cap_Ballistic_8","Cap_Ballistic_9","Cap_Ballistic_10","Cap_Ballistic_11","Cap_Ballistic_12","Cap_Ballistic_13","Cap_Ballistic_14"];

_dropZone = getMarkerPos "spawn_zone";

call KC_fnc_missionName;
_missionName = KC_missionName;

TRUCK_SALV = 0;
TRUCK_DEAD = 0;
//Get Final Loc

_missionLoc = _missionLocations call BIS_fnc_selectRandom;


//Spawn in objective + lock

obj_1 = createVehicle ["O_APC_Tracked_02_AA_F",getMarkerPos _missionLoc, [], 0, "NONE" ];
_obj_2 = createVehicle ["O_Truck_02_covered_F",getMarkerPos _missionLoc, [], 10, "NONE" ];
_obj_3 = createVehicle ["O_MRAP_02_F",getMarkerPos _missionLoc, [], 20, "NONE" ];
_obj_4 = createVehicle ["O_MRAP_02_F",getMarkerPos _missionLoc, [], 20, "NONE" ];
_obj_5 = createVehicle ["I_MRAP_03_F",getMarkerPos _missionLoc, [], 25, "NONE" ];

_obj_2 setVehicleLock "LOCKED";
_obj_3 setVehicleLock "LOCKED";
_obj_4 setVehicleLock "LOCKED";
_obj_5 setVehicleLock "LOCKED";

_obj_2 setDir 20;
_obj_3 setDir 30;

//Spawn In Enemies
waituntil{DAC_NewZone == 0};
_DACvalues = ["m12",[12,0,0],[6,3,20,5],[],[3,4,20,5],[],[0,0,0,0]];
[getMarkerPos _missionLoc,400,400,0,0,_DACvalues] call DAC_fNewZone;
waituntil{DAC_NewZone == 0}; 

//Marker AO +Hint new AO
_marker = createMarker ["mission12_mrk", getMarkerPos _missionLoc ];
"mission12_mrk" setMarkerShape "ICON";
"mission12_mrk" setMarkerType "selector_selectable";
"mission12_mrk" setMarkerColor "ColorBLUFOR";
"mission12_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission12_1_mrk", getMarkerPos _missionLoc];
"mission12_1_mrk" setMarkerShape "ELLIPSE";
"mission12_1_mrk" setMarkerSize [400,400];
"mission12_1_mrk" setMarkerBrush "Border";
"mission12_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission12_2_mrk", getMarkerPos "AOMarker"];
"mission12_2_mrk" setMarkerShape "ICON";
"mission12_2_mrk" setMarkerType "mil_dot";
"mission12_2_mrk" setMarkerText "Intel suggests the enemy are moving ballistic missile launchers. Capture and bring back to base one of these launchers.";

_misHintText = format
	[
		"<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Intel suggests the enemy are moving ballistic missile launchers. Capture and bring back to base one of these launchers.<br/><br/>",
		_missionName
	];
	
GlobalHint = _misHintText; publicVariable "GlobalHint"; hint parseText GlobalHint;

//Trigger for salvaged truck + if truck dies
_trg = createTrigger ["EmptyDetector",_dropZone];
_trg setTriggerArea [20,20,20,false];
_trg setTriggerStatements ["obj_1 distance thistrigger < 10","TRUCK_SALV = 1",""];

_trg2 = createTrigger ["EmptyDetector",getMarkerPos _missionLoc];
_trg2 setTriggerArea [20,20,20,false];
_trg2 setTriggerStatements ["!alive obj_1","TRUCK_DEAD = 1",""];


//EndMiss
waitUntil {TRUCK_SALV == 1 or TRUCK_DEAD == 1};


	if ( TRUCK_SALV == 1) then
		{
							_misSUCText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",_missionName];
							GlobalHint = _misSUCText; publicVariable "GlobalHint"; hint parseText GlobalHint;
		};
	if ( TRUCK_DEAD == 1) then
		{
							_misFAILText = format ["<t align='center' size='2.2'>OP FAILED</t><br/><t size='1.5' align='center' color='#ff0000'>%1</t><br/>____________________<br/><t align='left'>Tough luck with %1, get ready for new tasking</t>",_missionName];
							GlobalHint = _misFAILText; publicVariable "GlobalHint"; hint parseText GlobalHint;
		};
		
deleteVehicle _trg;
deleteVehicle _trg2;		
deleteMarker "mission12_mrk";
deleteMarker "mission12_1_mrk";
deleteMarker "mission12_2_mrk";

sleep 30;
deleteVehicle obj_1;
deleteVehicle _obj_2;
deleteVehicle _obj_3;
deleteVehicle _obj_4;
deleteVehicle _obj_5;
sleep 30;
waituntil{DAC_NewZone == 0};
["m12"] call DAC_fDeleteZone ;
waituntil{DAC_NewZone == 0};

KC_MISS  = false;
