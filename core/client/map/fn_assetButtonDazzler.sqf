params ["_asset"];

private _dazzlerActivated = [_asset] call APS_fnc_active;
private _dazzlerColor = if (_dazzlerActivated) then {
    "#4bff58"
} else {
    "#ff4b4b"
};
private _dazzlerText = if (_dazzlerActivated) then {
    toUpper localize "STR_A3_WL_map_asset_dazzler_on"
} else {
    toUpper localize "STR_A3_WL_map_asset_dazzler_off"
};
private _buttonText = format [toUpper localize "STR_A3_WL_map_asset_dazzler", format ["<t color='%1'>%2</t>", _dazzlerColor, _dazzlerText]];
_buttonText;