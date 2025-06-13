params ["_projectile", "_unit"];

private _target = objNull;
private _frag = false;
private _projectileClass = typeOf _projectile;
private _range = getNumber (configfile >> "CfgAmmo" >> _projectileClass >> "indirectHitRange");
private _proxRange = _range * 2.5;

private _objectsNearby = [];
sleep 0.5;
while { alive _projectile } do {
	sleep 0.001;

	_objectsNearby = _projectile nearEntities ["Air", _proxRange];
	_objectsNearby = _objectsNearby select {
		[_x] call WL2_fnc_getAssetSide != side group _unit
	};
	if (count _objectsNearby > 0) then {
		break;
	};
};

// Vanilla explosion
private _projectilePosition = getPosASL _projectile;
triggerAmmo _projectile;

if (count _objectsNearby == 0) exitWith {};

{
	_x setVariable ["WL_lastHitter", _unit, 2];
	{
		_x setVariable ["WL_lastHitter", _unit, 2];
	} forEach (crew _x);
} forEach _objectsNearby;

private _targetDetected = _objectsNearby # 0;
private _targetPosition = getPosASL _targetDetected;
private _detonationPoint = vectorLinearConversion [0, 1, 0.75, _projectilePosition, _targetPosition];

private _finalDistance = _targetPosition distance _detonationPoint;
systemChat format [localize "STR_A3_WL2_chat_sam_frag", round _finalDistance];

// Burst Explosion
private _burst = createVehicle [_projectileClass, _detonationPoint, [], 50, "FLY"];
_burst setPosASL _detonationPoint;
triggerAmmo _burst;