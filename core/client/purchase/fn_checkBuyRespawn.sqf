#include "..\..\warlords_constants.inc"
#include "..\..\server_macros.inc"

params ["_pod"];

private _spawnTruckTypes = WL_SPAWN_TRUCK_TYPES;
private _spawnPodTypes = WL_SPAWN_POD_TYPES;

private _respawnVehicleType = if (_pod) then {
    switch (BIS_WL_playerSide) do {
        case west: {
            _spawnPodTypes # 0
        };
        case east: {
            _spawnPodTypes # 1
        };
        case independent: {
            "I_Slingload_01_Medevac_F" // non-functional
        };
    };
} else {
    switch (BIS_WL_playerSide) do {
        case west: {
            _spawnTruckTypes # 0
        };
        case east: {
            _spawnTruckTypes # 1
        };
        case independent: {
            "I_Truck_03_medical_F"  // non-functional
        };
    };
};

private _respawnVehicles = (entities _respawnVehicleType) select {alive _x};
private _hasRespawnVehicle = count _respawnVehicles > 0;

if (_hasRespawnVehicle) then {
    [false, localize "STR_A3_WL_ftVehicle_restr"];
} else {
    [true, ""];
};
