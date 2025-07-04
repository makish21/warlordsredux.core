RITA_vics = ["O_Plane_Fighter_02_F", "O_Plane_Fighter_02_Stealth_F", "O_Plane_Fighter_02_Cluster_F", "O_Plane_CAS_02_dynamicLoadout_F", "O_Plane_CAS_02_Cluster_F", "O_Heli_Attack_02_dynamicLoadout_F"];

RITA_sayWait = {
	params ["_soundName", "_volumeParam"];

	private _id = playSoundUI [_soundName, (profileNamespace getVariable [_volumeParam, 0.3]), 1];
	(soundParams _id) params ["_path", "_curPos", "_length", "_time", "_volume"];
	sleep (_length - _time);
};

RITA_altitudeTracker = {
	params ["_aircraft"];

	scriptName format ["Rita_altitude_tracker_%1", typeOf _aircraft];

	private _altitudeCeil = 2000;
	private _altitudeFloor = 100;

	while { profileNamespace getVariable ["MRTM_EnableRWR", true] } do {
		if (_aircraft getVariable "landingGear") then { sleep 1; continue }; // probably landing
		private _altitude = getPosATL _aircraft select 2;
		if (_altitude > _altitudeCeil) then { sleep 1; continue }; // aircraft too high

		if (_altitude > _altitudeFloor) then {
			// pull up warning branch

			if !(asin (vectorDir _aircraft select 2) < - ((_altitude * 40) / speed _aircraft)) then { sleep 0.2; continue };
			
			private _pitchBank = _aircraft call BIS_fnc_getPitchBank;
			_pitchBank params ["_pitch", "_bank"];

			if (_aircraft getVariable "isBettyBitching") then { sleep 0.2; continue }; // rita saying something
			
			_aircraft setVariable ["isBettyBitching", true];
			if (_altitude < 300) then {
				switch true do {
					case (_bank < -75): { ["ritaRollRight", "MRTM_rwr1"] call RITA_sayWait };
					case (_bank > 75): { ["ritaRollLeft", "MRTM_rwr1"] call RITA_sayWait };
					default {};
				};
			};
			["ritaPullUp", "MRTM_rwr1"] call RITA_sayWait;
			_aircraft setVariable ["isBettyBitching", false];

			sleep 0.5;
		} else {
			// altitude warning branch

			if (_aircraft getVariable "isBettyBitching") then { sleep 0.2; continue }; // rita saying something
			_aircraft setVariable ["isBettyBitching", true];
			["ritaAltitude", "MRTM_rwr2"] call RITA_sayWait;
			_aircraft setVariable ["isBettyBitching", false];

			sleep 1;
		};
	};
};


RITA_fuelTracker = {
	params ["_aircraft"];

	scriptName format ["Rita_fuel_tracker_%1", typeOf _aircraft];

	if !(profileNamespace getVariable ["MRTM_EnableRWR", true]) exitWith {};

	// low fuel
	waitUntil { sleep 5; fuel _aircraft < 0.2 };
	waitUntil { sleep 0.2; !(_aircraft getVariable "isBettyBitching") };
	if (profileNamespace getVariable ["MRTM_EnableRWR", true]) then {
		_aircraft setVariable ["isBettyBitching", true];
		["ritaBingoFuel", "MRTM_rwr4"] call RITA_sayWait;
		_aircraft setVariable ["isBettyBitching", false];
	};

	// critical fuel
	waitUntil { sleep 5; fuel _aircraft < 0.1 }; 
	waitUntil { sleep 0.2; !(_aircraft getVariable "isBettyBitching") };
	if (profileNamespace getVariable ["MRTM_EnableRWR", true]) then {
		_aircraft setVariable ["isBettyBitching", true];
		["ritaCriticalFuel", "MRTM_rwr4"] call RITA_sayWait;
		_aircraft setVariable ["isBettyBitching", false];
	};
};


