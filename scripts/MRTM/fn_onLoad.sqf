params ["_control", "_setting"];

private _rateLimitVar = format ["%1_NextChangeAllowed", _setting];
private _requiredTime = missionNamespace getVariable [_rateLimitVar, 0];

if (_requiredTime < serverTime) then {
	_control ctrlEnable true;
} else {
	private _script = [_control, _requiredTime] call MRTM_fnc_disableTemporarily;
	_control setVariable ["rateLimitWait", _script];
};
