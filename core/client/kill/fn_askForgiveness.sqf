params ["_killer", "_victim"];

private _assetType = [_victim] call WL2_fnc_getAssetTypeName;
if (isNil "WL2_ffBuffer") then {
	WL2_ffBuffer = [];
	0 spawn {
		private _busy = false;
		while {!BIS_WL_missionEnd && {(count WL2_ffBuffer) > 0}} do {
			waitUntil {sleep 1; (count WL2_ffBuffer > 0) && {!_busy}};
			_busy = true;

			private _params = WL2_ffBuffer # 0;
			private _killer = _params # 0;
			private _victim = _params # 1;
			private _assetType = _params # 2;

			private _message = switch true do {
				case (isPlayer _victim): { format [localize "STR_A3_WL2_forgive_friendly_fire_dialog_message", name _killer] };
				case (_victim isKindOf "Man"): { format [localize "STR_A3_WL2_forgive_friendly_fire_subordinate_dialog_message", name _killer, _assetType]};
				default { format [localize "STR_A3_WL2_forgive_friendly_fire_vehicle_dialog_message", name _killer, _assetType] };
			};

			private _askForgiveness = [
				localize "STR_A3_WL2_forgive_friendly_fire_dialog_title",
				_message,
				localize "STR_A3_WL2_forgive_friendly_fire_dialog_button_yes", 
				localize "STR_A3_WL2_forgive_friendly_fire_dialog_button_no"
			] call WL2_fnc_prompt;

			WL2_ffBuffer deleteAt 0;
			_busy = false;
			private _result = _askForgiveness;

			[_killer, player, _result, _victim] remoteExec ["WL2_fnc_forgiveTeamkill", 2];
		};
		WL2_ffBuffer = nil;
	};
};

WL2_ffBuffer pushBack [_killer, _victim, _assetType];