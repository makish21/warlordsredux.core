params ["_control"];

private _script = _control getVariable "rateLimitWait";
if (isNil "_script") exitWith {};

terminate _script;