params ["_asset"];

private _radarOperation = _asset getVariable ["radarOperation", false];
private _radarColor = if (_radarOperation) then {
    "#4bff58"
} else {
    "#ff4b4b"
};
private _radarOnText = if (_radarOperation) then {
    toUpper localize "STR_A3_WL_map_asset_radar_operate_on"
} else {
    toUpper localize "STR_A3_WL_map_asset_radar_operate_off"
};

private _buttonText = format [toUpper localize "STR_A3_WL_map_asset_radar_operate", format ["<t color='%1'>%2</t>", _radarColor, _radarOnText]];
_buttonText;