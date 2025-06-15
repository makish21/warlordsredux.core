/*
	Author: MrThomasM

	Description: Opens the settings menu.
*/

if (isNull (findDisplay 8000)) then {
	private _d = [4000, 8000, 2000];
	{
		if !(isNull (findDisplay _x)) then {
			(findDisplay _x) closeDisplay 1;
		};
	} forEach _d;
	createDialog "MRTM_settingsMenu";
};

["TaskThirdPerson"] call WLT_fnc_taskComplete;

disableSerialization;

_display = findDisplay 8000;
(_display displayCtrl 8001) ctrlSetStructuredText parseText format ["<t valign='middle' align='right'>%1</t></t>", (name player)];
{
	ctrlSetText [(_x # 0), str (_x # 1)];
} forEach [[8004, (profileNamespace getVariable ["MRTM_inf", 2000])], [8006, (profileNamespace getVariable ["MRTM_ground", 3000])], [8008, (profileNamespace getVariable ["MRTM_air", 4000])], [8010, (profileNamespace getVariable ["MRTM_drones", 4000])], [8014, (profileNamespace getVariable ["MRTM_objects", 2000])], [8016, (profileNamespace getVariable ["MRTM_rwr1", 0.3])], [8018, (profileNamespace getVariable ["MRTM_rwr2", 0.3])], [8020, (profileNamespace getVariable ["MRTM_rwr3", 0.2])], [8022, (profileNamespace getVariable ["MRTM_rwr4", 0.3])]];
{
	slidersetRange [(_x select 0), 100, 4000];
	sliderSetPosition [(_x select 0), (_x select 1)];
	(_display displayCtrl (_x select 0)) sliderSetSpeed [100, 4000, 50];
} forEach [[8003, (profileNamespace getVariable ["MRTM_inf", 2000])], [8005, (profileNamespace getVariable ["MRTM_ground", 3000])], [8007, (profileNamespace getVariable ["MRTM_air", 4000])], [8009, (profileNamespace getVariable ["MRTM_drones", 4000])], [8012, (profileNamespace getVariable ["MRTM_objects", 2000])]];
(_display displayCtrl 8013) cbSetChecked (profileNamespace getVariable ["MRTM_syncObjects", true]);
ctrlEnable [8012, !(profileNamespace getVariable ["MRTM_syncObjects", true])];
ctrlEnable [8014, !(profileNamespace getVariable ["MRTM_syncObjects", true])];

{
	slidersetRange [(_x select 0), 0.05, 0.4];
	sliderSetPosition [(_x select 0), (_x select 1)];
	(_display displayCtrl (_x select 0)) sliderSetSpeed [0.05, 0.4, 0.01];
} forEach [[8015, (profileNamespace getVariable ["MRTM_rwr1", 0.3])], [8017, (profileNamespace getVariable ["MRTM_rwr2", 0.3])], [8019, (profileNamespace getVariable ["MRTM_rwr3", 0.2])], [8021, (profileNamespace getVariable ["MRTM_rwr4", 0.3])]];

(_display displayCtrl 8023) cbSetChecked (profileNamespace getVariable ["MRTM_EnableRWR", true]);
(_display displayCtrl 8024) cbSetChecked (profileNamespace getVariable ["MRTM_3rdPersonDisabled", false]);
(_display displayCtrl 8025) cbSetChecked (profileNamespace getVariable ["MRTM_muteVoiceInformer", false]);
(_display displayCtrl 8026) cbSetChecked (profileNamespace getVariable ["MRTM_playKillSound", true]);
(_display displayCtrl 8027) cbSetChecked (profileNamespace getVariable ["MRTM_enableAuto", false]);
(_display displayCtrl 8028) cbSetChecked (profileNamespace getVariable ["MRTM_smallAnnouncerText", false]);
(_display displayCtrl 8029) cbSetChecked (profileNamespace getVariable ["MRTM_spawnEmpty", false]);
(_display displayCtrl 8030) cbSetChecked (profileNamespace getVariable ["MRTM_disableMissileCameras", false]);
(_display displayCtrl 8031) cbSetChecked (profileNamespace getVariable ["MRTM_showMarkers", true]);
(_display displayCtrl 8032) cbSetChecked (profileNamespace getVariable ["MRTM_noVoiceSpeaker", false]);
(_display displayCtrl 8033) cbSetChecked (profileNamespace getVariable ["MRTM_muteTaskNotifications", false]);
(_display displayCtrl 8034) cbSetChecked (profileNamespace getVariable ["MRTM_parachuteAutoDeploy", true]);