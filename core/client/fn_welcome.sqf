"RequestMenu_close" call WL2_fnc_setupUI;

createDialog ["welcomeScreen", true];
hRead = false;

(findDisplay 9000) displayAddEventhandler ["KeyDown",{
	if (dialog) then {
		_button = (_this select 1);
		if (_button in [1, 15, 56]) then {
			true
		} else {
			false
		};
	};
}];

ctrlEnable [1, true];

_side = [west, east] find BIS_WL_playerSide;
_color = [[0, 0.3, 0.5, 1], [0.5, 0, 0, 1]] select _side;

private _control1 = findDisplay 9000 displayCtrl 9005;
_control1 ctrlSetTextColor _color;
private _control2 = findDisplay 9000 displayCtrl 9001;
_control2 ctrlSetBackgroundColor _color;

//List Menu + Scripts
_pageAbt = lbAdd [9011, localize "STR_MRTM_welcomeInteract_01"];
_pageHow = lbAdd [9011, localize "STR_MRTM_welcomeInteract_02"];
_theTeam = lbAdd [9011, localize "STR_MRTM_welcomeInteract_03"];
_dc = lbAdd [9011, localize "STR_MRTM_welcomeInteract_04"];
_changelog = lbAdd [9011, localize "STR_MRTM_welcomeInteract_05"];
_scripts = lbAdd [9011, localize "STR_MRTM_welcomeInteract_06"];

//List Menu Data + Scrips
lbSetData[9011, _pageAbt, "pageAbt"];
lbSetData[9011, _pageHow, "pageHow"];
lbSetData[9011, _theTeam, "theCom"];
lbSetData[9011, _dc, "discord"];
lbSetData[9011, _changelog, "changelog"];
lbSetData[9011, _scripts, "scripts"];

lbSetCurSel [9011, _pageAbt];
{
	_number = _forEachIndex + 1;
	lbSetText [9011, _x, localize (format ["STR_MRTM_welcomeInteract_0%1", _number])];
} forEach [_pageAbt, _pageHow, _theTeam, _dc, _changelog, _scripts];

lbSetPicture [9011, _pageAbt, "a3\ui_f\data\gui\rsc\rscdisplaymultiplayer\favouritecolumntitle_ca.paa"];
lbSetPicture [9011, _pageHow, "a3\ui_f\data\igui\cfg\simpletasks\types\danger_ca.paa"];
lbSetPicture [9011, _theTeam, "a3\ui_f_curator\data\displays\rscdisplaycurator\modegroups_ca.paa"];
lbSetPicture [9011, _dc, "a3\3den\data\controls\ctrlmenu\link_ca.paa"];
lbSetPicture [9011, _changelog, "a3\3den\data\displays\display3den\toolbar\help_updates_new_ca.paa"];
lbSetPicture [9011, _scripts, "a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_saveas_2_ca.paa"];

