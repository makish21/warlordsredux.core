#include "..\..\warlords_constants.inc"

params ["_class"];


private _spawnClass = missionNamespace getVariable ["WL2_spawnClass", createHashMap] getOrDefault [_class, _class];
switch (_spawnClass) do {
	case "O_T_Truck_03_device_ghex_F";
	case "O_Truck_03_device_F": {
		private _ownedVehiclesVar = format ["BIS_WL_ownedVehicles_%1", getPlayerUID player];
		private _ownedVehicles = missionNamespace getVariable [_ownedVehiclesVar, []];
		private _ownedDevices = _ownedVehicles select {
			typeOf _x == _spawnClass && alive _x;
		};

		if (count _ownedDevices >= 1) then {
			[false, format [localize "STR_WL2_tip_limit_dazzlers", 1]];
		} else {
			[true, ""];
		};
	};

	default {
		[true, ""];
	};
};
