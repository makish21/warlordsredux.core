params ["_vehicle", "_angle", "_indicator", ["_gunner", objNull]];

if (!isNull _gunner) then {
	{
		_x reveal [vehicle _gunner, 4];
	} forEach (crew _vehicle);
};

if (vehicle player != _vehicle) exitWith {};

private _assetApsType = _vehicle getVariable ["apsType", -1];
if (_assetApsType == -1) exitWith {};

private _type = switch (_vehicle getVariable "apsType") do {
	case 2: { localize "STR_A3_WL2_aps_type_heavy" };
	case 1: { localize "STR_A3_WL2_aps_type_medium" };
	case 0: { localize "STR_A3_WL2_aps_type_light" };
	default { "Dazzler" };
};

private _text = _type;
if (_assetApsType == 3) then {
	_text = (if ([_vehicle] call APS_fnc_active) then {
		format [localize "STR_A3_WL2_aps_now_active", _type];
	} else {
		format [localize "STR_A3_WL2_aps_now_inactive", _type];
	});
} else {
	private _apsAmmo = _vehicle getVariable ["apsAmmo", 0];
	_apsAmmo = _apsAmmo max 0;
	_text = _text + "<br/>" + format[localize "STR_A3_WL2_aps_charges", _apsAmmo, _vehicle call APS_fnc_getMaxAmmo];

	if (_apsAmmo == 0) then {
		playSoundUI ["a3\sounds_f\vehicles\air\noises\heli_alarm_rotor_low.wss", 1, 0.5];
	};
};

private _apsDisplay = uiNamespace getVariable ["RscWLAPSDisplay", objNull];
if (isNull _apsDisplay) then {
	"APSDisplay" cutRsc ["RscWLAPSDisplay", "PLAIN", -1, true, true];
	_apsDisplay = uiNamespace getVariable "RscWLAPSDisplay";
};

private _indicatorBackground = _apsDisplay displayCtrl 7006;
private _indicatorDanger = _apsDisplay displayCtrl 7007;
private _indicatorRadar = _apsDisplay displayCtrl 7008;
private _indicatorText = _apsDisplay displayCtrl 7100;

if (_angle < 1) then{
	_angle = 1;
};

if (_indicator) then {
	playSound"Alarm";

	_indicatorDanger ctrlSetText "\a3\ui_f\data\IGUI\Cfg\Radar\danger_ca.paa";

	_indicatorDanger ctrlSetAngle [_angle + 22.5, 0.5, 0.5];
	_indicatorDanger ctrlShow true;
	_indicatorRadar ctrlShow true;
} else {
	_indicatorDanger ctrlSetText "";
	_indicatorRadar ctrlShow true;
};

_indicatorBackground ctrlSetBackgroundColor [0, 0, 0, 0.7];
_indicatorText ctrlSetStructuredText parseText _text;

uiNamespace setVariable ["WL_APS_showScreenExpire", time + 7];

waitUntil {
	sleep 0.5;
	time > uiNamespace getVariable ["WL_APS_showScreenExpire", 0]
};

_indicatorBackground ctrlSetBackgroundColor [0, 0, 0, 0];
_indicatorText ctrlSetText "";

_indicatorDanger ctrlShow false;
_indicatorRadar ctrlShow false;
