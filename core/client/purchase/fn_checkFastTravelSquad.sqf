#include "..\..\warlords_constants.inc"

// Is squad leader
private _isSquadLeader = ["isSquadLeader", [getPlayerID player]] call SQD_fnc_client;
if (!_isSquadLeader) exitWith {
    [false, localize "STR_A3_WL_asset_availability_squad_leader"];
};

[true, ""];