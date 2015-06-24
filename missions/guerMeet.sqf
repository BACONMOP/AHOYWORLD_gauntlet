/*
| Author: 
|
|	BACONMOP
|_____
|
|   Description: Guerilla meet
|	
|	Created: 29.January 2015
|	Last modified: 16.02-15 By: Pfc. Christiansen Reason: Rektified some errors in markers.
|	Made for AhoyWorld.
*/

// ------------------- Find Obj Pos

if (!isNull s3) then{

call KC_fnc_missionName;
_missionName = KC_missionName;

_missionLocations = ["Guerilla_Meet","Guerilla_Meet_1","Guerilla_Meet_2","Guerilla_Meet_3","Guerilla_Meet_4","Guerilla_Meet_5","Guerilla_Meet_6","Guerilla_Meet_7"];

_missionLoc = _missionLocations call BIS_fnc_selectRandom;

_meatingLoc = [_missionLoc, 100] call CBA_fnc_randPos;

// ------------------- Create OBJ

_gurGrp = createGroup west;
"B_G_officer_F" createUnit [_meatingLoc, _gurGrp];
"B_G_Soldier_F" createUnit [_meatingLoc, _gurGrp];

_gurOfficer = ((units _gurGrp) select 0);
_gurRifle = ((units _gurGrp) select 1);

waituntil{DAC_NewZone == 0};
_DACvaluesWayPoint = ["m10",[10,0,0],[20],[20],[20],[],[0,0,0,0]];
[getMarkerPos _missionLoc,400,400,0,0,_DACvaluesWayPoint] call DAC_fNewZone;
waituntil{DAC_NewZone == 0};

// ------------------- Briefing

_marker = createMarker ["mission10_mrk", getMarkerPos _missionLoc ];
"mission10_mrk" setMarkerShape "ICON";
"mission10_mrk" setMarkerType "selector_selectable";
"mission10_mrk" setMarkerColor "ColorBLUFOR";
"mission10_mrk" setMarkerText "Objective";

_marker2 = createMarker ["mission10_1_mrk", getMarkerPos _missionLoc];
"mission10_1_mrk" setMarkerShape "RECTANGLE";
"mission10_1_mrk" setMarkerSize [30,30];
"mission10_1_mrk" setMarkerBrush "Border";
"mission10_1_mrk" setMarkerColor "ColorOPFOR";

_marker3 = createMarker ["mission10_2_mrk", getMarkerPos "AOMarker"];
"mission10_2_mrk" setMarkerShape "ICON";
"mission10_2_mrk" setMarkerType "mil_dot";
"mission10_2_mrk" setMarkerText "A local guerrilla leader has requested a meeting with command. Meet with him and make sure he and the Platoon commander can complete the meeting.";

_misHintText = format
["<t align='center' size='2.2'>New Op</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>A local Guerrilla Leader has requested a meeting with command. Meet with him and make sure he and the Platoon commander can complete the meeting.<br/><br/>",_missionName];
GlobalHint = _misHintText; publicVariable "GlobalHint"; hint parseText GlobalHint;

// ------------------- Core Loop

_accepted = false;
_coreLoop = true;
_timer = 1;
_meetingTimer = false;
while{_coreLoop} do {
	
	if(!_accepted) then {
		if (s3 distance _gurOfficer < 20) then{
			[_gurOfficer, _gurRifle] joinSilent group s3;
			_accepted = true;
			_DACLoc = [_missionLoc, 2000] call CBA_fnc_randPos;
			while {_DACLoc distance _meatingLoc < 1000} do {
				_DACLoc = [_missionLoc, 2000] call CBA_fnc_randPos;
			};
			waituntil{DAC_NewZone == 0};
			_DACvaluesWayPoint = ["m10_1",[10,0,0],[5,3,3,8],[2,2,2,8],[1,1,1,8],[],[0,0,0,0]];
			[_DACLoc,400,400,0,0,_DACvaluesWayPoint] call DAC_fNewZone;
			waituntil{DAC_NewZone == 0};
			_misHintText = format ["<t align='center' size='2.2'></t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/><br/>Be advised OpFor are attacking<br/><br/>",_missionName];
			GlobalHint = _misHintText; publicVariable "GlobalHint"; hint parseText GlobalHint;
			_meetingTimer = true;
		};
	};
	
	if (!alive s3) then{
		_coreLoop = false;
		_misFAILText = format ["<t align='center' size='2.2'>OP FAILED</t><br/><t size='1.5' align='center' color='#ff0000'>%1</t><br/>____________________<br/><t align='left'>The Platoon Commander has died!</t>",_missionName];
		GlobalHint = _misFAILText; publicVariable "GlobalHint"; hint parseText GlobalHint;
	};
	
	if (!alive _gurOfficer) then{
		_coreLoop = false;
		_misFAILText = format ["<t align='center' size='2.2'>OP FAILED</t><br/><t size='1.5' align='center' color='#ff0000'>%1</t><br/>____________________<br/><t align='left'>The Guerrilla Leader has died! %1 Failed</t>",_missionName];
		GlobalHint = _misFAILText; publicVariable "GlobalHint"; hint parseText GlobalHint;
	};
	
	if (_meetingTimer) then {
		_timer = _timer + 1;
		if (_timer == 600) then {
			_coreLoop = false;
			_misSUCText = format ["<t align='center' size='2.2'>OP Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Good job with %1, The meeting is complete</t>",_missionName];
			GlobalHint = _misSUCText; publicVariable "GlobalHint"; hint parseText GlobalHint;
			_meetingTimer = false;
		};
	};
	sleep 1;
};

// ------------------- Clean up

_gurLeaveWP = [_missionLoc, 2000] call CBA_fnc_randPos;
[_gurOfficer, _gurRifle] joinSilent _gurGrp;

_Convoy_WP1 = _gurGrp addWaypoint [_gurLeaveWP, 0]; 
_Convoy_WP1 setWaypointType "Move";
_Convoy_WP1 setWaypointBehaviour "SAFE";
_Convoy_WP1 setWaypointFormation "Column";

sleep 60;
deleteVehicle _gurOfficer;
deleteVehicle _gurRifle;
deleteMarker "mission10_mrk";
deleteMarker "mission10_1_mrk";
deleteMarker "mission10_2_mrk";

["m10"] call DAC_fDeleteZone;
waituntil{DAC_NewZone == 0};
["m10_1"] call DAC_fDeleteZone;
waituntil{DAC_NewZone == 0};

};
KC_MISS = false;