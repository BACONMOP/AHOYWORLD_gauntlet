/*
| Author: 
|
|	Pfc.Christiansen
|_____
|
|   Description: Resupply mission by truck.
|	
|	Created: 10.January 2015
|	Last modified: By: 
|	Made for AhoyWorld.
*/

//Defines+mission name
TRUCK_ARR = 0;
TRUCK_DEAD = 0;
_missionLocations = ["Supply_Truck","Supply_Truck_1","Supply_Truck_2","Supply_Truck_3","Supply_Truck_4","Supply_Truck_5","Supply_Truck_6","Supply_Truck_7","Supply_Truck_8"];

_spawnLoc = getMarkerPos "spawn_zone";
call KC_fnc_missionName;
_missionName = KC_missionName;

// Get Random Mission Loc

_missionLoc = _missionLocations call BIS_fnc_selectRandom;


//Spawn In enemies
waituntil{DAC_NewZone == 0};
_DACvalues = ["m2",[2,0,0],[4,2,20,5],[],[1,2,20,5],[],[0,0,0,0]];
[getMarkerPos _missionLoc,400,400,0,0,_DACvalues] call DAC_fNewZone;
waituntil{DAC_NewZone == 0}; 

//Spawn Truck in

truck = createVehicle ["B_Truck_01_box_F", _spawnLoc, [], 0, "NONE" ];

//Marker AO +Hint new AO

_marker = createMarker ["mission2_mrk", getMarkerPos _missionLoc ];
"mission2_mrk" setMarkerShape "ICON";
"mission2_mrk" setMarkerType "selector_selectable";
"mission2_mrk" setMarkerColor "ColorBLUFOR";
"mission2_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission2_1", getMarkerPos _missionLoc];
"mission2_1_mrk" setMarkerShape "RECTANGLE";
"mission2_1_mrk" setMarkerSize [30,30];
"mission2_1_mrk" setMarkerBrush "Border";
"mission2_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission2_2_mrk", getMarkerPos "AOMarker"];
"mission2_2_mrk" setMarkerShape "ICON";
"mission2_2_mrk" setMarkerType "mil_dot";
"mission2_2_mrk" setMarkerText "A point needs resupplying, bring the truck from the pickup point to the designated area.";

_misHintText = format
	[
		"<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>A point needs resupplying,bring the truck from the pickup-point to the designated area<br/><br/>",
		_missionName
	];
	
GlobalHint = _misHintText; publicVariable "GlobalHint"; hint parseText GlobalHint;

//Triggers for mission end

_trg = createTrigger ["EmptyDetector",getMarkerPos _missionLoc];
_trg setTriggerArea [20,20,20,false];
_trg setTriggerStatements ["truck distance thistrigger < 10","TRUCK_ARR = 1",""];

_trg2 = createTrigger ["EmptyDetector",getMarkerPos _missionLoc];
_trg2 setTriggerArea [20,20,20,false];
_trg2 setTriggerStatements ["!alive truck","TRUCK_DEAD = 1",""];


waitUntil {TRUCK_ARR == 1 or TRUCK_DEAD == 1};


	if ( TRUCK_ARR == 1) then
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
deleteMarker "mission2_mrk";
deleteMarker "mission2_1_mrk";
deleteMarker "mission2_2_mrk";
sleep 10;
deleteVehicle truck;
sleep 50;

waituntil{DAC_NewZone == 0};
["m2"] call DAC_fDeleteZone ;
waituntil{DAC_NewZone == 0};
KC_MISS = false;		