#include "..\..\warlords_constants.inc"

params ["_fastTravelMode"];

private _offset = switch (_fastTravelMode) do {
    case 0: {
        WL_FAST_TRAVEL_OFFSET
    };
    case 1: {
        WL_FAST_TRAVEL_OFFSET
    };
    case 2: {
        200
    };
    case 3: {
        500
    };
};

private _startArr = (synchronizedObjects WL_TARGET_FRIENDLY) select {
    (_x getVariable "BIS_WL_owner") == BIS_WL_playerSide
};
_startArr = _startArr apply {
    [_x distance2D player, _x]
};
_startArr sort true;

private _targetSector = WL_TARGET_FRIENDLY;
private _startPosition = ((_startArr # 0) # 1);

private _ftRegion = [_targetSector, _startPosition] call WL2_fnc_makeFastTravelContestedArea;
_ftRegion params ["_pos", "_a", "_b", "_angle"];

private _marker = createMarkerLocal ["localMarker", _pos];
_marker setMarkerShapeLocal "RECTANGLE";
_marker setMarkerColorLocal BIS_WL_colorMarkerFriendly;
_marker setMarkerDirLocal _angle;
_marker setMarkerSizeLocal [_a, _b];

_markerText = createMarkerLocal ["localMarkerText", markerPos _marker];
_markerText setMarkerColorLocal BIS_WL_colorMarkerFriendly;
_markerText setMarkerSizeLocal [0, 0];
_markerText setMarkerTypeLocal "mil_dot";
_markerText setMarkerTextLocal localize "STR_A3_cfgvehicles_moduletasksetdestination_f_arguments_destination_0";

[_marker, _markerText];