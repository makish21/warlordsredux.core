params ["_asset"];

private _jammerActivated = _asset getVariable ["WL_ewNetActive", false] && isEngineOn _asset;
private _jammerActivating = _asset getVariable ["WL_ewNetActivating", false] && isEngineOn _asset;
private _jammerColor = if (_jammerActivated) then {
    "#4bff58"
} else {
    if (_jammerActivating) then {
        "#4b51ff"
    } else {
        "#ff4b4b"
    };
};
private _jammerText = if (_jammerActivated) then {
    toUpper localize "STR_A3_WL_map_asset_jammer_on"
} else {
    if (_jammerActivating) then {
        toUpper localize "STR_A3_WL_map_asset_jammer_activating"
    } else {
        toUpper localize "STR_A3_WL_map_asset_jammer_off"
    };
};
private _buttonText = format [toUpper localize "STR_A3_WL_map_asset_jammer", format["<t color='%1'>%2</t>", _jammerColor, _jammerText]];
_buttonText;