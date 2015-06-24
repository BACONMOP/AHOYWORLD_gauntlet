/*
| Author: 
|
|	Pfc.Christiansen & Josh
|_____
|
|   Description: Seek and destroy enemy tank platoon.
|	
|	Created: 11.March 2015
|	Last modified: By: 
|	Made for AhoyWorld.
*/


//Defines+locations+missioncall

_missionLocations = ["Destroy_Tanks","Destroy_Tanks_1","Destroy_Tanks_2","Destroy_Tanks_3","Destroy_Tanks_4","Destroy_Tanks_5","Destroy_Tanks_6","Destroy_Tanks_7","Destroy_Tanks_8","Destroy_Tanks_9"];


call KC_fnc_missionName;
_missionName = KC_missionName;

//Get Final Loc

_missionLoc = _missionLocations call BIS_fnc_selectRandom;


//Spawn in objective + lock

_obj_1 = createVehicle ["I_APC_Wheeled_03_cannon_F",getMarkerPos _missionLoc, [], 0, "NONE" ];
_obj_2 = createVehicle ["O_APC_Tracked_02_cannon_F",getMarkerPos _missionLoc, [], 10, "NONE" ];
_obj_3 = createVehicle ["O_APC_Tracked_02_cannon_F",getMarkerPos _missionLoc, [], 20, "NONE" ];
_obj_4 = createVehicle ["O_APC_Tracked_02_cannon_F",getMarkerPos _missionLoc, [], 20, "NONE" ];
_obj_5 = createVehicle ["O_MBT_02_cannon_F",getMarkerPos _missionLoc, [], 25, "NONE" ];
_obj_8 = createVehicle ["Campfire_burning_F",getMarkerPos _missionLoc, [], 15, "NONE" ];

_obj_1 setVehicleLock "LOCKED";
_obj_2 setVehicleLock "LOCKED";
_obj_3 setVehicleLock "LOCKED";
_obj_4 setVehicleLock "LOCKED";
_obj_5 setVehicleLock "LOCKED";

_obj_1 setDir 205;
_obj_2 setDir 20;
_obj_3 setDir 30;

//Spawn In Enemies
waituntil{DAC_NewZone == 0};
_DACvalues = ["m13",[13,0,0],[2,2,20,5],[],[5,2,35,5],[],[0,0,0,0]];
[getMarkerPos _missionLoc,400,400,0,0,_DACvalues] call DAC_fNewZone;
waituntil{DAC_NewZone == 0}; 

//Marker AO +Hint new AO
_marker = createMarker ["mission11_mrk", getMarkerPos _missionLoc ];
"mission11_mrk" setMarkerShape "ICON";
"mission11_mrk" setMarkerType "selector_selectable";
"mission11_mrk" setMarkerColor "ColorBLUFOR";
"mission11_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission11_1_mrk", getMarkerPos _missionLoc];
"mission11_1_mrk" setMarkerShape "ELLIPSE";
"mission11_1_mrk" setMarkerSize [400,400];
"mission11_1_mrk" setMarkerBrush "Border";
"mission11_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission11_2_mrk", getMarkerPos "AOMarker"];
"mission11_2_mrk" setMarkerShape "ICON";
"mission11_2_mrk" setMarkerType "mil_dot";
"mission11_2_mrk" setMarkerText "Scouts have located an enemy tank platoon camp. Destroy all the enemy tanks.";

_misHintText = format
	[
		"<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Scouts have located an enemy tank platoon camp. Destroy all the enemy tanks and return to base!<br/><br/>",
		_missionName
	];
	
GlobalHint = _misHintText; publicVariable "GlobalHint"; hint parseText GlobalHint;

waituntil{!alive _obj_1 && !alive _obj_2 && !alive _obj_3 && !alive _obj_4 && !alive _obj_4 && !alive _obj_5};

_misEndText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, get ready for new tasking</t>",_missionName];
GlobalHint = _misEndText; publicVariable "GlobalHint"; hint parseText GlobalHint;
deleteMarker "mission11_mrk";
deleteMarker "mission11_1_mrk";
deleteMarker "mission11_2_mrk";

sleep 30;
deleteVehicle _obj_1;
deleteVehicle _obj_2;
deleteVehicle _obj_3;
deleteVehicle _obj_4;
deleteVehicle _obj_5;
deleteVehicle _obj_6;
deleteVehicle _obj_7;
deleteVehicle _obj_8;
deleteVehicle _obj_9;
sleep 30;
waituntil{DAC_NewZone == 0};
["m13"] call DAC_fDeleteZone ;
waituntil{DAC_NewZone == 0};

KC_MISS  = false;
