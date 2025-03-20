private _alreadyAdded = _this getVariable ["APS_fireEventHandlerAdded", false];
if (_alreadyAdded) exitWith {};
_this setVariable ["APS_fireEventHandlerAdded", true];

_this addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

	WAS_fired = true;

	if !(local _projectile) exitWith { true };
	if !(local _gunner) exitWith { true };
	[_projectile] spawn APS_fnc_projectileStateUpdate;

	private _assetActualType = _unit getVariable ["WL2_orderedClass", typeOf _unit];
	private _ammoOverridesHashMap = missionNamespace getVariable ["WL2_ammoOverrides", createHashMap];
	private _assetAmmoOverrides = _ammoOverridesHashMap getOrDefault [_assetActualType, createHashMap];
	private _projectileAmmoOverride = _assetAmmoOverrides getOrDefault [_ammo, _ammo];
	if (_projectileAmmoOverride != _ammo) then {
		_projectile setVariable ["APS_ammoOverride", _projectileAmmoOverride];
	};

	private _apsProjectileType = _projectile getVariable ["APS_ammoOverride", typeOf _projectile];
	if !(_apsProjectileType in APS_projectileConfig) exitWith { true };

	private _projectileConfig = APS_projectileConfig getOrDefault [_apsProjectileType, createHashMap];
	private _projectileTV = _projectileConfig getOrDefault ["tv", false];
	if (_projectileTV) then {
		private _projectileSpeed = _projectileConfig getOrDefault ["speed", 0];
		_projectile setVariable ["APS_speedOverride", _projectileSpeed];
		[_projectile, _unit, 0.3, 3] call DIS_fnc_startMissileCamera;
	} else {
		private _projectileMissileCamera = _projectileConfig getOrDefault ["camera", false];
		if (_projectileMissileCamera) then {
			[_projectile, _unit] call DIS_fnc_startMissileCamera;
		};
	};
	private _projectileRemote = _projectileConfig getOrDefault ["remote", false];
	if (_projectileRemote) then {
		_unit setVariable ["APS_remoteControlled", _projectile, true];
	};

	_this spawn APS_fnc_firedProjectile;

	private _projectileSam = _projectileConfig getOrDefault ["sam", false];
	if (_projectileSam) then {
		[_projectile, _unit] spawn DIS_fnc_frag;
		[_projectile, _unit] spawn DIS_fnc_maneuver;
	};

	private _projectileSead = _projectileConfig getOrDefault ["sead", false];
	if (_projectileSead) then {
		[_projectile, _unit] spawn APS_fnc_sead;
	};
}];