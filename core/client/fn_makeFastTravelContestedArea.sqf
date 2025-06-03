#include "..\warlords_constants.inc"

params ["_targetSector", "_startPosition"];

private _startDir = _targetSector getDir _startPosition;
private _area = _targetSector getVariable "objectArea";
private _ftOffset = _targetSector getVariable ["WL2_fastTravelOffset", WL_FAST_TRAVEL_OFFSET];
private _ftRange = _targetSector getVariable ["WL2_fastTravelRange", WL_FAST_TRAVEL_RANGE_AXIS];
_area params ["_a", "_b", "_angle", "_isRectangle"];

private _size = 0;
private _distance = 0;
private _dir = 0;

#if WL_SHAPED_FT_CONTESTED_AREA
private _relAngle = -(_startDir - _angle - 90) % 360; // relative angle to area center, as if area's X coordinate was angle reference

if (_isRectangle) then {
	if (_relAngle >= 180) then { _relAngle = _relAngle - 360 };
	if (_relAngle < -180) then { _relAngle = _relAngle + 360 };

	// corner angles
	private _tl = -(-180 + (_b atan2 _a)); // top left
	private _tr = (_b atan2 _a); // top right
	private _br = -(_b atan2 _a); // bottom right
	private _bl = -(180 - (_b atan2 _a)); // bottom left
	private _cornerAngles = [_tl, _tr, _br, _bl];

	_cornerAngles sort true;

	private _fn_top    = { _startDir = _angle + 0;   _dir = _angle;       _size = _a;  _distance = _b; };
	private _fn_right  = { _startDir = _angle + 90;  _dir = -90 + _angle; _size = _b;  _distance = _a; };
	private _fn_bottom = { _startDir = _angle + 180; _dir = _angle;       _size = _a;  _distance = _b; };
	private _fn_left   = { _startDir = _angle + 270; _dir = -90 + _angle; _size = _b;  _distance = _a; };

	private _computeCornerRightEdgeValues = {
		params ["_corner"];
		switch _corner do {
			case _tl: _fn_top;
			case _tr: _fn_right;
			case _br: _fn_bottom;
			default _fn_left;
		};
	};

	{
		if (_relAngle < _x) then {
			_x call _computeCornerRightEdgeValues;
			break;
		};

		if (_forEachIndex == 3) then {
			(_cornerAngles select 0) call _computeCornerRightEdgeValues;
		}
	} forEach _cornerAngles;
} else {
	private _phi = atan(_a / _b * tan(_relAngle)); // "ellipsized" angle
	private _epsilon = atan(-(_b / (_a * tan(_phi)))); // ellipse tangent angle relative to its X coordinate

	_dir = -(_epsilon) + _angle; // absolute tangent angle
	_size = (_a * _b) / sqrt(((_a * sin(_epsilon)) ^ 2) + ((_b * cos(_epsilon)) ^ 2)); // ellipse projection onto epsilon
	_distance = (_a * _b) / sqrt(((_a * sin(_relAngle)) ^ 2) + ((_b * cos(_relAngle)) ^ 2));
};

private _pos = [_targetSector, _distance + _ftOffset + _ftRange, _startDir] call BIS_fnc_relPos;

#else // WL_SHAPED_FT_CONTESTED_AREA
_size = if (_isRectangle) then {
    sqrt ((_a ^ 2) + (_b ^ 2));
} else {
    _a max _b;
};

private _pos = [_targetSector, _size + _ftOffset + _ftRange, _startDir] call BIS_fnc_relPos
#endif // WL_SHAPED_FT_CONTESTED_AREA

[_pos, /*a=*/_size, /*b=*/_ftRange, /*angle=*/_dir, /*isRectangle=*/true];