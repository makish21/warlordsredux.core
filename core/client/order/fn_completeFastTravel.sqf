#include "..\..\warlords_constants.inc"

params ["_fastTravelMode", "_destination", ["_sectorPos", [0, 0, 0]]];


private _tagAlong = (units player) select {
	(_x distance2D player <= 100) &&
	(isNull objectParent _x) &&
	(alive _x) &&
	(_x != player) &&
	_x getVariable ["BIS_WL_ownerAsset", "123"] == getPlayerUID player
};


switch (_fastTravelMode) do {
	case WL_FAST_TRAVEL_MODE_SEIZED: {
		{
			_x setVehiclePosition [_destination, [], 3, "NONE"];
		} forEach _tagAlong;
		player setVehiclePosition [_destination, [], 0, "NONE"];
	};
	case WL_FAST_TRAVEL_MODE_CONTESTED: {
		{
			_x setVehiclePosition [_destination, [], 3, "NONE"];
		} forEach _tagAlong;
		player setVehiclePosition [_destination, [], 0, "NONE"];
		
		private _directionToSector = _destination getDir _sectorPos;
		player setDir _directionToSector;
	};
	case WL_FAST_TRAVEL_MODE_AIR_ASSAULT: {
		private _directionToSector = _destination getDir _sectorPos;
		{
			_x setPosASL _destination;
			_x setDir _directionToSector;
			_x setVelocityModelSpace [0, 30, 0];
			[_x] spawn WL2_fnc_parachuteSetup;
		} forEach _tagAlong;

		player setPosASL _destination;
		player setDir _directionToSector;
		player setVelocityModelSpace [0, 30, 0];
		[player] spawn WL2_fnc_parachuteSetup;
	};
	case WL_FAST_TRAVEL_MODE_VEHICLE_PARADROP;
	case WL_FAST_TRAVEL_MODE_VEHICLE_PARADROP_FOB: {
		private _vehicle = vehicle player;

		private _parachuteClass = switch (BIS_WL_playerSide) do {
			case west: {
				"B_Parachute_02_F";
			};
			case east: {
				"O_Parachute_02_F";
			};
			case independent: {
				"I_Parachute_02_F";
			};
		};

		private _vehicleDir = getDir _vehicle;
		private _parachute = createVehicle [_parachuteClass, _destination, [], 0, "NONE"];
		_parachute setDir _vehicleDir;
		_vehicle attachTo [_parachute, [0, 0, 0]];
		[_vehicle, _parachute] spawn {
			params ["_vehicle", "_parachute"];
			waitUntil {
				sleep 0.2;
				_parachute setVelocity [0, 0, (velocity _parachute) # 2];
				_parachute setVectorUp [0, 0, 1];
				(getPosATL _vehicle # 2) < 5
			};
			detach _vehicle;
			deleteVehicle _parachute;
		};
	};
	case WL_FAST_TRAVEL_MODE_TENT: {
        if (count _destination > 0) then {
            private _oldPlayerPos = getPosASL player;
            player setVehiclePosition [_destination, [], 0, "NONE"];
            private _newPos = getPosATL player;

            if (abs ((_destination # 2) - (_newPos # 2)) > 5) then {
                systemChat "Your tent was left in an invalid spot. Make sure to place it in an open spot outside next time.";
                player setPosASL _oldPlayerPos;
            } else {
				{
					_x setVehiclePosition [_destination, [], 3, "NONE"];
				} forEach _tagAlong;
			};

			private _respawnBag = player getVariable ["WL2_respawnBag", objNull];
			if (!isNull _respawnBag) then {
				deleteVehicle _respawnBag;
			};
            player setVariable ["WL2_respawnBag", objNull, [2, clientOwner]];
        };
	};
	case WL_FAST_TRAVEL_MODE_STRONGHOLD;
	case WL_FAST_TRAVEL_MODE_FOB: {
		{
			_x setVehiclePosition [_destination, [], 3, "NONE"];
		} forEach _tagAlong;

		player setVehiclePosition [_destination, [], 0, "NONE"];
	};
};

sleep 1;

titleCut ["", "BLACK IN", 1];

switch (_fastTravelMode) do {
	case WL_FAST_TRAVEL_MODE_SEIZED: {
		["TaskFastTravelSeized"] call WLT_fnc_taskComplete;
	};
	case WL_FAST_TRAVEL_MODE_CONTESTED: {
		["TaskFastTravelConflict"] call WLT_fnc_taskComplete;
	};
	case WL_FAST_TRAVEL_MODE_AIR_ASSAULT: {
		["TaskAirAssault"] call WLT_fnc_taskComplete;
	};
	case WL_FAST_TRAVEL_MODE_VEHICLE_PARADROP: {
		["TaskVehicleParadrop"] call WLT_fnc_taskComplete;
	};
	case WL_FAST_TRAVEL_MODE_TENT: {
		["TaskFastTravelTent"] call WLT_fnc_taskComplete;
	};
};
