//________________	Author : GEORGE FLOROS [GR]	___________	29.03.19	___________
/*
________________	GF Earplugs Script - Mod	________________
https://forums.bohemia.net/forums/topic/215844-gf-earplugs-script-mod/
*/

disableSerialization;

waitUntil {
	sleep 1;
	!(isNull (findDisplay 46))
};

private _display = findDisplay 46;
_display displayAddEventHandler ["KeyDown", {
	params ["_displayorcontrol", "_key", "_shift", "_ctrl", "_alt"];
	if (_key == 0xD2) then {
		["TaskEarplugs"] call WLT_fnc_taskComplete;
		if (soundVolume != 0.1) then {
			"GF_Earplugs" cutRsc ["Rsc_GF_Earplugs", "PLAIN"];
			titleText [format ["<t color='#339933' size='2'font='PuristaBold'>%1</t>", localize "STR_A3_WL2_earplugs_in"], "PLAIN DOWN", -1, true, true];
			0 fadeSound 0.1;
		} else {
			"GF_Earplugs" cutText ["", "PLAIN"];
			titleText [format ["<t color='#FF3333' size='2'font='PuristaBold'>%1</t>", localize "STR_A3_WL2_earplugs_out"], "PLAIN DOWN", -1, true, true];
			0 fadeSound 1;
		};
	};

	if (_key == 0xD3) then {
		private _oldValue = player getVariable ["WL_ViewRangeReduced", false];
		if (_oldValue) then {
			"ViewRange" cutText ["", "PLAIN"];
			titleText [format ["<t color='#339933' size='2'font='PuristaBold'>%1</t>", localize "STR_A3_WL_CQB_mode_off"], "PLAIN DOWN", -1, true, true];
			player setVariable ["WL_ViewRangeReduced", false];
			0 spawn MRTM_fnc_updateViewDistance;
		} else {
			"ViewRange" cutRsc ["RscViewRangeReduce", "PLAIN"];
			titleText [format ["<t color='#FF3333' size='2'font='PuristaBold'>%1</t>", localize "STR_A3_WL_CQB_mode_on"], "PLAIN DOWN", -1, true, true];
			player setVariable ["WL_ViewRangeReduced", true];
			0 spawn MRTM_fnc_updateViewDistance;
		};
	};
}];