/*
| Author: 
|
|	Quiksilver.
|
| Modified last by: Pfc. Christiansen
|
|_____
|
| Description: 
|	
|	Created: 14/2/2015. Altered: 16/2/2015
|	Coded for AhoyWorld EU 3 to replace Patrol Ops with a perpetual mission with few scripts.
|	You may use and edit the code.
|	You may not remove any entries from Credits without first removing the relevant author's contributions, 
|	or asking permission from the mission authors/contributors.
|	You may not remove the Credits tab, without consent of Ahoy World.
| 	Feel free to re-format or make it look better.
|_____
|
| Usage: 
|	
|	Search below for the diary entries you would like to edit. 
|	DiarySubjects appear in descending order when player map is open.
|	DiaryRecords appear in ascending order when selected.
|_____
|
| Credit:
|
|	This Mission was created by Pfc.Christiansen and BACONMOP
|	
|	Please be respectful and do not remove credit.
|______________________________________________________________*/

if (!hasInterface) exitWith {};

waitUntil {!isNull player};

player createDiarySubject ["rules", "Rules"];
player createDiarySubject ["teamspeak", "Teamspeak"];
player createDiarySubject ["changelog", "Change Log"];
player createDiarySubject ["credits", "Credits"];

//-------------------------------------------------- Rules

player createDiaryRecord ["rules",
[
"Enforcement",
"
<br />The purpose of the above rules are to ensure a fun and relaxing environment for public players.
<br />
<br />Server rules are in place merely as a means to that end.
<br />
<br />Guideline for enforcement:
<br />
<br />-	Innocent rule violation and disruptive behavior: 
<br />
<br />		= Verbal / Written request to cease, or warning.
<br /> 
<br />-	Minor or first-time rule violation:
<br />
<br />		= Kick, or 0 - 7 day ban.
<br />
<br />-	Serious or repetitive rule violation: 
<br />
<br />		= 7 day to permanent ban.
<br />
<br />
<br />The above is subject to discretion.
"
]];

player createDiaryRecord ["rules",
[
"General",
"
<br />1. Do not teamkill. This one shouldn’t even be here… ANY type of on purpose teamkilling will not be accepted. IE: Revenge killing, executions, dicking around…
<br />2. Do not dare/antagonize someone to teamkill, and/or create a situation where teamkilling is very likely to happen.
<br />3. Do not discharge any of your weapons in base on purpose!
<br />4. Do not use 2 seater aircraft when alone.
<br />5. CAS  pilots(Helicopter/Jet) should be on standby in a safe orbit over AO unless instructed otherwise by command element(Not Squad Leaders). CAS standby and not fire unless told to by command.
<br />6. If you select a role, please play that role. We don’t expect a medic to be running around with a AT launcher + LMG. Just play your role.
<br />7. The motor pool and spawn area is not for helicopters or jets. Do not land them there. Use the helipads instead. When no helipad is available, land outside base in a safe area.
<br />8. Hacking and mission exploitation will not be tolerated.
<br />9. Unnecessary destruction of BLUFOR vehicles will not be tolerated.
<br />10. Verbal abuse and bullying will not be tolerated. 
<br />11. Griefing and obstructive play will not be tolerated.
<br />12. Excessive mic spamming, especially of Side and Global channels, will not be tolerated.
<br />13. A server moderator or admin's word is final.
<br />
<br />If you see a player in violation of the above, contact a moderator or admin (teamspeak).
"
]];



//-------------------------------------------------- Teamspeak

player createDiaryRecord ["teamspeak",
[
"TS3",
"
<br /> Teamspeak:<br /><br />
<br /> http://www.teamspeak.com/?page=downloads
"
]];

player createDiaryRecord ["teamspeak",
[
"AHOY WORLD",
"
<br /> Address: ts.ahoyworld.co.uk
<br />
<br /> Visitors and guests welcome!
"
]];

//-------------------------------------------------- FAQ



//-------------------------------------------------- Change Log


player createDiaryRecord ["changelog",
[
"V 0.02",
"
<br />[ADDED] uniforms to loadouts
<br />[ADDED] onPlayerRespawn.sqf to handle giving players loadouts.
<br />[ADDED] Base Additions (repair-pads,supply depot) with scripts for handling repair.
<br />[REMOVED] Lines about loadouts from init.sqf.
<br />[FIXED] Mission 3 objective marker.
<br />[FIXED] Mission 2 missing marker.
"
]];

