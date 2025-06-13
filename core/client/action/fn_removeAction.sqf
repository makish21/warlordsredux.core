#include "..\..\warlords_constants.inc"
params ["_asset"];

if (isDedicated) exitWith {};

private _removeActionID = _asset addAction [
	"",
	{
		private _unit = _this # 0;

		private _displayName = [_unit] call WL2_fnc_getAssetTypeName;
		private _result = [
			localize "STR_A3_WL2_asset_delete_dialog_title", 
			format [localize "STR_A3_WL2_asset_delete_dialog_message", _displayName], 
			localize "STR_A3_WL2_prune_assets_dialog_button_positive", 
			localize "STR_A3_WL2_prune_assets_dialog_button_negative"
		] call WL2_fnc_prompt;

		private _access = [_unit, player, "full"] call WL2_fnc_accessControl;
		if !(_access # 0) exitWith {
			systemChat format [localize "STR_A3_WL2_asset_delete_impossible", _access # 1];
			playSound "AddItemFailed";
		};

		if (_result) exitWith {
			if (unitIsUAV _unit) then {
				private _grp = group effectiveCommander _unit;
				{_unit deleteVehicleCrew _x} forEach crew _unit;
				deleteGroup _grp;
			};
			deleteVehicle _unit;

			["TaskDeleteVehicle"] call WLT_fnc_taskComplete;
		};
	},
	[],
	-98,
	false,
	true,
	"",
	"vehicle _this != _target && {getPlayerUID _this == (_target getVariable ['BIS_WL_ownerAsset', '123']) && {alive _target}}",
	30,
	false
];

_asset setUserActionText [_removeActionID, format ["<t color = '#ff4b4b'>%1</t>", localize "STR_xbox_hint_remove"], "<img size='2' color='#ff4b4b' image='\a3\ui_f\data\IGUI\Cfg\Actions\Obsolete\ui_action_cancel_ca'/>"];