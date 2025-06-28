#include "..\..\warlords_constants.inc"

private _vehicle = cursorObject;
if (isNull _vehicle) exitWith {
    [false, localize "STR_A3_WL_asset_availability_reset_valid_asset"];
};

private _outOfRange = player distance2D _vehicle > 15;
if (_outOfRange) exitWith {
    [false, localize "STR_A3_WL_asset_availability_reset_asset_near"];
};

private _accessControl = _vehicle getVariable ["WL2_accessControl", -2];
private _hasNoLock = _accessControl == -2;
if (_hasNoLock) exitWith {
    [false, localize "STR_A3_WL_asset_availability_reset_valid_asset"];
};

private _isTransporting = _vehicle getVariable ["WL2_transporting", false];
if (_isTransporting) exitWith {
    [false, localize "STR_A3_WL_asset_availability_reset_valid_asset"];
};

private _isMan = _vehicle isKindOf "Man";
if (_isMan) exitWith {
    [false, localize "STR_A3_WL_asset_availability_reset_valid_asset"];
};

private _access = [_vehicle, player, "driver"] call WL2_fnc_accessControl;
if !(_access # 0) exitWith {
    [false, format [localize "STR_A3_WL_asset_availability_reset_asset_access", _access # 1]];
};

[true, ""];