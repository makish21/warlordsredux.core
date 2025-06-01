#include "..\warlords_constants.inc"


private _ftMarkers = allMapMarkers select {
	["WL_spawn", _x] call BIS_fnc_inString;
} apply {
	getMarkerPos _x;
};

{
	private _sector = _x;
	private _sectorIdx = _forEachIndex;
	private _area = _sector getVariable "objectArea";

	// spawn / teleport markers
	private _positions = [_sector, 0, true] call WL2_fnc_findSpawnPositions;
	_ftMarkers = _ftMarkers - _positions;
	{
		private _marker = createMarkerLocal [format ["sp_%1_%2", _sectorIdx, _forEachIndex], _x];
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal "mil_dot_noShadow";
		_marker setMarkerColorLocal "ColorBlack";
		_marker setMarkerAlphaLocal 1;
	} forEach _positions;
	if (count _positions < 5) then {
		private _marker = createMarkerLocal [format ["sp_%1_safe", _sectorIdx], _sector];
		_marker setMarkerShapeLocal "ELLIPSE";
		_marker setMarkerBrushLocal "DiagGrid";
		_marker setMarkerColorLocal "ColorBlack";
		_marker setMarkerSizeLocal [50, 50];
		_marker setMarkerAlphaLocal 1;
	};

	// base vulnerable markers
	private _baseVulnerablePositions = [[_sector, (_area # 0) + WL_BASE_DANGER_SPAWN_RANGE, (_area # 1) + WL_BASE_DANGER_SPAWN_RANGE, _area # 2, _area # 3], 50] call WL2_fnc_findSpawnPositions;
	_ftMarkers = _ftMarkers - _baseVulnerablePositions;
	if (count _baseVulnerablePositions >= 5) then {
		{
			private _marker = createMarkerLocal [format ["bv_%1_%2", _sectorIdx, _forEachIndex], _x];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerTypeLocal "mil_dot_noShadow";
			_marker setMarkerColorLocal "ColorRed";
			_marker setMarkerAlphaLocal 1;
		} forEach _baseVulnerablePositions;
	} else {
		private _marker = createMarkerLocal [format ["bv_%1_%2", _sectorIdx, 0], _sector];
		_marker setMarkerShapeLocal "ELLIPSE";
		_marker setMarkerBrushLocal "Border";
		_marker setMarkerSizeLocal [WL_BASE_DANGER_SPAWN_RANGE, WL_BASE_DANGER_SPAWN_RANGE];
		_marker setMarkerColorLocal "ColorRed";
		_marker setMarkerAlphaLocal 1;
	};

	// potential independent ship spawn positions 
	private _waterPositions = _sector call WL2_fnc_findNavalSpawnPositions;
	{
		private _marker = createMarkerLocal [format ["wp_%1_%2", _sectorIdx, _forEachIndex], _x];
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal "mil_dot_noShadow";
		_marker setMarkerColorLocal "ColorBlue";
		_marker setMarkerAlphaLocal 1;
	} forEach _waterPositions;

	// fast travel contested spawn points
	private _connectedSectors = _sector getVariable "BIS_WL_connectedSectors";
	{
		private _dirIdx = _forEachIndex;
		private _connectedSectorPos = position _x;
		
		private _ftArea = [_sector, _connectedSectorPos] call WL2_fnc_makeFastTravelContestedArea; // TODO
		_ftArea params ["_pos", "_a", "_b", "_angle"];

		private _marker = createMarkerLocal [format ["ft_%1_%2", _sectorIdx, _dirIdx], _pos];
		_marker setMarkerShapeLocal "RECTANGLE";
		_marker setMarkerColorLocal BIS_WL_colorMarkerFriendly;
		_marker setMarkerDirLocal _angle;
		_marker setMarkerSizeLocal [_a, _b];
		_marker setMarkerAlphaLocal 0.5;

		private _positions = [_marker, 0, true] call WL2_fnc_findSpawnPositions;
		_ftMarkers = _ftMarkers - _positions;
		_positions pushBack (getMarkerPos _marker);

		{
			private _marker = createMarkerLocal [format ["ft_dot_%1_%2_%3", _sectorIdx, _dirIdx, _forEachIndex], _x];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerTypeLocal "mil_dot_noShadow";
			_marker setMarkerColorLocal BIS_WL_colorMarkerFriendly;
			_marker setMarkerAlphaLocal 1;
		} forEach _positions;
	} forEach _connectedSectors;

	// sector's helipad positions
	// private _positions = [_sector, 0, false] call WL2_fnc_findSpawnPositions;
	// private _idx = _positions select { [_x] call WL2_fnc_checkPositionSuitableForHelicopters };
	// {
	// 	private _pos1 = _x;
	// 	private _marker = createMarkerLocal [format ["hp_%1_%2", _sectorIdx, _forEachIndex], _pos1];
	// 	_marker setMarkerColorLocal "ColorKhaki";
	// 	_marker setMarkerShapeLocal "ELLIPSE";
	// 	_marker setMarkerSizeLocal [20, 20];
	// 	_marker setMarkerAlphaLocal 1;
	// } forEach _idx;
} forEach BIS_WL_allSectors;

// Editor placed spawn markers that did not used by any group above. 
systemChat format ["%1 unused spawn markers found", count _ftMarkers];
{
	private _marker = createMarkerLocal [format ["ft_rem_%1", _forEachIndex], _x];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerTypeLocal "mil_dot_noShadow";
	_marker setMarkerColorLocal "ColorWhite";
	_marker setMarkerAlphaLocal 1;
} forEach _ftMarkers;


// // Code to search possible helipads on map
// private _axis = worldSize / 2;
// private _center = [_axis, _axis, 0];
// private _positions = [[_center, _axis, _axis, 0, true], 0, false] call WL2_fnc_findSpawnPositions;
// private _idx = _positions select { [_x] call WL2_fnc_checkPositionSuitableForHelicopters };
// {
// 	private _pos1 = _x;
// 	private _marker = createMarkerLocal [format ["hpg_%1", _forEachIndex], _pos1];
// 	_marker setMarkerColorLocal "ColorYellow";
// 	_marker setMarkerShapeLocal "ELLIPSE";
// 	_marker setMarkerSizeLocal [20, 20];
// 	_marker setMarkerAlphaLocal 1;
// } forEach _idx;
