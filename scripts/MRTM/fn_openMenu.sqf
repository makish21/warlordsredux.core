/*
	Author: MrThomasM

	Description: Opens the settings menu.
*/

#include "constants.inc"

if (isNull (findDisplay SETTINGS_IDD)) then {
	private _d = [4000, SETTINGS_IDD, 2000];
	{
		if !(isNull (findDisplay _x)) then {
			findDisplay _x closeDisplay 1;
		};
	} forEach _d;
	createDialog "MRTM_settingsMenu";
};

["TaskThirdPerson"] call WLT_fnc_taskComplete;

disableSerialization;

_display = findDisplay SETTINGS_IDD;
(_display displayCtrl SETTINGS_HEADER_TEXT_RIGHT_IDC) ctrlSetStructuredText parseText format ["<t valign='middle' align='right'>%1</t>", (name player)];
{
	ctrlSetText [(_x # 0), str (_x # 1)];
} forEach [
	[SETTINGS_VIEW_DISTANCE_INF_EDIT_IDC,       profileNamespace getVariable ["MRTM_inf", 2000]],
	[SETTINGS_VIEW_DISTANCE_VIC_EDIT_IDC,       profileNamespace getVariable ["MRTM_ground", 3000]],
	[SETTINGS_VIEW_DISTANCE_AIR_EDIT_IDC,       profileNamespace getVariable ["MRTM_air", 4000]],
	[SETTINGS_VIEW_DISTANCE_UAV_EDIT_IDC,       profileNamespace getVariable ["MRTM_drones", 4000]],
	[SETTINGS_VIEW_DISTANCE_CQB_EDIT_IDC,       profileNamespace getVariable ["MRTM_cqb", 150]],
	[SETTINGS_VIEW_DISTANCE_OBJ_EDIT_IDC,       profileNamespace getVariable ["MRTM_objects", 2000]],
	[SETTINGS_GENERAL_MAP_REFRESH_EDIT_IDC,     profileNamespace getVariable ["MRTM_mapRefresh", 4]],
	[SETTINGS_GENERAL_APS_VOLUME_EDIT_IDC,      profileNamespace getVariable ["MRTM_apsVolume", 0.4]],
	[SETTINGS_GENERAL_INFORMER_VOLUME_EDIT_IDC, profileNamespace getVariable ["MRTM_informerVolume", 0.4]],
	[SETTINGS_GENERAL_KILL_VOLUME_EDIT_IDC,     profileNamespace getVariable ["MRTM_killVolume", 0.4]],
	[SETTINGS_RWR_PULL_UP_EDIT_IDC,             profileNamespace getVariable ["MRTM_rwr1", 0.3]],
	[SETTINGS_RWR_ALTITUDE_EDIT_IDC,            profileNamespace getVariable ["MRTM_rwr2", 0.3]],
	[SETTINGS_RWR_WARNINGS_EDIT_IDC,            profileNamespace getVariable ["MRTM_rwr3", 0.2]],
	[SETTINGS_RWR_OTHERS_EDIT_IDC,              profileNamespace getVariable ["MRTM_rwr4", 0.3]]
];

{
	sliderSetRange [(_x select 0), 100, 4000];
	sliderSetPosition [(_x select 0), (_x select 1)];
	(_display displayCtrl (_x select 0)) sliderSetSpeed [100, 4000, 50];
} forEach [
	[SETTINGS_VIEW_DISTANCE_INF_SLIDER_IDC, (profileNamespace getVariable ["MRTM_inf", 2000])],
	[SETTINGS_VIEW_DISTANCE_VIC_SLIDER_IDC, (profileNamespace getVariable ["MRTM_ground", 3000])],
	[SETTINGS_VIEW_DISTANCE_AIR_SLIDER_IDC, (profileNamespace getVariable ["MRTM_air", 4000])],
	[SETTINGS_VIEW_DISTANCE_UAV_SLIDER_IDC, (profileNamespace getVariable ["MRTM_drones", 4000])],
	[SETTINGS_VIEW_DISTANCE_CQB_SLIDER_IDC, (profileNamespace getVariable ["MRTM_cqb", 150])],
	[SETTINGS_VIEW_DISTANCE_OBJ_SLIDER_IDC, (profileNamespace getVariable ["MRTM_objects", 2000])]
];
(_display displayCtrl SETTINGS_VIEW_DISTANCE_SYNC_OBJECTS_IDC) cbSetChecked (profileNamespace getVariable ["MRTM_syncObjects", true]);
ctrlEnable [SETTINGS_VIEW_DISTANCE_OBJ_SLIDER_IDC, !(profileNamespace getVariable ["MRTM_syncObjects", true])];
ctrlEnable [SETTINGS_VIEW_DISTANCE_OBJ_EDIT_IDC, !(profileNamespace getVariable ["MRTM_syncObjects", true])];

private _rwrEnabled = profileNamespace getVariable ["MRTM_EnableRWR", true];

ctrlEnable [SETTINGS_RWR_PULL_UP_SLIDER_IDC, _rwrEnabled];
ctrlEnable [SETTINGS_RWR_PULL_UP_EDIT_IDC, _rwrEnabled];
ctrlEnable [SETTINGS_RWR_ALTITUDE_SLIDER_IDC, _rwrEnabled];
ctrlEnable [SETTINGS_RWR_ALTITUDE_EDIT_IDC, _rwrEnabled];
ctrlEnable [SETTINGS_RWR_WARNINGS_SLIDER_IDC, _rwrEnabled];
ctrlEnable [SETTINGS_RWR_WARNINGS_EDIT_IDC, _rwrEnabled];
ctrlEnable [SETTINGS_RWR_OTHERS_SLIDER_IDC, _rwrEnabled];
ctrlEnable [SETTINGS_RWR_OTHERS_EDIT_IDC, _rwrEnabled];

{
	sliderSetRange [(_x select 0), 0, 0.4];
	sliderSetPosition [(_x select 0), (_x select 1)];
	(_display displayCtrl (_x select 0)) sliderSetSpeed [0, 0.4, 0.01];
} forEach [
	[SETTINGS_GENERAL_APS_VOLUME_SLIDER_IDC, profileNamespace getVariable ["MRTM_apsVolume", 0.4]],
	[SETTINGS_GENERAL_INFORMER_VOLUME_SLIDER_IDC, profileNamespace getVariable ["MRTM_informerVolume", 0.4]],
	[SETTINGS_GENERAL_KILL_VOLUME_SLIDER_IDC, profileNamespace getVariable ["MRTM_killVolume", 0.4]],
	[SETTINGS_RWR_PULL_UP_SLIDER_IDC, (profileNamespace getVariable ["MRTM_rwr1", 0.3])],
	[SETTINGS_RWR_ALTITUDE_SLIDER_IDC, (profileNamespace getVariable ["MRTM_rwr2", 0.3])],
	[SETTINGS_RWR_WARNINGS_SLIDER_IDC, (profileNamespace getVariable ["MRTM_rwr3", 0.2])],
	[SETTINGS_RWR_OTHERS_SLIDER_IDC, (profileNamespace getVariable ["MRTM_rwr4", 0.3])]
];

private _mapRefreshCtrl = _display displayCtrl SETTINGS_GENERAL_MAP_REFRESH_SLIDER_IDC;
_mapRefreshCtrl sliderSetRange [2, 100];
_mapRefreshCtrl sliderSetPosition (profileNamespace getVariable ["MRTM_mapRefresh", 4]);
_mapRefreshCtrl sliderSetSpeed [1, 1, 1];

(_display displayCtrl SETTINGS_GENERAL_3RD_PERSON_IDC          ) cbSetChecked (profileNamespace getVariable ["MRTM_3rdPersonDisabled", false]);
(_display displayCtrl SETTINGS_GENERAL_MISSILE_CAMERA_IDC      ) cbSetChecked (profileNamespace getVariable ["MRTM_disableMissileCameras", false]);
(_display displayCtrl SETTINGS_GENERAL_INSTANT_DEATH_IDC       ) cbSetChecked (profileNamespace getVariable ["MRTM_instantDeath", false]);
(_display displayCtrl SETTINGS_GENERAL_USER_MARKERS_IDC        ) cbSetChecked (profileNamespace getVariable ["MRTM_showMarkers", true]);
(_display displayCtrl SETTINGS_GENERAL_AUTONOMOUS_MODE_IDC     ) cbSetChecked (profileNamespace getVariable ["MRTM_enableAuto", false]);
(_display displayCtrl SETTINGS_GENERAL_UNIT_VOICE_IDC          ) cbSetChecked (profileNamespace getVariable ["MRTM_noVoiceSpeaker", false]);
(_display displayCtrl SETTINGS_GENERAL_SMALL_ANNOUNCER_FONT_IDC) cbSetChecked (profileNamespace getVariable ["MRTM_smallAnnouncerText", false]);
(_display displayCtrl SETTINGS_GENERAL_SPAWN_EMPTY_VICS_IDC    ) cbSetChecked (profileNamespace getVariable ["MRTM_spawnEmpty", false]);
(_display displayCtrl SETTINGS_RWR_VOICE_IDC                   ) cbSetChecked (profileNamespace getVariable ["MRTM_EnableRWR", true]);
