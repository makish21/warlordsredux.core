#include "..\..\warlords_constants.inc"

params ["_sector", "_owner"];

private _units = [];
if (_sector getVariable ["BIS_WL_autoPopulateVehicles", true]) then {
	private _sectorArea = _sector getVariable "objectAreaComplete";
	_sectorArea params ["_center", "_a", "_b"];

	private _waterPositions = _sector call WL2_fnc_findNavalSpawnPositions;

	private _vehiclesToSelect = [];
	if (count _waterPositions > 0) then {
		_vehiclesToSelect append (serverNamespace getVariable "WL2_populateNavalPoolList");
	};

	private _roads = ((_sector nearRoads 400) select {count roadsConnectedTo _x > 0}) inAreaArray _sectorArea;
	if (count _roads > 0) then {
		_vehiclesToSelect append (serverNamespace getVariable "WL2_populateVehiclePoolList");
	};

	if (count _vehiclesToSelect > 0) then {
		private _hasRadar = false;
		private _hardAIMode = WL_HARD_AI_MODE == 1;
		private _numVehicleSpawn = if (_hardAIMode) then {
			private _sectorValue = _sector getVariable ["BIS_WL_value", 50];
			((_sectorValue / 5) max 1) min 4;
		} else {
			1;
		};

		for "_i" from 1 to _numVehicleSpawn do {
			private _vehicleToSpawn = selectRandom _vehiclesToSelect;

			private _pos = [];
			private _dir = 0;

			if (_vehicleToSpawn isKindOf "LandVehicle") then {
				private _road = selectRandom _roads;
				_pos = position _road;
				_dir = _road getDir selectRandom (roadsConnectedTo _road);
			};

			if (_vehicleToSpawn isKindOf "Ship") then {
				_pos = selectRandom _waterPositions;
			};

			_vehicleArray = [_pos, _dir, _vehicleToSpawn, _owner] call BIS_fnc_spawnVehicle;
			_vehicleArray params ["_vehicle", "_crew", "_group"];

			_vehicle call WL2_fnc_newAssetHandle;

			_units pushBack _vehicle;

			{
				_x call WL2_fnc_newAssetHandle;
				_units pushBack _x;
			} forEach _crew;

			[_group, 0] setWaypointPosition [position _vehicle, 100];
			_group setBehaviour "COMBAT";
			_group deleteGroupWhenEmpty true;

			_wp = _group addWaypoint [_pos, 100];
			_wp setWaypointType "SAD";

			_wp = _group addWaypoint [_pos, 100];
			_wp setWaypointType "CYCLE";

			_vehicle allowCrewInImmobile [true, true];

			if (typeOf _vehicle == "I_LT_01_scout_F") then {
				_hasRadar = true;

				_vehicle setVehicleReportRemoteTargets true;
				_vehicle setVehicleReceiveRemoteTargets true;
				_vehicle setVehicleReportOwnPosition true;
			};
		};

		if (_hasRadar && _hardAIMode) then {
			private _samLocation = selectRandom ([_sector, 0, true] call WL2_fnc_findSpawnPositions);
			private _createSamResult = [_samLocation, 0, "I_E_SAM_System_03_F", resistance] call BIS_fnc_spawnVehicle;
			private _sam = _createSamResult select 0;
			for "_i" from 1 to 10 do {
				_sam addMagazineTurret ["magazine_Missile_mim145_x4", [0]];
			};

			_sam setVehicleReportRemoteTargets true;
			_sam setVehicleReceiveRemoteTargets true;
			_sam setVehicleReportOwnPosition true;

			_sam call WL2_fnc_newAssetHandle;
			_units pushBack _sam;
		};
	};	
};
	

if (count (_sector getVariable ["BIS_WL_vehiclesToSpawn", []]) > 0) then {
	{
		_vehicleInfo = _x;
		_vehicleInfo params ["_type", "_pos", "_dir", "_lock", "_waypoints"];
		_vehicleArray = [_pos, _dir, _type, _owner] call BIS_fnc_spawnVehicle;
		_vehicleArray params ["_vehicle", "_crew", "_group"];

		_vehicle call WL2_fnc_newAssetHandle;
		_units pushBack _vehicle;

		{
			_x call WL2_fnc_newAssetHandle;
			_units pushBack _x;
		} forEach _crew;

		_posVic = position _vehicle;
		[_group, 0] setWaypointPosition [_posVic, 100];
		_group setBehaviour "COMBAT";
		_group deleteGroupWhenEmpty true;

		_wp = _group addWaypoint [_posVic, 100];
		_wp setWaypointType "SAD";

		_wp1 = _group addWaypoint [_posVic, 100];
		_wp1 setWaypointType "CYCLE";

		_vehicle allowCrewInImmobile [true, true];
	} forEach (_sector getVariable "BIS_WL_vehiclesToSpawn");
};
_sector setVariable ["BIS_WL_vehiclesToSpawn", nil];
	

