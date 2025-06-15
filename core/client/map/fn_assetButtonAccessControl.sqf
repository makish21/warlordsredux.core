params ["_accessControl"];

private _lockStatus = [
    toUpper localize "STR_A3_WL_access_control_all_full",
    toUpper localize "STR_A3_WL_access_control_all_operate",
    toUpper localize "STR_A3_WL_access_control_all_passenger",
    toUpper localize "STR_A3_WL_access_control_squad_full",
    toUpper localize "STR_A3_WL_access_control_squad_operate",
    toUpper localize "STR_A3_WL_access_control_squad_passenger",
    toUpper localize "STR_A3_WL_access_control_personal",
    toUpper localize "STR_A3_WL_access_control_locked"
] select _accessControl;

private _lockColor = [
    "#4bff58", "#4bff58", "#4bff58",
    "#00ffff", "#00ffff", "#00ffff",
    "#ff4b4b",
    "#ff4b4b"
] select _accessControl;

private _structuredStatus = format ["<t color='%1'>%2</t>", _lockColor, _lockStatus];
private _lockText = format [toUpper localize "STR_A3_WL_access_control", _structuredStatus];
_lockText;