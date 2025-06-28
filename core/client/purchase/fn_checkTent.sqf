#include "..\..\warlords_constants.inc"

private _respawnBag = player getVariable ["WL2_respawnBag", objNull];
if (!alive _respawnBag) then {
    [false, localize "STR_A3_WL2_asset_availability_no_tents"];
} else {
    [true, ""];
};