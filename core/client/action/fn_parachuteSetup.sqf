params ["_unit", "_actionId"];

private _parachuteActionId = _unit addAction [
    "<t color='#00ff00'>Open Parachute</t>",
    WL2_fnc_parachuteAction,
    [],
    100
];

private _settingsMap = profileNamespace getVariable ["WL2_settings", createHashMap];
private _parachuteAutoDeploy = _settingsMap getOrDefault ["parachuteAutoDeploy", true];
waitUntil {
    sleep 0.2;
    private _isBelowThreshold = if (_parachuteAutoDeploy || !(isPlayer _unit)) then {
        (getPosATL _unit # 2) < 100 || (getPosASL _unit # 2) < 100;
    } else {
        isTouchingGround (vehicle _unit)
    };
    !alive _unit || _isBelowThreshold || vehicle _unit != _unit;
};

_unit removeAction _parachuteActionId;

if (alive _unit && vehicle _unit == _unit) then {
    [objNull, _unit, -1, []] call WL2_fnc_parachuteAction;
};