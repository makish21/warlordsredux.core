params ["_fastTravelMode"];

titleCut ["", "BLACK IN", 1];

switch (_fastTravelMode) do {
	case 0: {
		["TaskFastTravelSeized"] call WLT_fnc_taskComplete;
	};
	case 1: {
		["TaskFastTravelConflict"] call WLT_fnc_taskComplete;
	};
	case 2: {
		["TaskAirAssault"] call WLT_fnc_taskComplete;
	};
	case 3: {
		["TaskVehicleParadrop"] call WLT_fnc_taskComplete;
	};
	case 4: {
		["TaskFastTravelTent"] call WLT_fnc_taskComplete;
	};
};