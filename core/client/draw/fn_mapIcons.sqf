#include "..\..\warlords_constants.inc"

// Slow loop
0 spawn {
	while { !BIS_WL_missionEnd } do {
		private _mainMap = (findDisplay 12) displayCtrl 51;
		private _maps = [
			_mainMap,
			(findDisplay 160) displayCtrl 51,
			(findDisplay -1) displayCtrl 500
		];
		{
			private _gps = _x displayCtrl 101;
			if (!isNull _gps) then {
				_maps pushBack _gps;
			};
		} forEach (uiNamespace getVariable ["IGUI_displays", displayNull]);

		{
			private _map = _x;
			if (isNull _map) then {
				continue;
			};
			private _mapDrawn = _map getVariable ["WL2_mapDrawn", false];
			if (!_mapDrawn) then {
				_map ctrlRemoveAllEventHandlers "Draw";
				_map ctrlAddEventHandler ["Draw", WL2_fnc_iconDrawMap];
				_map setVariable ["WL2_mapDrawn", true];
			};
		} forEach _maps;

		uiSleep 3;
	};
};

// Fast loop
0 spawn {
	private _settingsMap = profileNamespace getVariable ["WL2_settings", createHashMap];
	while { !BIS_WL_missionEnd } do {
		if (WL_IsReplaying) then {
			uiSleep 5;
			continue;
		};

		private _mainMap = (findDisplay 12) displayCtrl 51;
		private _drawMode = if (WL_IsSpectator) then { 1 } else { 0 };
		[_mainMap, _drawMode] spawn WL2_fnc_iconDrawMapPrepare;

		private _refreshRate = _settingsMap getOrDefault ["mapRefresh", 4];
		_refreshRate = _refreshRate max 1;
		private _refreshSleepTime = 1 / _refreshRate;
		uiSleep _refreshSleepTime;
	};
};

#if WL_REPLAYS
// Store game data
0 spawn {
	missionNamespace setVariable ["WL2_drawIcons", []];
	missionNamespace setVariable ["WL2_drawEllipses", []];
	missionNamespace setVariable ["WL2_drawSectorIcons", []];

	while { !BIS_WL_missionEnd } do {
		private _mainMap = (findDisplay 12) displayCtrl 51;
		[_mainMap, 2] spawn WL2_fnc_iconDrawMapPrepare;
		sleep 30;
	};
};
#endif