/*
| Author: 
|
|	BACONMOP
|_____
|
|   Description: Ambient Helicopter Patrol
|	
|	Created: 16 March 2015
|	Last modified: 16 March 2015 By: PFC.Christiansen Reason: Added a editiable amount of WPs for helipath instead of fixed number.
|	Made for AhoyWorld.
*/

_loop = true;

_heliPool = [
	"O_Heli_Light_02_F",
	"O_Heli_Attack_02_F"
];
While {_loop} do {

	_centerPool = [
	"center1",
	"center2",
	"center3",
	"center4"
	];
	_patrolSector = _centerPool call BIS_Fnc_selectRandom;
	_heli = _heliPool call BIS_Fnc_selectRandom;

	_heliGrp = createGroup east;
	_ambientHeli = createVehicle [_heli, getMarkerPos "Heli_Spawn", [], 0, "FLY" ];
	[_ambientHeli,_heliGrp] call BIS_fnc_spawnCrew;
	
	
	for "_i" from 1 to PARAMS_AmbientHeliWPs do{
		_wpPos =  [_patrolSector, 4000] call CBA_fnc_randPos;
		_heliWp = _heliGrp addWaypoint [_wpPos,0];
		_heliWp setWaypointType "MOVE";
		_heliWp setWaypointCompletionRadius 50;
	};
	
	_wp = _heliGrp addwaypoint [getMarkerPos "center",0];
	_wp setWaypointType "CYCLE";
	sleep 2700 + (random 900);
	_returnWP = _heliGrp addwaypoint [getMarkerPos "Heli_Spawn",0];
	sleep 200;
	_heli setDamage .90;
	sleep 100;
	deleteVehicle _heli;
	
};