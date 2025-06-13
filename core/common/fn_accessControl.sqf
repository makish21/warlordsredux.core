params ["_asset", "_unit", "_role"];

private _accessControl = _asset getVariable ["WL2_accessControl", -1];
if (_accessControl == -1) exitWith {
    [true, localize "STR_A3_WL_access_control_not_set"];
};

private _ownerUID = _asset getVariable ["BIS_WL_ownerUavAsset", _asset getVariable ["BIS_WL_ownerAsset", "123"]];
private _owner = _ownerUID call BIS_fnc_getUnitByUid;
private _ownerID = getPlayerID _owner;
private _callerID = getPlayerID (leader _unit);
private _isOwner = _ownerUID == getPlayerUID (leader _unit);

private _isEnemy = (side group _unit) != _asset call WL2_fnc_getAssetSide;
if (_isEnemy && !(_asset isKindOf "Man")) exitWith {
    [false, localize "STR_A3_WL_access_control_enemy"];
};

private _access = false;
private _message = "";
switch (_accessControl) do {
    case 0: {
        // All (Full)
        _access = true;
        _message = localize "STR_A3_WL_access_control_all_full";
    };
    case 1: {
        // All (Operate)
        _access = _isOwner || _role != "full";
        _message = localize "STR_A3_WL_access_control_all_operate";
    };
    case 2: {
        // All (Passenger Only)
        _access = _isOwner || (_role == "cargo");
        _message = localize "STR_A3_WL_access_control_all_passenger";
    };
    case 3: {
        // Squad (Full)
        private _areInSquad = ["areInSquad", [_callerID, _ownerID]] call SQD_fnc_client;
        _access = _isOwner || _areInSquad;
        _message = localize "STR_A3_WL_access_control_squad_full";
    };
    case 4: {
        // Squad (Operate)
        private _areInSquad = ["areInSquad", [_callerID, _ownerID]] call SQD_fnc_client;
        _access = _isOwner || (_areInSquad && _role != "full");
        _message = localize "STR_A3_WL_access_control_squad_operate";
    };
    case 5: {
        // Squad (Passenger Only)
        private _areInSquad = ["areInSquad", [_callerID, _ownerID]] call SQD_fnc_client;
        _access = _isOwner || (_areInSquad && _role == "cargo");
        _message = localize "STR_A3_WL_access_control_squad_passenger";
    };
    case 6: {
        // Personal
        _access = _isOwner;
        _message = localize "STR_A3_WL_access_control_personal";
    };
    case 7: {
        // Locked
        _access = false;
        _message = localize "STR_A3_WL_access_control_locked";
    };
    default {
        _access = false;
        _message = localize "STR_A3_WL_access_control_locked";
    };
};

[_access, _message];