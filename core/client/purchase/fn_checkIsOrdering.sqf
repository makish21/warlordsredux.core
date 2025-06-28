#include "..\..\warlords_constants.inc"

if (player getVariable ["BIS_WL_isOrdering", false]) then {
    [false, localize "STR_A3_WL_asset_availability_order_in_progress"];
} else {
    [true, ""];
};