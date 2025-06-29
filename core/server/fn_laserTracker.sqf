addMissionEventHandler ["EntityCreated", {
    params ["_entity"];

    if !(_entity isKindOf "LaserTarget") exitWith {};
    
	[_entity] spawn {
		params ["_laserTarget"];

		waitUntil { (owner _laserTarget) != 0 };

	    private _playerOwnerIds = createHashMap;
	    {
	        _playerOwnerIds set [owner _x, _x];
	    } forEach allPlayers;

	    private _laserTargetOwner = owner _laserTarget;
	    private _owner = _playerOwnerIds getOrDefault [_laserTargetOwner, objNull];
	    if (_laserTarget getVariable ["WL_laserPlayer", objNull] != _owner) then {
	        _laserTarget setVariable ["WL_laserPlayer", _owner, true];
	    };
	};
}];
