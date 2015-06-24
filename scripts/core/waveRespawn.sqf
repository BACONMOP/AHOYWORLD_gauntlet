/*
| Author: 
|
|	Pfc.Christiansen
|_____
|
|   Description: Loop for respawning players when gamenight mode is enabled.
|	
|	Created: 03 February 2015
|	Last modified: 17. March 2015  By: Pfc. Christiansen Reason: Altering of script to pass code thru a EH.
|	Made for AhoyWorld.
*/
waituntil{DAC_Basic_Value == 1} ;
sleep 40;

while {GAMENIGHT == 1} do 
	{

		waitUntil {!KC_MISS};
		CloseSpectator = if (!isNull findDisplay 7810) then {closeDialog 0}; publicVariable CloseSpectator;
		sleep 3;
		RespawnWave =  0; publicVariable RespawnWave;
		sleep 3;
		waitUntil {KC_MISS};
		RespawnWave =  9999999; publicVariable RespawnWave;

	sleep 10;
	};
