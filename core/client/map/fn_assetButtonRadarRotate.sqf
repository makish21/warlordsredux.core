params ["_asset"];

private _radarRotation = _asset getVariable ["radarRotation", false];
private _radarColor = if (_radarRotation) then {
    "#4bff58"
} else {
    "#ff4b4b"
};
private _radarOnText = if (_radarRotation) then {
    toUpper localize "STR_A3_WL_map_asset_radar_rotate_on"
} else {
    toUpper localize "STR_A3_WL_map_asset_radar_rotate_off"
};

private _buttonText = format [toUpper localize "STR_A3_WL_map_asset_radar_rotate", format ["<t color='%1'>%2</t>", _radarColor, _radarOnText]];
_buttonText;