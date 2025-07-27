private _unflipActionId = player addAction [
	/*title=*/format["<t color='#E5E500' shadow='2'>%1</t>", localize "STR_A3_WL2_action_unflip"],
	/*script=*/{
		params ["_target", "_caller", "_actionId", "_arguments"];
		cursorObject call KS_fnc_unflipVehicle;
	},
	/*arguments=*/nil, 
	/*priority=*/12, 
	/*showWindow=*/true, 
	/*hideOnUse=*/false, 
	/*shortcut=*/"", 
	/*condition=*/"((isNull objectParent player) && {(alive cursorObject) && {(!isNull cursorObject) && {(cursorObject call KS_fnc_isFlipped) && {(cursorObject isKindOf 'LandVehicle') && {crew cursorObject findIf { alive _x && {_x != cursorObject && {not unitIsUAV _x}} } == -1 && {(player distanceSqr cursorObject) < 100}}}}}})", 
	/*radius=*/10
];
