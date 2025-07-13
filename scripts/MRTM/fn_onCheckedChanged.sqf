params ["_control", "_setting", "_rateLimit"];

private _rateLimitVar = format ["%1_NextChangeAllowed", _setting];
private _rateLimitValue = missionNamespace getVariable [_rateLimitVar, 0];

private _existingSetting = profileNamespace getVariable [_setting, false];
player setVariable [_setting, !_existingSetting, [2, clientOwner]];
profileNamespace setVariable [_setting, !_existingSetting];
private _until = serverTime + _rateLimit;
missionNamespace setVariable [_rateLimitVar, _until];

private _script = [_control, _until] call MRTM_fnc_disableTemporarily;
_control setVariable ["rateLimitWait", _script];
