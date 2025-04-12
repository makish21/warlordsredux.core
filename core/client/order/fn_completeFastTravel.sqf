#include "..\..\warlords_constants.inc"

params ["_fastTravelMode"];

titleCut ["", "BLACK IN", 1];

switch (_fastTravelMode) do {
	case WL_FAST_TRAVEL_MODE_SEIZED: {
		["TaskFastTravelSeized"] call WLT_fnc_taskComplete;
	};
	case WL_FAST_TRAVEL_MODE_CONTESTED: {
		["TaskFastTravelConflict"] call WLT_fnc_taskComplete;
	};
	case WL_FAST_TRAVEL_MODE_AIR_ASSAULT: {
		["TaskAirAssault"] call WLT_fnc_taskComplete;
	};
	case WL_FAST_TRAVEL_MODE_VEHICLE_PARADROP: {
		["TaskVehicleParadrop"] call WLT_fnc_taskComplete;
	};
	case WL_FAST_TRAVEL_MODE_TENT: {
		["TaskFastTravelTent"] call WLT_fnc_taskComplete;
	};
};