RITA_missileTracker = {
	params ["_aircraft"];

	scriptName format ["Rita_missile_tracker_%1", typeOf _aircraft];

	while { profileNamespace getVariable ["MRTM_EnableRWR", true] } do {
		private _incoming = _aircraft getVariable ["Incomming", []];
		private _aliveIncoming = _incoming select { alive _x };
		_aircraft setVariable ["Incomming", _aliveIncoming];

		if (count _aliveIncoming == 0) then { sleep 1; continue };

		_missile = _aliveIncoming # 0;
		_mDir = _aircraft getRelDir _missile;
		_3Dir = abs (90 - _mDir);
		_6Dir = abs (180 - _mDir);
		_9Dir = abs (270 - _mDir);
		_12Dir = abs (360 - _mDir);
		_0Dir = abs (0 - _mDir);

		_fDir = 0;
		switch (true) do {
			case ((_6Dir < _9Dir) && {(_6Dir < _3Dir) && {(_6Dir < _0Dir) && {(_6Dir < _12Dir)}}}): {
				_fDir = 180;
			};
			case (((_3Dir < _6Dir)) && {(_3Dir < _0Dir) && {(_3Dir < _12Dir) && {(_3Dir < _9Dir)}}}): {
				_fDir = 90;
			};
			case ((_9Dir < _6Dir) && {(_9Dir < _0Dir) && {(_9Dir < _12Dir) && {(_9Dir < _3Dir)}}}): {
				_fDir = 270;
			};
		};

		private _dirSound = format ["rita_%1", _fDir];

		if (_aircraft getVariable "isBettyBitching") then { sleep 0.2; continue }; // rita saying something
		_aircraft setVariable ["isBettyBitching", true];
		["ritaMissile", "MRTM_rwr4"] call RITA_sayWait;
		[_dirSound, "MRTM_rwr4"] call RITA_sayWait;
		_aircraft setVariable ["isBettyBitching", false];

		sleep 1;
	};
};


RITA_gForceTracker = {
	params ["_aircraft"];

	scriptName format ["Rita_g_force_tracker_%1", typeOf _aircraft];

	while { profileNamespace getVariable ["MRTM_EnableRWR", true] } do {
		private _start = time;

		// Get initial position and velocity
		private _vel1 = velocity _aircraft;
		
		sleep 0.1;

		// Get final position and velocity
		private _vel2 = velocity _aircraft;

		// Calculate velocity change
		private _velChange = _vel2 vectorDiff _vel1;

		private _magnitude = vectorMagnitude _velChange;

		private _end = time;
		private _elapsed = _end - _start;

		// Calculate acceleration magnitude
		private _acceleration = _magnitude / _elapsed;

		// Define standard gravity
		private _g = 9.81;

		// Calculate G-force
		private _gForce = _acceleration / _g;

		if (_gForce <= 10) then { continue };

		if (_aircraft getVariable "isBettyBitching") then { sleep 0.2; continue }; // rita saying something
		_aircraft setVariable ["isBettyBitching", true];
		["ritaOverG", "MRTM_rwr4"] call RITA_sayWait;
		_aircraft setVariable ["isBettyBitching", false];

		sleep 1;
	};
};


RITA_targetLockTracker = {
	params ["_aircraft"];

	scriptName format ["Rita_target_tracker_%1", typeOf _aircraft];

	while { profileNamespace getVariable ["MRTM_EnableRWR", true] } do {
		playerTargetLock params ["_target", "_lock", "_cfg"];

		if (_lock < 1) then { sleep 0.5; continue };

		private _parents = [_cfg, true] call BIS_fnc_returnParents;
		if !("LauncherCore" in _parents) then { sleep 0.5; continue }; // not a missile launcher

		if (_aircraft getVariable "isBettyBitching") then { sleep 0.2; continue }; // rita saying something

		_aircraft setVariable ["isBettyBitching", true];
		["ritaLock", "MRTM_rwr4"] call RITA_sayWait;
		_aircraft setVariable ["isBettyBitching", false];

		waitUntil { 
			sleep 0.5;

			playerTargetLock params ["_target", "_lock", "_cfg"];

			_lock < 1
		};
	};
};


