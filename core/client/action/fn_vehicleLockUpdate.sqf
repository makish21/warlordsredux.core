params ["_asset", "_lockActionId"];

private _isUAV = unitIsUAV _asset;
private _accessControl = _asset getVariable ["WL2_accessControl", 0];

private _color = switch (_accessControl) do {
    case 0;
    case 1;
    case 2: {
        "#4bff58";
    };
    case 3;
    case 4;
    case 5: {
        "#00ffff";
    };
    case 6;
    case 7: {
        "#ff4b4b";
    };
};

private _lockLabel = switch (_accessControl) do {
    case 0: {
        localize "STR_A3_WL_access_control_all_full";
    };
    case 1: {
        localize "STR_A3_WL_access_control_all_operate";
    };
    case 2: {
        localize "STR_A3_WL_access_control_all_passenger";
    };
    case 3: {
        localize "STR_A3_WL_access_control_squad_full";
    };
    case 4: {
        localize "STR_A3_WL_access_control_squad_operate";
    };
    case 5: {
        localize "STR_A3_WL_access_control_squad_passenger";
    };
    case 6: {
        localize "STR_A3_WL_access_control_personal";
    };
    case 7: {
        localize "STR_A3_WL_access_control_locked";
    };
};

private _lockIcon = "a3\modules_f\data\iconunlock_ca.paa";

_asset setUserActionText [_lockActionId, format ["<t color = '%1'>%2</t>", _color, _lockLabel], format ["<img size='2' image='%1'/>", _lockIcon]];

_asset call WL2_fnc_uavConnectRefresh;