params ["_asset", "_actionID"];

private _actionColor = if ([_asset] call APS_fnc_active) then {
    "#4bff58";
} else {
    "#ff4b4b";
};

private _actionText = if ([_asset] call APS_fnc_active) then {
    format [localize "STR_A3_WL_map_asset_dazzler", localize "STR_A3_WL_map_asset_dazzler_on"];
} else {
    format [localize "STR_A3_WL_map_asset_dazzler", localize "STR_A3_WL_map_asset_dazzler_off"];
};

_asset setUserActionText [_actionID, format ["<t color = '%1'>%2</t>", _actionColor, _actionText]];