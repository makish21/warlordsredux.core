#include "..\..\warlords_constants.inc"
params ["_asset"];

if (isDedicated) exitWith {};
if (_asset isKindOf "Building") exitWith {};

_index = _asset addAction [
	format ["%1/%2", localize "STR_A3_WL2_action_modify_vehicle", localize "STR_rearm"],
	{
		params ["_asset"];
		_asset spawn WLM_fnc_initMenu;
	},
	[],
	5,
	true,
	false,
	"",
	"alive _target && ([_target, _this, ""full""] call WL2_fnc_accessControl) # 0 && vehicle _this == _this",
	WL_MAINTENANCE_RADIUS,
	false
];

_asset setUserActionText [_index, format ["<t color = '#4bff58'>%1/%2</t>", localize "STR_A3_WL2_action_modify_vehicle", localize "STR_rearm"], "<img size='1.5' image='a3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa'/>"];