private _settingsMap = profileNamespace getVariable ["WL2_settings", createHashMap];

private _objectViewDistance = getObjectViewDistance # 0;
private _targetViewDistance = _settingsMap getOrDefault ["objectViewDistance", 2000];

private _terrainGridSetting = _settingsMap getOrDefault ["terrainDetails", 3];
private _terrainGrid = switch (_terrainGridSetting) do {
    case 1: {
        25;
    };
    case 2: {
        12.5;
    };
    case 3: {
        6.25;
    };
    case 4: {
        3.125;
    };
};
setTerrainGrid _terrainGrid;

if (_objectViewDistance != _targetViewDistance) then {
    setObjectViewDistance [_targetViewDistance, getObjectViewDistance # 1];
};

if (player getVariable ["WL_ViewRangeReduced", false]) exitWith {
    private _targetViewDistance = _settingsMap getOrDefault ["cqbViewDistance", 200];
    if (_targetViewDistance != viewDistance) then {
        setViewDistance _targetViewDistance;
    };
};

if !((UAVControl getConnectedUAV player # 1) isEqualTo "") exitWith {
    private _targetViewDistance = _settingsMap getOrDefault ["droneViewDistance", 2000];
    if (_targetViewDistance != viewDistance) then {
        setViewDistance _targetViewDistance;
    };
};

private _vehicle = vehicle player;
if (_vehicle isKindOf "Man") exitWith {
    private _targetViewDistance = _settingsMap getOrDefault ["infantryViewDistance", 2000];
    if (_targetViewDistance != viewDistance) then {
        setViewDistance _targetViewDistance;
    };
};

if (_vehicle isKindOf "LandVehicle" || _vehicle isKindOf "Ship") exitWith {
    private _targetViewDistance = _settingsMap getOrDefault ["groundViewDistance", 2000];
    if (_targetViewDistance != viewDistance) then {
        setViewDistance _targetViewDistance;
    };
};

if (_vehicle isKindOf "Air") exitWith {
    private _targetViewDistance = _settingsMap getOrDefault ["airViewDistance", 2000];
    if (_targetViewDistance != viewDistance) then {
        setViewDistance _targetViewDistance;
    };
};