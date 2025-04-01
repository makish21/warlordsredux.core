#include "..\..\warlords_constants.inc"

private _enemiesNearPlayer = [position player, side player] call WL2_fnc_getContestingPlayersInPosition;
private _homeBase = BIS_WL_playerSide call WL2_fnc_getSideBase;
private _isInHomeBase = player inArea (_homeBase getVariable "objectAreaComplete");
private _nearbyEnemies = count _enemiesNearPlayer > 0 && !_isInHomeBase;

if (_nearbyEnemies) then {
    [false, "There are enemies nearby."];
} else {
    [true, ""];
};