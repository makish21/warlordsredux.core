params ["_sector"];

private _sectorAreaComplete = _sector getVariable "objectAreaComplete";
_sectorAreaComplete params ["_pos", "_a", "_b", "_angle", "_isRectangle"];

private _searchRadius = 0;
if _isRectangle then {
	_searchRadius = sqrt ((_a ^ 2) + (_b ^ 2));
} else {
	_searchRadius = _a max _b;
};

selectBestPlaces [_pos, _searchRadius, "waterDepth factor [0, 2]", 20, 10] select { 
	_x params ["_position", "_expressionResult"];
	_position inArea _sectorAreaComplete && _expressionResult >= 1;
} apply {
	_x # 0;
};