RITA_speedTracker = {
	params ["_aircraft"];

	scriptName format ["Rita_speed_tracker_%1", typeOf _aircraft];

	while { profileNamespace getVariable ["MRTM_EnableRWR", true] } do {
		if (_aircraft getVariable "landingGear") then { sleep 5; continue }; // probably landing
		if (speed _aircraft > 200) then { sleep 5; continue };

		if (_aircraft getVariable "isBettyBitching") then { sleep 0.2; continue }; // rita saying something

		_aircraft setVariable ["isBettyBitching", true];
		["ritaCriticalSpeed", "MRTM_rwr4"] call RITA_sayWait;
		_aircraft setVariable ["isBettyBitching", false];

		sleep 1;
	};
};


RITA_clearTrackers = {
	params ["_aircraft"];

	private _altitudeTrackerHandle = _aircraft getVariable "altitudeTracker";
	if !(isNil "_altitudeTrackerHandle") then {
		terminate _altitudeTrackerHandle;
		_aircraft setVariable ["altitudeTracker", nil];
	};
	private _fuelTrackerHandle = _aircraft getVariable "fuelTracker";
	if !(isNil "_fuelTrackerHandle") then {
		terminate _fuelTrackerHandle;
		_aircraft setVariable ["fuelTracker", nil];
	};
	private _missileTrackerHandle = _aircraft getVariable "missileTracker";
	if !(isNil "_missileTrackerHandle") then {
		terminate _missileTrackerHandle;
		_aircraft setVariable ["missileTracker", nil];
	};
	private _gForceTrackerHandle = _aircraft getVariable "gForceTracker";
	if !(isNil "_gForceTrackerHandle") then {
		terminate _gForceTrackerHandle;
		_aircraft setVariable ["gForceTracker", nil];
	};
	private _targetLockTrackerHandle = _aircraft getVariable "targetTracker";
	if !(isNil "_targetLockTrackerHandle") then {
		terminate _targetLockTrackerHandle;
		_aircraft setVariable ["targetTracker", nil];
	};
	private _speedTrackerHandle = _aircraft getVariable "speedTracker";
	if !(isNil "_speedTrackerHandle") then {
		terminate _speedTrackerHandle;
		_aircraft setVariable ["speedTracker", nil];
	};

	private _gearEhIdx = _aircraft getVariable "gearEhIdx";
	if !(isNil "_gearEhIdx") then {
		_aircraft removeEventHandler ["Gear", _gearEhIdx];
		_aircraft setVariable ["gearEhIdx", nil];
	};
	private _incMissileEhIdx = _aircraft getVariable "missileEhIdx";
	if !(isNil "_incMissileEhIdx") then {
		_aircraft removeEventHandler ["Gear", _incMissileEhIdx];
		_aircraft setVariable ["missileEhIdx", nil];
	};
	private _firedEhIdx = _aircraft getVariable "firedEhIdx";
	if !(isNil "_firedEhIdx") then {
		_aircraft removeEventHandler ["Fired", _firedEhIdx];
		_aircraft setVariable ["firedEhIdx", nil];
	};
	private _dammagedEhIdx = _aircraft getVariable "dammagedEhIdx";
	if !(isNil "_dammagedEhIdx") then {
		_aircraft removeEventHandler ["Dammaged", _dammagedEhIdx];
		_aircraft setVariable ["dammagedEhIdx", nil];
	};
	private _killedEhIdx = _aircraft getVariable "killedEhIdx";
	if !(isNil "_killedEhIdx") then {
		_aircraft removeEventHandler ["Killed", _killedEhIdx];
		_aircraft setVariable ["killedEhIdx", nil];
	};
};


player addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];

	if !((typeOf _vehicle) in RITA_vics) exitWith {};

	_vehicle setVariable ["isBettyBitching", false];
	_vehicle setVariable ["landingGear", !(_vehicle isKindOf "Helicopter")];
	_vehicle setVariable ["Incomming", []];

	private _gearEhIdx = _vehicle addEventHandler ["Gear", {
		params ["_vehicle", "_gearState"];
		
		_vehicle setVariable ["landingGear", _gearState];

		if !(_gearState) exitWith {};
		if (speed _vehicle < 500) exitWith {};

		if !((profileNamespace getVariable ["MRTM_EnableRWR", true])) exitWith {};

		[_vehicle] spawn {
			params ["_v"];
			
			waitUntil { sleep 0.2; !(_v getVariable "isBettyBitching") };
			_v setVariable ["isBettyBitching", true];
			["ritaGear", "MRTM_rwr4"] call RITA_sayWait;
			_v setVariable ["isBettyBitching", false];
		};
	}];
	_vehicle setVariable ["gearEhIdx", _gearEhIdx];

	private _incMissileEhIdx = _vehicle addEventHandler ["IncomingMissile", {
		params ["_target", "_ammo", "_vehicle", "_instigator", "_missile"];
		_inc = _target getVariable "Incomming";
		_inc pushBackUnique _missile;
		_target setVariable ["Incomming", _inc];
	}];
	_vehicle setVariable ["missileEhIdx", _incMissileEhIdx];

	private _firedEhIdx = _vehicle addEventHandler ["Fired", {
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

		if !((profileNamespace getVariable ["MRTM_EnableRWR", true])) exitWith {};
		private _isFlareLauncher = ["CMFlareLauncher", _weapon, false] call BIS_fnc_inString;
		if !(_isFlareLauncher) exitWith {};

		[_unit] spawn {
			params ["_v"];
			if (_v getVariable "isBettyBitching") exitWith {};

			_v setVariable ["isBettyBitching", true];
			["ritaCas", "MRTM_rwr4"] call RITA_sayWait;
			_v setVariable ["isBettyBitching", false];
		};
	}];
	_vehicle setVariable ["firedEhIdx", _firedEhIdx];

	private _dammagedEhIdx = _vehicle addEventHandler ["Dammaged", {
		params ["_unit", "_hitSelection", "_damage", "_hitPartIndex", "_hitPoint", "_shooter", "_projectile"];

		if (["hithull", "_hitPoint", false] call BIS_fnc_inString) then {
			if (_damage < 0.9) exitWith {};

			[_unit] spawn {
				params ["_v"];
				if (_v getVariable "isBettyBitching") exitWith {};

				_v setVariable ["isBettyBitching", true];
				["ritaEject", "MRTM_rwr4"] call RITA_sayWait;
				_v setVariable ["isBettyBitching", false];
			};
		};

		if (["hitengine", "_hitPoint", false] call BIS_fnc_inString) then {
			if (_damage < 0.5) exitWith {};

			[_unit] spawn {
				params ["_v"];
				if (_v getVariable "isBettyBitching") exitWith {};

				_v setVariable ["isBettyBitching", true];
				["ritaEngine", "MRTM_rwr4"] call RITA_sayWait;
				_v setVariable ["isBettyBitching", false];
			};
		};
	}];
	_vehicle setVariable ["dammagedEhIdx", _dammagedEhIdx];
	
	private _killedEhIdx = _vehicle addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];

		[_unit] call RITA_clearTrackers;
	}];
	_vehicle setVariable ["killedEhIdx", _killedEhIdx];

	private _altitudeTrackerHandle = [_vehicle] spawn RITA_altitudeTracker;
	_vehicle setVariable ["altitudeTracker", _altitudeTrackerHandle];
	private _fuelTrackerHandle = [_vehicle] spawn RITA_fuelTracker;
	_vehicle setVariable ["fuelTracker", _fuelTrackerHandle];
	private _missileTrackerHandle = [_vehicle] spawn RITA_missileTracker;
	_vehicle setVariable ["missileTracker", _missileTrackerHandle];
	private _gForceTrackerHandle = [_vehicle] spawn RITA_gForceTracker;
	_vehicle setVariable ["gForceTracker", _gForceTrackerHandle];
	private _targetLockTrackerHandle = [_vehicle] spawn RITA_targetLockTracker;
	_vehicle setVariable ["targetTracker", _targetLockTrackerHandle];

	if !(_vehicle isKindOf "Helicopter") then {
		private _speedTrackerHandle = [_vehicle] spawn RITA_speedTracker;
		_vehicle setVariable ["speedTracker", _speedTrackerHandle];
	};
}];

player addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret", "_isEject"];

	if !(typeOf _vehicle in RITA_vics) exitWith {};

	[_vehicle] call RITA_clearTrackers;
}];

