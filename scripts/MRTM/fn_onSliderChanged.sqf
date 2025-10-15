/*
	Author: MrThomasM

	Description: Triggers when the slider pos is changed and updates view distance.
*/
#include "constants.inc"


private _valid = params [["_name", "", [""]], ["_value", -1, [0]]];
if !_valid exitWith {};
if (_name isEqualTo "") exitWith {};
if (_value isEqualTo -1) exitWith {};

disableSerialization;

private _map = createHashMapFromArray [
	["inf",            SETTINGS_VIEW_DISTANCE_INF_EDIT_IDC],
	["ground",         SETTINGS_VIEW_DISTANCE_VIC_EDIT_IDC],
	["air",            SETTINGS_VIEW_DISTANCE_AIR_EDIT_IDC],
	["drones",         SETTINGS_VIEW_DISTANCE_UAV_EDIT_IDC],
	["cqb",            SETTINGS_VIEW_DISTANCE_CQB_EDIT_IDC],
	["objects",        SETTINGS_VIEW_DISTANCE_OBJ_EDIT_IDC],
	["apsVolume",      SETTINGS_GENERAL_APS_VOLUME_EDIT_IDC],
	["killVolume",     SETTINGS_GENERAL_KILL_VOLUME_EDIT_IDC],
	["informerVolume", SETTINGS_GENERAL_INFORMER_VOLUME_EDIT_IDC],
	["mapRefresh",     SETTINGS_GENERAL_MAP_REFRESH_EDIT_IDC],
	["rwr1",           SETTINGS_RWR_PULL_UP_EDIT_IDC],
	["rwr2",           SETTINGS_RWR_ALTITUDE_EDIT_IDC],
	["rwr3",           SETTINGS_RWR_WARNINGS_EDIT_IDC],
	["rwr4",           SETTINGS_RWR_OTHERS_EDIT_IDC]
];

private _ctrlIdc = _map getOrDefault [_name, -1];
if (_ctrlIdc == -1) exitWith {};

private _property = "MRTM_" + _name;
profileNamespace setVariable [_property, _value];
ctrlSetText [_ctrlIdc, str (profileNamespace getVariable [_property, 0])];
[] call MRTM_fnc_updateViewDistance;

private _objectsDistance = profileNamespace getVariable ["MRTM_objects", 2000];
if(_property isEqualTo "MRTM_objects") then {
	setObjectViewDistance [_objectsDistance, 50];
};
if (profileNamespace getVariable ["MRTM_syncObjects", true]) then {
	sliderSetPosition[SETTINGS_VIEW_DISTANCE_OBJ_SLIDER_IDC, _objectsDistance];
	ctrlSetText[SETTINGS_VIEW_DISTANCE_OBJ_EDIT_IDC, str _objectsDistance];
};