player createDiaryRecord ["changelog",
[
"V 0.03",
"
<br />[ADDED] Missions 5-10.
<br />[ADDED] Ch Viewdistance Script.
<br />[ADDED] Implemented execs for core sqfs.
<br />[ADDED] Modules.
<br />[ADDED Vic repspawner (Stock BIS one for now).
<br />[TWEAKED] Settings for AGM Repair.
"
]];

player createDiaryRecord ["changelog",
[
"V 0.06",
"
<br />[FIXED] Sometimes the dac calls for missions would mesh with dac call for ambient ai, this would throw out errors
<br />[FIXED] missing quotations in array for mission locations in mission 10.
<br />[ADDED] Small fireing range near the fixed wing hangar.
"
]];

player createDiaryRecord ["changelog",
[
"V 0.07",
"
<br />[ADDED] Spectator script for Gnights, this will stop players from respawning and put them in spectate mode.
<br />[FIXED] error in MMG.sqf loadout.
"
]];

player createDiaryRecord ["changelog",
[
"V 0.08",
"
<br />[ADDED] waveRespawn function for gamenights,will trigger a respawn when last mission ends(sets respawnTime to 1) then resets it for spectator script to be enabled until next mission ends.
"
]];

player createDiaryRecord ["changelog",
[
"V 0.09",
"
<br />[FIXED] Mission would call waveRespawn before dac\mission engine finished loading in gamenight mode, added variable to tell scripts when theese scripts had loaded.
<br />[TWEAKED] waveRespawn.sqf: Added line that would close the specator mode before respawning player."
]];

player createDiaryRecord ["changelog",
[
"V 0.10",
"
<br />[TWEAKED] Pos of DAC call in innit.
"
]];
player createDiaryRecord ["changelog",
[
"V 0.11",
"
<br />[TWEAKED] Marksman Loadout.
<br />[TWEAKED] Mission 10 should now only spawn when Platoon Commander is playing.
<br />[TWEAKED] WaveRespawn.sqf and core.sqf should now be better timed for variable calls.
<br />[FIXED] Script error in mission 10.
<br />[FIXED] Ammo boxes in the Supply Depot should now have the correct ammo.
<br />[CHANGED] Now use Quicksilver's vehicle respawn instead of BIS module.
"
]];
player createDiaryRecord ["changelog",
[
"V 0.12",
"
<br />[CHANGED] Tweaked mission1(Clear Town) sqf.
<br />[CHANGED] Further tweaked waveRespawn.sqf so that it get some time to close players spectator dialog before setting respawn time to 1. Then waits for new mission to spawn and activates spetate dialog again.
<br />[CHANGED] Switched 3 of the TUSK Abrams out for NON tusk Abrams.
<br />[CHANGED] AI-settings tweaked slightly ( Increased aimingShake by 0.1 and decreased max aimingAccuracy by 0.2 ).
<br />[ADDED\MODIFIED] Added ATLAS Squadmanager, tweaked init to only be available for squadleads.Merged stringtables with cssa3's.
<br />[ADDED\CHANGED] 2 MH-9's added,1 AH-9 added and changed out the viper for the Apache.
<br />[ADDED] Quicksilvers cleanup script.
"
]];

player createDiaryRecord ["changelog",
[
"V 0.13",
"
<br />[FIXED] Marksman loadout.
<br />[FIXED] Vehicles respawning when players are next to vehicles.
<br />[ADDED] Roster.
<br />[ADDED] AGM Parts (wheels and tracks) to supply depot.
<br />[ADDED] Cam Shake Fix.
<br />[ADDED] FAQ.
"
]];

player createDiaryRecord ["changelog",
[
"V 0.14",
"
<br />[REMOVED] EWK HMV's.
<br />[FIXED] Diary.
<br />[TWEAKED] Rifleman loadout.
"
]];

player createDiaryRecord ["changelog",
[
"V 0.15",
"
<br />[CHANGED] Removed HAFM CH-47 and added the RHS CH-47 which has an actual co-pilot seat.
<br />[REMOVED] Huron cause of texture error, subsequent mission not loading on server.
<br />[TWEAKED] UAV DES\Crate salvage missions AI amount.
<br />[ADDED] NATO now tracks enemy units in convoy missions to prevent NATO forces from loosing track of them.
<br />[MODIFIED\ADDED\TWEAKED] VA is now being restricted to NATO gear only. Removed a lot of unnecessary items and moved the box out of immediate view to prevent player dress-up syndrome.
<br />[MODIFIED] AH-64 changed to AH-1Z to combat AO slaying.
<br />[ADDED] More locations to missions.
<br />[TWEAKED] Marker locations in base.
"
]];

player createDiaryRecord ["changelog",
[
"V 0.15C",
"
<br />[HOTFIX] VA restriction broke cause of a bug within RHS, implemented unrestricted VA pending RHS fixing bug.

"
]];

player createDiaryRecord ["changelog",
[
"V 0.16",
"

<br />[CHANGED] Rewritten main.sqf ( Mission selector ) to be 99.9% more random and doesnt run the same mission untill 80% of the missions have been played.
<br />[CHANGED] waveRespawn.sqf now uses a public EH to trigger respawn after current missions ends while in gamenight mode.
<br />[CHANGED] Supplyboxes in Supply Point should now have magazine\items according to current loadouts.
<br />[TWEAKED] AmbientAI
<br />[CLEANUP] Given various .sqf's a overhaul to make it more structured.
<br />[REMOVED] Mission hint loop, as the current mission marker on map should suffice to give enogh information.

"
]];

player createDiaryRecord ["changelog",
[
"V 0.17",
"

<br />[CHANGED] Amount of choppers and location, CAS chopper will test pilots skill to manuever it out to the airfield.
<br />[CHANGED] Code optimizations, cleaned up Init.
<br />[ADDED] Time Of Day Parameter.


"
]];

player createDiaryRecord ["changelog",
[
"V 0.26",
"

<br />[CHANGED] Lots.


"
]];
//-------------------------------------------------- Credits

player createDiaryRecord ["credits",
[
"Gauntlet",
"
<br />Mission authors:<br /><br />

		- <font size='16'>Pfc.Christiansen<br /><br />
		- <font size='16'>BACONMOP</font><br />
		
<br />Other:<br /><br />
		QS Vehicle Respawn and Cleanup<br />
		- Quicksilver<br />
		DAC<br />
		- Silola<br />
		CSSA3<br />
		- Cyrokrypto<br /><br />
		CHVD<br />
		- Champ-1<br /> <br />
		ATLAS Squadmanager<br />
		- Champ-1<br /> <br />
"
]];