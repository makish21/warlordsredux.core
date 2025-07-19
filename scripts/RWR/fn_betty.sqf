BETTY_vics = ["B_Plane_Fighter_01_F", "B_Plane_CAS_01_dynamicLoadout_F", "B_Heli_Attack_01_dynamicLoadout_F", "B_T_VTOL_01_armed_F", "B_T_VTOL_01_vehicle_F", "B_T_VTOL_01_infantry_F"];

BETTY_sayWait = {
	params ["_soundName", "_volumeParam"];

	private _id = playSoundUI [_soundName, (profileNamespace getVariable [_volumeParam, 0.3]), 1];
	(soundParams _id) params ["_path", "_curPos", "_length", "_time", "_volume"];
	sleep (_length - _time);
};


BETTY_altitudeTracker = {
	params ["_aircraft"];

	scriptName format ["BETTY_altitude_tracker_%1", typeOf _aircraft];

	private _altitudeCeil = 2000;

	while { profileNamespace getVariable ["MRTM_EnableRWR", true] } do {
		if (_aircraft getVariable "landingGear") then { sleep 1; continue }; // probably landing
		private _altitude = getPosATL _aircraft select 2;
		if (_altitude > _altitudeCeil) then { sleep 1; continue }; // aircraft too high

		private _altitudeFloor = (speed _aircraft * 0.2) min 100; // 50m feels safe on 250 km/h

		if (_altitude > _altitudeFloor) then {
			// pull up warning branch

			if !(asin (vectorDir _aircraft select 2) < - ((_altitude * 40) / speed _aircraft)) then { sleep 0.2; continue };
			
			if (_aircraft getVariable ["isBettyBitching", true]) then { sleep 0.2; continue };
			
			_aircraft setVariable ["isBettyBitching", true];
			["bettyPullUp", "MRTM_rwr1"] call BETTY_sayWait;
			_aircraft setVariable ["isBettyBitching", false];

			sleep 0.5;
		} else {
			// altitude warning branch

			if (_aircraft getVariable ["isBettyBitching", true]) then { sleep 0.2; continue };
			_aircraft setVariable ["isBettyBitching", true];
			["bettyAltitude", "MRTM_rwr2"] call BETTY_sayWait;
			_aircraft setVariable ["isBettyBitching", false];

			sleep 1;
		};
	};
};


BETTY_fuelTracker = {
	params ["_aircraft"];

	scriptName format ["BETTY_fuel_tracker_%1", typeOf _aircraft];

	if !(profileNamespace getVariable ["MRTM_EnableRWR", true]) exitWith {};

	// low fuel
	waitUntil { sleep 5; fuel _aircraft < 0.2 };
	waitUntil { sleep 0.2; !(_aircraft getVariable ["isBettyBitching", true]) };
	if (profileNamespace getVariable ["MRTM_EnableRWR", true]) then {
		_aircraft setVariable ["isBettyBitching", true];
		["bettyBingoFuel", "MRTM_rwr3"] call BETTY_sayWait;
		_aircraft setVariable ["isBettyBitching", false];
	};
};


BETTY_missileTracker = {
	params ["_aircraft"];

	scriptName format ["BETTY_missile_tracker_%1", typeOf _aircraft];

	while { profileNamespace getVariable ["MRTM_EnableRWR", true] } do {
		private _incoming = _aircraft getVariable ["incoming", []];
		private _aliveIncoming = _incoming select { alive _x };
		_aircraft setVariable ["incoming", _aliveIncoming];

		if (count _aliveIncoming == 0) then { sleep 1; continue };

		private _sortedMissiles = [_aliveIncoming, [], { _aircraft distance _x }, "ASCEND"] call BIS_fnc_sortBy;
		private _nearestMissile = _sortedMissiles # 0;

		private _relativePos = _aircraft worldToModel (position _nearestMissile);
		_relativePos params ["_relX", "_relY", "_relZ"];

		private _dirName = if ((abs _relX) > (abs _relY)) then { // left or right
			if (_relX > 0) then { // right
				90
			} else { // left
				270
			};
		} else { // front or rear
			if (_relY > 0) then { // front
				0
			} else { // rear
				180
			};
		};
		
		if (_aircraft getVariable ["isBettyBitching", true]) then { sleep 0.2; continue };
		_aircraft setVariable ["isBettyBitching", true];
		private _dirSound = format ["bettyIncMissile_%1", _dirName];
		[_dirSound, "MRTM_rwr3"] call BETTY_sayWait;
		_aircraft setVariable ["isBettyBitching", false];

		sleep 1.5;
	};
};


BETTY_sensorTracker = {
	params ["_aircraft"];

	scriptName format ["BETTY_sensor_tracker_%1", typeOf _aircraft];

	private _currTargets = [];

	while { profileNamespace getVariable ["MRTM_EnableRWR", true] } do {
		private _newTargets = getSensorTargets _aircraft;

		if (count _newTargets > count _currTargets) then { // no need to wait for betty
			private _id = playSoundUI ["bettyRadarTargetNew", (profileNamespace getVariable ["MRTM_rwr4", 0.3]), 1];
			(soundParams _id) params ["_path", "_curPos", "_length", "_time", "_volume"];
			sleep (_length - _time);
		};

		if (count _newTargets < count _currTargets) then {
			private _id = playSoundUI ["bettyRadarTargetLost", (profileNamespace getVariable ["MRTM_rwr4", 0.3]), 1];
			(soundParams _id) params ["_path", "_curPos", "_length", "_time", "_volume"];
			sleep (_length - _time);
		};

		_currTargets = _newTargets;
		sleep 1;
	};
};


BETTY_activeScripts = [];
BETTY_eventHandlers = createHashMap;

BETTY_cleanup = {
	params ["_aircraft"];

	{
		terminate _x;
	} forEach BETTY_activeScripts;
	BETTY_activeScripts resize 0;

	{
		_aircraft removeEventHandler [_x, _y];
	} forEach BETTY_eventHandlers;
};

BETTY_deleteScript = {
	params ["_script"];

	private _idx = BETTY_activeScripts find _thisScript;
	if (_idx == -1) exitWith {};
	
	BETTY_activeScripts deleteAt _idx;
};


player addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];

	if !((typeOf _vehicle) in BETTY_vics) exitWith {};

	_vehicle setVariable ["isBettyBitching", false];
	_vehicle setVariable ["landingGear", !(_vehicle isKindOf "Helicopter")];
	_vehicle setVariable ["incoming", []];

	private _incMissileEhIdx = _vehicle addEventHandler ["IncomingMissile", {
		params ["_target", "_ammo", "_vehicle", "_instigator", "_missile"];
		_inc = _target getVariable "incoming";
		_inc pushBackUnique _missile;
		_target setVariable ["incoming", _inc];
	}];
	BETTY_eventHandlers set ["IncomingMissile", _incMissileEhIdx];

	private _killedEhIdx = _vehicle addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];

		[_unit] call BETTY_cleanup;
	}];
	BETTY_eventHandlers set ["Killed", _killedEhIdx];

	BETTY_activeScripts pushBack ([_vehicle] spawn BETTY_fuelTracker);
	BETTY_activeScripts pushBack ([_vehicle] spawn BETTY_missileTracker);
	BETTY_activeScripts pushBack ([_vehicle] spawn BETTY_sensorTracker);
	if !(_vehicle isKindOf "Helicopter") then {
		BETTY_activeScripts pushBack ([_vehicle] spawn BETTY_altitudeTracker);
	};
}];

player addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret", "_isEject"];

	if !(typeOf _vehicle in BETTY_vics) exitWith {};

	[_vehicle] call BETTY_cleanup;
}];

