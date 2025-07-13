params ["_control", "_untilServerTime"];

_control ctrlEnable false;

[_control, _untilServerTime] spawn {
	params ["_control", "_requiredTime"];

	while { serverTime < _requiredTime } do {
		private _remainingText = [_requiredTime - serverTime, "MM:SS"] call BIS_fnc_secondsToString;
		_control ctrlSetTooltip format [localize "STR_A3_WL2_settings_cooldown", _remainingText];

		sleep 1;
	};

	_control ctrlSetTooltip "";
	_control ctrlEnable true;
};