while {dialog} do {
	_index = lbCurSel 9011;
	_curSel = lbData [9011, _index];

	if !(hRead) then {
		ctrlShow [9006, true];
		ctrlSetText [9006, localize "STR_MRTM_welcomeInteract_21"];
	} else {
		ctrlShow [9006, false];
	};

	_control = findDisplay 9000 displayCtrl 9010;
	switch (_curSel) do {
		case "pageAbt": {
			_control ctrlSetStructuredText composeText [
			localize "STR_MRTM_welcomeInteract_07", lineBreak,
			"", lineBreak,
			localize "STR_MRTM_welcomeInteract_08", lineBreak,
			"", lineBreak,
			localize "STR_MRTM_welcomeInteract_09", lineBreak,
			"", lineBreak,
			""
			];
		};
		case "pageHow": {
			hRead = true;
			_inventoryKey = actionKeysNames "gear";
			_gearKey = actionKeysNames "cycleThrownItems";
			_settingsKey = actionKeysNames "user2";
			_groupKey = actionKeysNames "user3";

			_control ctrlSetStructuredText composeText [
			localize "STR_MRTM_welcomeInteract_02", lineBreak,
			"", lineBreak,
			parseText format [localize "STR_MRTM_welcomeInteract_10"], lineBreak,
			parseText "<a href='https://www.youtube.com/watch?v=qKfCpmqnmQ4'>Walords Redux Guide by GamerDad</a>", lineBreak,
			parseText "<a href='https://www.youtube.com/watch?v=mlZTCnWLgJg'>Walords Redux Guide by Ferrous Creek</a>", lineBreak,
			parseText "<a href='https://streamable.com/3xwuma'>Mortar Guide by Spooker</a>", lineBreak,
			parseText "<a href='https://streamable.com/oh8k57'>Tank Guide by Spooker</a>", lineBreak,
			"", lineBreak,
			localize "STR_MRTM_welcomeInteract_11", lineBreak,
			format [localize "STR_MRTM_welcomeInteract_12", _inventoryKey], lineBreak,
			format [localize "STR_MRTM_welcomeInteract_13", "Insert"], lineBreak,
			format [localize "STR_MRTM_welcomeInteract_14", _gearKey], lineBreak,
			format ["Open your settings: %1", _settingsKey], lineBreak,
			format ["Open the group menu: %1", _groupKey], lineBreak,
			""
			];
		};
		case "theCom": {
			_control ctrlSetStructuredText composeText [
			localize "STR_MRTM_welcomeInteract_03", lineBreak,
			localize "STR_MRTM_welcomeInteract_15", lineBreak,
			"", lineBreak,
			"Special Thanks To-", lineBreak,
			"- Dwarden", lineBreak,
			"From Bohemia Interactive", lineBreak,
			"", lineBreak,
			localize "STR_MRTM_welcomeInteract_16", lineBreak,
			"- Gamerdad", lineBreak,
			"- Witch Doctor", lineBreak,
			"- JWalker08", lineBreak,
			"", lineBreak,
			localize "STR_MRTM_welcomeInteract_17", lineBreak,
			"- Weasley Wells", lineBreak,
			"- Rook", lineBreak,
			"", lineBreak,
			localize "STR_MRTM_welcomeInteract_22", lineBreak,
			"- MrThomasM", lineBreak,
			"- TenPenny", lineBreak,
			"- Coffee Maker", lineBreak,
			"- Korbelz", lineBreak,
			"- Bo", lineBreak,
			"", lineBreak
			];
		};
		case "discord": {
			_control ctrlSetStructuredText composeText [
			localize "STR_MRTM_welcomeInteract_04", lineBreak,
			"", lineBreak,
			localize "STR_MRTM_welcomeInteract_19", lineBreak,
			localize "STR_MRTM_welcomeInteract_20", lineBreak,
			"", lineBreak,
			parseText "<a href='https://discord.gg/grmzsZE4ua'>Discord.</a>"
			];
		};
		case "changelog": {
			private _color = [profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843],profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019],profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862],profilenamespace getvariable ['GUI_BCG_RGB_A',0.7]] call BIS_fnc_colorRGBAtoHTML;
			_control ctrlSetStructuredText composeText [
				parseText format ["<t color='%1' underline='1'>%2</t>", _color, "2.6.1 Update:" splitString " " joinString toString [160]], lineBreak,
				"The changelog for this update is about 250 lines too long for this page, just go to the github", lineBreak,
				"", lineBreak,
				parseText format ["<a href='https://github.com/Gamer-Dad/warlordsredux.altis/blob/master-altis/Update_Notes.txt'>%1</a>", "Visit our github to view the complete changelog." splitString " " joinString toString [160]], lineBreak
			];
		};
		case "scripts": {
			_control ctrlSetStructuredText composeText [
			"GF Earplugs:", lineBreak,
			"We use George Floros's earplug script wich allows you to lower your volume by the press of 1 button.", lineBreak,
			"You can press the INSERT key to lower your volume.", lineBreak,
			"", lineBreak,
			"Textures:", lineBreak,
			"NATO Kuma textures are from A3 Aegis Open Source Mod (heavily modified for size/compression).", lineBreak,
			parseText "<a href='https://github.com/senicluxus/A3_Aegis_Public_Releases'>ArmA 3 Aegis Project</a>", lineBreak,
			""
			];
		};
	};
	sleep 0.1;
};
