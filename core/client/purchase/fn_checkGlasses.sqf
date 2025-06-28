if (goggles player == "G_Tactical_Clear" && player getVariable ["WL_hasGoggles", false]) then {
    [false, localize "STR_A3_WL_asset_availability_ar_glasses"];
} else {
    [true, ""];
};