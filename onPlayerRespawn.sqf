/*
| Author: 
|
|	Pfc.Christiansen
|_____
|
|   Description: Init for server\player
|	
|	Created: 1.December 2014
|	Last modified: 11. June 2015 By: BACONMOP
|	Made for AhoyWorld.
*/

player enableFatigue FALSE;


_pilots = ["B_pilot_F","B_helipilot_F","B_helicrew_F"];
_iampilot = ({typeOf player == _x} count _pilots) > 0;
if (_iampilot) then {

	//===== UH-80 TURRETS
	if (PARAMS_UH80TurretControl != 0) then {
		inturretloop = false;
		UH80TurretAction = player addAction ["Turret Control",QS_fnc_uh80TurretControl,[],-95,false,false,'','[] call QS_fnc_conditionUH80TurretControl'];
	};
};


//====================== Seating and Clear vehicle inventory stuff

saving_inventory = FALSE;
inventory_cleared = FALSE;
player setVariable ["seated",FALSE];
player addAction ["Clear vehicle inventory",QS_fnc_actionClearInventory,[],-97,FALSE,FALSE,'','[] call QS_fnc_conditionClearInventory'];

//======================= Add players to Zeus

{_x addCuratorEditableObjects [[player],FALSE];} count allCurators;
