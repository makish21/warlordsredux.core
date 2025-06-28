#include "..\..\warlords_constants.inc"

params ["_sector", "_category"];

private _isCarrierSector = count (_sector getVariable ["WL_aircraftCarrier", []]) > 0;
if (_isCarrierSector && _category == "Heavy Vehicles") exitWith {
    [false, localize "STR_A3_WL_asset_availability_carrier_heavy"];
};
[true, ""];