private _sectorConfig = missionConfigFile >> "CfgWarlordSectors";
private _sectors = "true" configClasses _sectorConfig;

private _logicCenter = createCenter sideLogic;
private _logicGroup = createGroup _logicCenter;

private _createdSectors = createHashMap;
private _initializedSectors = [];
{
    private _sector = _x;
    private _sectorClass = configName _sector;

    private _location = getArray (_sector >> "location");
    private _logic = _logicGroup createUnit ["Logic", _location, [], 0, "NONE"];

    private _name = getText (_sector >> "name");
    _logic setVariable ["BIS_WL_name", _name, true];

    private _disableHome = getNumber (_sector >> "disableHome");
    _logic setVariable ["BIS_WL_canBeBase", _disableHome != 1];

    private _services = getArray (_sector >> "services");
    _logic setVariable ["BIS_WL_services", _services, true];

    private _area = getArray (_sector >> "area");
    _area set [3, _area # 3 == 1];
    _logic setVariable ["objectArea", _area, true];

    private _carrier = getText (_sector >> "carrier");
    if (_carrier != "") then {
        _logic setVariable ["WL_aircraftCarrier", call compile _carrier, true];
    };

    _createdSectors set [_sectorClass, _logic];
    _initializedSectors pushBack _logic;
} forEach _sectors;

private _connections = getArray (_sectorConfig >> "connections");
{
    private _connection = _x;

    private _from = _connection # 0;
    private _to = _connection # 1;

    private _fromSector = _createdSectors getOrDefault [_from, objNull];
    private _toSector = _createdSectors getOrDefault [_to, objNull];

    _fromSector synchronizeObjectsAdd [_toSector];

    private _fromSectorConnections = _fromSector getVariable ["BIS_WL_connectedSectors", []];
    _fromSectorConnections pushBackUnique _toSector;
    _fromSector setVariable ["BIS_WL_connectedSectors", _fromSectorConnections];

    private _toSectorConnections = _toSector getVariable ["BIS_WL_connectedSectors", []];
    _toSectorConnections pushBackUnique _fromSector;
    _toSector setVariable ["BIS_WL_connectedSectors", _toSectorConnections];
} forEach _connections;

// Set on clients
{
    private _sectorConnections = _x getVariable ["BIS_WL_connectedSectors", []];
    _x setVariable ["BIS_WL_connectedSectors", _sectorConnections, true];
} forEach _initializedSectors;

missionNamespace setVariable ["WL2_sectorsInitializationComplete", _initializedSectors, true];