if (count (_sector getVariable ["BIS_WL_groupsToSpawn", []]) > 0) then {
	{
		_groupInfo = _x;
		_groupInfo params ["_side", "_waypoints", "_groupUnits"];
		
		private _newGrp = createGroup _side;
		private _startPos = [];
		
		{
			_unitInfo = _x;
			_unitInfo params ["_type", "_pos", "_skill", "_loadout"];
			_startPos = _pos;

			_newUnit = _newGrp createUnit [_type, _pos, [], 0, "CAN_COLLIDE"];
			_newUnit setUnitLoadout _loadout;
			_newUnit call WL2_fnc_newAssetHandle;
			
			_units pushBack _newUnit;
		} forEach _groupUnits;
		
		_newGrp setBehaviour "COMBAT";
		_newGrp setSpeedMode "LIMITED";
		_newGrp deleteGroupWhenEmpty true;

		if (count _waypoints != 0) then {
			{
				_waypointInfo = _x;
				_waypointInfo params ["_position", "_wpType", "_speed", "_behavior", "_timeout"];
				_newWp = _newGrp addWaypoint [_position, 0];
				_newWp setWaypointType _wpType;
				_newWp setWaypointSpeed _speed;
				_newWp setWaypointBehaviour _behavior;
				_newWp setWaypointTimeout _timeout;
			} forEach _waypoints;
		} else {
			[_newGrp, 0] setWaypointPosition [_startPos, 100];
			_newGrp setBehaviour "COMBAT";
			_newGrp deleteGroupWhenEmpty true;
			
			_wp = _newGrp addWaypoint [_startPos, 100];
			_wp setWaypointType "SAD";
			
			_wp1 = _newGrp addWaypoint [_startPos, 100];
			_wp1 setWaypointType "CYCLE";
		};
	} forEach (_sector getVariable "BIS_WL_groupsToSpawn");
};


_connectedToBase = count ((profileNamespace getVariable "BIS_WL_lastBases") arrayIntersect (_sector getVariable "BIS_WL_connectedSectors")) > 0;
if (!_connectedToBase && {"H" in (_sector getVariable "BIS_WL_services")}) then {
	private _neighbors = (_sector getVariable "BIS_WL_connectedSectors") select {(_x getVariable "BIS_WL_owner") == _owner};

	if (count _neighbors > 0) then {
		_vehicleArray = [position selectRandom _neighbors, 0, selectRandom (serverNamespace getVariable "WL2_populateAircraftPoolList"), _owner] call BIS_fnc_spawnVehicle;
		_vehicleArray params ["_vehicle", "_crew", "_group"];

		_vehicle call WL2_fnc_newAssetHandle;
		_units pushBack _vehicle;

		{
			_x call WL2_fnc_newAssetHandle;
			_units pushBack _x;
		} forEach _crew;

		[_group, 0] setWaypointPosition [position _vehicle, 300];
		_group setBehaviour "COMBAT";
		_group deleteGroupWhenEmpty true;

		_wp1 = _group addWaypoint [position _sector vectorAdd [0, 0, 300], 300];
		_wp1 setWaypointType "SAD";

		_wp2 = _group addWaypoint [position _sector vectorAdd [0, 0, 300], 300];
		_wp2 setWaypointType "SAD";

		_wp3 = _group addWaypoint [waypointPosition _wp1 vectorAdd [0, 0, 300], 300];
		_wp3 setWaypointType "CYCLE";

		_vehicle allowCrewInImmobile [true, true];
	};
};
[_units, _sector] spawn WL2_fnc_assetRelevanceCheck;

private _spawnPosArr = [_sector, 0, true] call WL2_fnc_findSpawnPositions;
if (count _spawnPosArr == 0) exitWith {};

private _garrisonSize = (_sector getVariable "BIS_WL_value") * 2.3; // * x: the bigger x the more ai
private _unitsPool = serverNamespace getVariable ["WL2_populateUnitPoolList", []];
private _infantryUnits = [];
private _infantryGroups = [];
_i = 0;
while {_i < _garrisonSize} do {
	private _pos = selectRandom _spawnPosArr;
	/*
	//***Spawning Diag code, visual tool for spawn points***
	{
       	private _posNumber = str _x;
    	_mrkr = createMarkerLocal [_posNumber, _x];
		_mrkr setMarkerColorLocal "ColorRed";
    	_mrkr setMarkerTypeLocal "loc_LetterX";
    	_mrkr setMarkerSizeLocal [1, 1];
    } forEach _spawnPosArr;

    private _posNumber = str _i;
    _mrkr = createMarkerLocal [_posNumber, _pos];
    _mrkr setMarkerTypeLocal "mil_dot_noShadow";
    _mrkr setMarkerSizeLocal [1.5, 1.5];
	//***end diag code block***
	*/
	private _newGrp = createGroup _owner;
	_infantryGroups pushBack _newGrp;
	private _grpSize = floor (10 + random 3);
	private _cnt = (count allPlayers) max 1;

	private _i2 = 0;
	for "_i2" from 0 to _grpSize do {
		private _newUnit = _newGrp createUnit [selectRandom _unitsPool, _pos, [], 100, "NONE"];
		private _posAboveGround = getPosATL _newUnit;
		_posAboveGround set [2, 100];
		_newUnit setVehiclePosition [_posAboveGround, [], 0, "CAN_COLLIDE"];
		_newUnit call WL2_fnc_newAssetHandle;
		_infantryUnits pushBack _newUnit;

		_i = _i + (((_cnt/50) max 0.6) min 2);
		if (_i >= _garrisonSize) exitwith {};
	};

	_newGrp setBehaviour "COMBAT";
	_newGrp setSpeedMode "LIMITED";
	[_newGrp, 0] setWaypointPosition [_pos, 0];
	_newGrp deleteGroupWhenEmpty true;

	_newWP = _newGrp addWaypoint [_pos, 0];
	_newWP setWaypointType "HOLD";
	sleep 0.001;
};

// {
// 	private _infantryUnit = _x;
// 	{
// 		_x reveal [_infantryUnit, 4];
// 	} forEach _infantryGroups
// } forEach _infantryUnits;

[_infantryUnits, _sector] spawn WL2_fnc_assetRelevanceCheck;