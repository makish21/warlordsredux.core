#include "..\..\warlords_constants.inc"

params ["_fastTravelMode", "_marker"];

// Fast Travel Modes
// 0: Seized Sector
// 1: Contested Sector
// 2: Air Assault
// 3: Vehicle Paradrop
// 4: Tent
// 5: Stronghold
// 6: Forward Base
// 7: Vehicle Paradrop FOB

titleCut ["", "BLACK OUT", 1];
openMap [false, false];

"Fast_travel" call WL2_fnc_announcer;

sleep 1;

private _sectorPos = if (isNil "BIS_WL_targetSector") then {
	[0, 0, 0];
} else {
	[toUpper format [localize "STR_A3_WL_popup_travelling", BIS_WL_targetSector getVariable "BIS_WL_name"], nil, 3] spawn WL2_fnc_smoothText;
	(BIS_WL_targetSector getVariable "objectAreaComplete") # 0;
};

#define SERVER_ID 2

if (_fastTravelMode == WL_FAST_TRAVEL_MODE_SEIZED) exitWith {
	// asynchronous server-side destination computation
	[player, "fastTravelSeized", BIS_WL_targetSector] remoteExec ["WL2_fnc_handleClientRequest", SERVER_ID];
};

// synchronous client-side destination computation
private _destination = [];
switch (_fastTravelMode) do {
	case WL_FAST_TRAVEL_MODE_CONTESTED: {
		private _spawnPositions = [_marker, 0, true] call WL2_fnc_findSpawnPositions;
		_destination = if (count _spawnPositions > 0) then {
			selectRandom _spawnPositions;
		} else {
			markerPos _marker;
		};

		[player, "fastTravelContested", getMissionConfigValue ["BIS_WL_fastTravelCostContested", 150]] remoteExec ["WL2_fnc_handleClientRequest", 2];
	};
	case WL_FAST_TRAVEL_MODE_AIR_ASSAULT: {
		private _randomPos = _marker call BIS_fnc_randomPosTrigger;
		private _distance = _randomPos distance2D BIS_WL_targetSector;
		private _height = _sectorPos # 2;
		_height = _height max 250;
		_destination = [_randomPos # 0, _randomPos # 1, _height + _distance * 0.5];

		[player, "fastTravelContested", getMissionConfigValue ["WL_airAssaultCost", 300]] remoteExec ["WL2_fnc_handleClientRequest", 2];
	};
	case WL_FAST_TRAVEL_MODE_VEHICLE_PARADROP: {
		private _safeSpot = selectRandom ([BIS_WL_targetSector, 0, true] call WL2_fnc_findSpawnPositions);
		_destination = [_safeSpot # 0, _safeSpot # 1, 50];

        private _paradropNextUseVar = format ["WL_paradropNextUse_%1", getPlayerUID player];
        missionNamespace setVariable [_paradropNextUseVar, serverTime + 600];

		[player, "fastTravelContested", getMissionConfigValue ["WL_vehicleParadropCost", 1000]] remoteExec ["WL2_fnc_handleClientRequest", 2];
	};
	case WL_FAST_TRAVEL_MODE_TENT: {
		private _respawnBag = player getVariable ["WL2_respawnBag", objNull];
        if (!isNull _respawnBag) then {
            _destination = getPosATL _respawnBag;
        };
	};
	case WL_FAST_TRAVEL_MODE_STRONGHOLD: {
		private _stronghold = BIS_WL_targetSector getVariable ["WL_stronghold", objNull];
		private _posArr = _stronghold buildingPos -1;
		_destination = if (count _posArr > 0) then {
			selectRandom _posArr;
		} else {
			getPosATL _stronghold;
		};
	};
	case WL_FAST_TRAVEL_MODE_FOB;
	case WL_FAST_TRAVEL_MODE_VEHICLE_PARADROP_FOB: {
		private _spawnPositions = [_marker, 0, true] call WL2_fnc_findSpawnPositions;
		_destination = if (count _spawnPositions > 0) then {
			selectRandom _spawnPositions;
		} else {
			markerPos _marker;
		};
		_destination = [_destination # 0, _destination # 1, 50];
		deleteMarker _marker;
	};
};

[_fastTravelMode, _destination, _sectorPos] call WL2_fnc_completeFastTravel;
