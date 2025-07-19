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

	while { profileNamespace getVariable ["MRTM_EnableRWR", true] } do {
		if (_aircraft getVariable "landingGear") then { sleep 1; continue }; // probably landing
		private _altitude = getPosATL _aircraft select 2;
		if (_altitude > _altitudeCeil) then { sleep 1; continue }; // aircraft too high

		private _altitudeFloor = (speed _aircraft * 0.2) min 100; // 50m feels safe on 250 km/h

		if (_altitude > _altitudeFloor) then {
			// pull up warning branch

			if !(asin (vectorDir _aircraft select 2) < - ((_altitude * 40) / speed _aircraft)) then { sleep 0.2; continue };
			
			private _pitchBank = _aircraft call BIS_fnc_getPitchBank;
			_pitchBank params ["_pitch", "_bank"];

			if (_aircraft getVariable ["isRitaBusy", true]) then { sleep 0.2; continue }; // rita saying something
			
			_aircraft setVariable ["isRitaBusy", true];
			switch true do {
				case (_bank < -75): { ["ritaRollRight", "MRTM_rwr1"] call RITA_sayWait };
				case (_bank > 75): { ["ritaRollLeft", "MRTM_rwr1"] call RITA_sayWait };
				default {};
			};
			["ritaPullUp", "MRTM_rwr1"] call RITA_sayWait;
			_aircraft setVariable ["isRitaBusy", false];

			sleep 0.5;
		} else {
			// altitude warning branch

			if (_aircraft getVariable ["isRitaBusy", true]) then { sleep 0.2; continue }; // rita saying something
			_aircraft setVariable ["isRitaBusy", true];
			private _sound = selectRandom ["ritaAltitude0", "ritaAltitude1"];
			[_sound, "MRTM_rwr2"] call RITA_sayWait;
			_aircraft setVariable ["isRitaBusy", false];

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
	waitUntil { sleep 0.2; !(_aircraft getVariable ["isRitaBusy", true]) };
	if (profileNamespace getVariable ["MRTM_EnableRWR", true]) then {
		_aircraft setVariable ["isRitaBusy", true];
		["ritaBingoFuel", "MRTM_rwr3"] call RITA_sayWait;
		_aircraft setVariable ["isRitaBusy", false];
	};

	// critical fuel
	waitUntil { sleep 5; fuel _aircraft < 0.1 }; 
	waitUntil { sleep 0.2; !(_aircraft getVariable ["isRitaBusy", true]) };
	if (profileNamespace getVariable ["MRTM_EnableRWR", true]) then {
		_aircraft setVariable ["isRitaBusy", true];
		["ritaCriticalFuel", "MRTM_rwr3"] call RITA_sayWait;
		_aircraft setVariable ["isRitaBusy", false];
	};
};


RITA_missileTracker = {
	params ["_aircraft"];

	scriptName format ["Rita_missile_tracker_%1", typeOf _aircraft];

	while { profileNamespace getVariable ["MRTM_EnableRWR", true] } do {
		private _incoming = _aircraft getVariable ["incoming", []];
		private _aliveIncoming = _incoming select { alive _x };
		_aircraft setVariable ["incoming", _aliveIncoming];

		if (count _aliveIncoming == 0) then { sleep 1; continue };
		
		if (_aircraft getVariable ["isRitaBusy", true]) then { sleep 0.2; continue }; // rita saying something
		_aircraft setVariable ["isRitaBusy", true];
		["ritaMissile", "MRTM_rwr3"] call RITA_sayWait;

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
		
		private _dirSound = format ["rita_%1", _dirName];
		[_dirSound, "MRTM_rwr3"] call RITA_sayWait;

		_relativePos = _aircraft worldToModel (position _nearestMissile);
		_relativePos params ["_relX", "_relY", "_relZ"];

		private _relHeightSound = if (_relZ > 0) then {
			"ritaHigher"
		} else {
			"ritaLower"
		};

		[_relHeightSound, "MRTM_rwr3"] call RITA_sayWait;
		_aircraft setVariable ["isRitaBusy", false];

		sleep 1.5;
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

		if (_aircraft getVariable ["isRitaBusy", true]) then { sleep 0.2; continue }; // rita saying something
		_aircraft setVariable ["isRitaBusy", true];
		["ritaOverG", "MRTM_rwr4"] call RITA_sayWait;
		_aircraft setVariable ["isRitaBusy", false];

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

		if (_aircraft getVariable ["isRitaBusy", true]) then { sleep 0.2; continue }; // rita saying something

		_aircraft setVariable ["isRitaBusy", true];
		["ritaLock", "MRTM_rwr4"] call RITA_sayWait;
		_aircraft setVariable ["isRitaBusy", false];

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
		if (_aircraft getVariable ["landingGear", true]) then { sleep 5; continue }; // probably landing
		if (speed _aircraft > 150) then { sleep 5; continue };

		if (_aircraft getVariable ["isRitaBusy", true]) then { sleep 0.2; continue }; // rita saying something

		_aircraft setVariable ["isRitaBusy", true];
		["ritaCriticalSpeed", "MRTM_rwr3"] call RITA_sayWait;
		_aircraft setVariable ["isRitaBusy", false];

		sleep 1;
	};
};


RITA_activeScripts = [];
RITA_eventHandlers = createHashMap;

RITA_cleanup = {
	params ["_aircraft"];

	{
		terminate _x;
	} forEach RITA_activeScripts;
	RITA_activeScripts resize 0;

	{
		_aircraft removeEventHandler [_x, _y];
	} forEach RITA_eventHandlers;
};

RITA_deleteScript = {
	params ["_script"];

	private _idx = RITA_activeScripts find _thisScript;
	if (_idx == -1) exitWith {};
	
	RITA_activeScripts deleteAt _idx;
};

player addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];

	if !((typeOf _vehicle) in RITA_vics) exitWith {};

	_vehicle setVariable ["isRitaBusy", false];
	_vehicle setVariable ["landingGear", !(_vehicle isKindOf "Helicopter")];
	_vehicle setVariable ["incoming", []];

	private _gearEhIdx = _vehicle addEventHandler ["Gear", {
		params ["_vehicle", "_gearState"];
		
		_vehicle setVariable ["landingGear", _gearState];

		if !(_gearState) exitWith {};
		if (speed _vehicle < 500) exitWith {};

		if !((profileNamespace getVariable ["MRTM_EnableRWR", true])) exitWith {};

		RITA_activeScripts pushBack ([_vehicle] spawn {
			params ["_v"];
			
			waitUntil { sleep 0.2; !(_v getVariable ["isRitaBusy", true]) };
			_v setVariable ["isRitaBusy", true];
			["ritaGear", "MRTM_rwr3"] call RITA_sayWait;
			_v setVariable ["isRitaBusy", false];

			[_thisScript] call RITA_deleteScript;
		});
	}];
	RITA_eventHandlers set ["Gear", _gearEhIdx];

	private _incMissileEhIdx = _vehicle addEventHandler ["IncomingMissile", {
		params ["_target", "_ammo", "_vehicle", "_instigator", "_missile"];
		_inc = _target getVariable "incoming";
		_inc pushBackUnique _missile;
		_target setVariable ["incoming", _inc];
	}];
	RITA_eventHandlers set ["IncomingMissile", _incMissileEhIdx];

	private _firedEhIdx = _vehicle addEventHandler ["Fired", {
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

		if !((profileNamespace getVariable ["MRTM_EnableRWR", true])) exitWith {};
		private _isFlareLauncher = ["CMFlareLauncher", _weapon, false] call BIS_fnc_inString;
		if !(_isFlareLauncher) exitWith {};

		RITA_activeScripts pushBack ([_unit] spawn {
			params ["_v"];
			if (_v getVariable ["isRitaBusy", true]) exitWith {	
				[_thisScript] call RITA_deleteScript;
			};

			_v setVariable ["isRitaBusy", true];
			["ritaCas", "MRTM_rwr4"] call RITA_sayWait;
			_v setVariable ["isRitaBusy", false];
			
			[_thisScript] call RITA_deleteScript;
		});
	}];
	RITA_eventHandlers set ["Fired", _firedEhIdx];

	private _dammagedEhIdx = _vehicle addEventHandler ["Dammaged", {
		params ["_unit", "_hitSelection", "_damage", "_hitPartIndex", "_hitPoint", "_shooter", "_projectile"];

		if (["hithull", _hitPoint, false] call BIS_fnc_inString) then {
			if (_damage < 0.9) exitWith { 
				_unit setVariable ["ejectNotified", false]; // in case if aircraft was reparied
			}; 

			if (_unit getVariable ["ejectNotified", false]) exitWith {}; // already notified
			_unit setVariable ["ejectNotified", true];

			RITA_activeScripts pushBack ([_unit] spawn {
				params ["_v"];
				
				waitUntil { sleep 0.2; !(_v getVariable ["isRitaBusy", true])};

				_v setVariable ["isRitaBusy", true];
				["ritaEject", "MRTM_rwr3"] call RITA_sayWait;
				_v setVariable ["isRitaBusy", false];
				
				[_thisScript] call RITA_deleteScript;
			});
		};

		if (_hitPoint == "hitengine") then {
			if (_damage < 0.2) exitWith {
				_unit setVariable ["engineNotified", false]; // in case if aircraft was reparied
			};
			
			if (_unit getVariable ["engineNotified", false]) exitWith {}; // already notified
			_v setVariable ["engineNotified", true];

			RITA_activeScripts pushBack ([_unit] spawn {
				params ["_v"];

				private _hitPoints = (getAllHitPointsDamage _v) # 0;
				private _hasTwoEngines = "hitengine2" in _hitPoints;
				private _soundName = if (_hasTwoEngines) then {
					"ritaLeftEngine"
				} else {
					"ritaEngine"
				};

				waitUntil { sleep 0.2; !(_v getVariable ["isRitaBusy", true])};

				_v setVariable ["isRitaBusy", true];
				[_soundName, "MRTM_rwr3"] call RITA_sayWait;
				_v setVariable ["isRitaBusy", false];
				
				[_thisScript] call RITA_deleteScript;
			});
		};

		if (_hitPoint == "hitengine2") then {
			if (_damage < 0.2) exitWith {
				_unit setVariable ["engine2Notified", false]; // in case if aircraft was reparied
			};
			
			if (_unit getVariable ["engine2Notified", false]) exitWith {}; // already notified
			_unit setVariable ["engine2Notified", true];

			RITA_activeScripts pushBack ([_unit] spawn {
				params ["_v"];

				waitUntil { sleep 0.2; !(_v getVariable ["isRitaBusy", true])};

				_v setVariable ["isRitaBusy", true];
				["ritaRightEngine", "MRTM_rwr3"] call RITA_sayWait;
				_v setVariable ["isRitaBusy", false];

				private _idx = RITA_activeScripts find _thisScript;
				if (_idx >= 0) then {
					RITA_activeScripts deleteAt _idx;
				};
			});
		};
	}];
	RITA_eventHandlers set ["Dammaged", _dammagedEhIdx];
	
	private _killedEhIdx = _vehicle addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];

		[_unit] call RITA_cleanup;
	}];
	RITA_eventHandlers set ["Killed", _killedEhIdx];

	RITA_activeScripts pushBack ([_vehicle] spawn RITA_fuelTracker);
	RITA_activeScripts pushBack ([_vehicle] spawn RITA_missileTracker);
	RITA_activeScripts pushBack ([_vehicle] spawn RITA_gForceTracker);
	RITA_activeScripts pushBack ([_vehicle] spawn RITA_targetLockTracker);
	if !(_vehicle isKindOf "Helicopter") then {
		RITA_activeScripts pushBack ([_vehicle] spawn RITA_altitudeTracker);
		RITA_activeScripts pushBack ([_vehicle] spawn RITA_speedTracker);
	};
}];

player addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret", "_isEject"];

	if !(typeOf _vehicle in RITA_vics) exitWith {};

	[_vehicle] call RITA_cleanup;
}];

