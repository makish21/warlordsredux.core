#include "..\..\warlords_constants.inc"

params [["_requireGround", true]];

private _vehicle = vehicle player;
private _isInVehicle = _vehicle != player;
if (!_isInVehicle) exitWith {
    [false, localize "STR_A3_WL_asset_availability_in_vehicle"];
};

private _isGroundVehicle = _vehicle isKindOf "LandVehicle";
if (_requireGround && !_isGroundVehicle) exitWith {
    [false, localize "STR_A3_WL_asset_availability_in_ground_vehicle"];
};

private _isInDriverSeat = (driver _vehicle) == player;
if (!_isInDriverSeat) exitWith {
    [false, localize "STR_A3_WL_asset_availability_in_ground_vehicle"];
};

private _isAttached = !isNull attachedTo _vehicle;
private _hasAttachment = count attachedObjects _vehicle > 0;
if (_isAttached || _hasAttachment) exitWith {
    [false, localize "STR_A3_WL_asset_availability_unattached"];
};

[true, ""];