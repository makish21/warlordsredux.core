#include "..\..\warlords_constants.inc"

private _display = uiNamespace getVariable ["BIS_WL_purchaseMenuDisplay", displayNull];

if (isNull _display) exitWith {};

private _purchase_category = _display displayCtrl 100;
private _purchase_items = _display displayCtrl 101;
private _purchase_pic = _display displayCtrl 102;
private _purchase_info = _display displayCtrl 103;
private _purchase_income = _display displayCtrl 104;
private _purchase_info_asset = _display displayCtrl 105;
private _purchase_request = _display displayCtrl 107;

private _side = side player;
private _moneySign = [_side] call WL2_fnc_getMoneySign;
private _funds = ((missionNamespace getVariable "fundsDatabaseClients") get (getPlayerUID player));
private _servicesAvailable = BIS_WL_sectorsArray # 5;

private _incomeList = [format ["%1 %2", _funds, _moneySign]];
if ("A" in _servicesAvailable) then {
	_incomeList pushBack (localize "STR_A3_WL_param32_title"); // airfield
};
if ("H" in _servicesAvailable) then {
	_incomelist pushBack (localize "STR_A3_WL_module_service_helipad"); // helipad
};
if ("W" in _servicesAvailable) then {
	_incomeList pushBack (localize "STR_A3_WL_param30_title"); // harbor
};
_incomeList pushBack (format [localize "STR_A3_WL_max_group_size", BIS_WL_matesAvailable]);

private _incomeText = _incomeList joinString ", ";

_purchase_income ctrlSetStructuredText parseText format ["<t size = '%2' align = 'center' shadow = '2'>%1</t>", _incomeText, 1.5 call WL2_fnc_purchaseMenuGetUIScale];

_i = 0;
for "_i" from 0 to ((lbSize _purchase_items) - 1) do {
	_cost = _purchase_items lbValue _i;
	if (isNil "_cost") then {
		_cost = 0;
	};
	_assetDetails = (_purchase_items lbData _i) splitString "|||";

	_assetDetails params [
		"_className",
		"_requirements",
		"_displayName",
		"_picture",
		"_text",
		"_offset"
	];
	if (isNil "_requirements") then {continue};
	_requirements = call compile _requirements;
	_category = WL_REQUISITION_CATEGORIES # ((lbCurSel _purchase_category) max 0);
	private _details = +_assetDetails;
	_details set [1, _requirements];
	_details set [6, _cost];
	_details set [7, _category];
	_availability = _details call WL2_fnc_purchaseMenuAssetAvailability;

	private _variant = missionNamespace getVariable ["WL2_variant", createHashMap] getOrDefault [_className, 0];
	if !(_availability # 0) then {
		private _color = if (_variant != 0) then {
			[0.5, 0.42, 0.25, 1]
		} else {
			[0.5, 0.5, 0.5, 1]
		};

		_purchase_items lbSetColor [_i, _color];
		_purchase_items lbSetTooltip [_i, format ["%1", parseText ((_availability # 1) joinString "\n")]];
	} else {
		private _color = if (_variant != 0) then {
			[1, 0.85, 0.5, 1]
		} else {
			[1, 1, 1, 1]
		};

		_purchase_items lbSetColor [_i, _color];
		_purchase_items lbSetTooltip [_i, ""];
	};
};

_id = _purchase_category lbValue lbCurSel _purchase_category;
_curSel = lbCurSel _purchase_items;

if (_curSel == -1) then {
	_purchase_items lbSetCurSel 0;
	_curSel = 0;
};

_assetDetails = (_purchase_items lbData _curSel) splitString "|||";

_assetDetails params [
	"_className",
	"_requirements",
	"_displayName",
	"_picture",
	"_text",
	"_offset"
];

if (count _assetDetails > 0) then {
	_cost = _purchase_items lbValue _curSel;
	if (isNil "_cost") then {
		_cost = 0;
	};
	_requirements = call compile _requirements;
	_category = WL_REQUISITION_CATEGORIES # ((lbCurSel _purchase_category) max 0);
	_color = BIS_WL_colorFriendly;
	private _details = +_assetDetails;
	_details set [1, _requirements];
	_details set [6, _cost];
	_details set [7, _category];
	_availability = _details call WL2_fnc_purchaseMenuAssetAvailability;
	_purchase_request ctrlSetTooltipColorBox [1, 1, 1, 1];
	_purchase_request ctrlSetTooltipColorText [1, 1, 1, 1];
	if (_id == 6) then {
		_removeUnitsID = uiNamespace getVariable ["BIS_WL_removeUnitsListID", -1];
		if (_removeUnitsID != -1) then {
			_selectedCnt = count ((groupSelectedUnits player) select {_x != player && {(_x getVariable ["BIS_WL_ownerAsset", "123"]) == (getPlayerUID player)}});
			if (_selectedCnt > 0) then {
				_purchase_items lbSetText [_removeUnitsID, format [(localize "STR_A3_WL_feature_dismiss_selected") + " (%1)", _selectedCnt]];
			} else {
				_purchase_items lbSetText [_removeUnitsID, localize "STR_A3_WL_feature_dismiss_selected"];
			};
		};
	};
	if (_availability # 0 && {ctrlEnabled _purchase_request}) then {
		uiNamespace setVariable ["BIS_WL_purchaseMenuItemAffordable", TRUE];
		if (uiNamespace getVariable ["BIS_WL_purchaseMenuButtonHover", FALSE]) then {
			_color = BIS_WL_colorFriendly;
			_purchase_request ctrlSetBackgroundColor [(_color # 0) * 1.25, (_color # 1) * 1.25, (_color # 2) * 1.25, _color # 3];
		} else {
			_purchase_request ctrlSetBackgroundColor _color;
		};
		_purchase_request ctrlSetTextColor [1, 1, 1, 1];
		_purchase_request ctrlSetTooltip "";
		_DLCOwned = _availability # 2;
		_DLCTooltip = _availability # 3;
		if !(_DLCOwned) then {
			_purchase_request ctrlSetTooltip _DLCTooltip;
			_purchase_request ctrlSetTooltipColorText [1, 0, 0, 1];
			_purchase_request ctrlSetTooltipColorBox [1, 0, 0, 1];
		};
	} else {
		uiNamespace setVariable ["BIS_WL_purchaseMenuItemAffordable", FALSE];
		_purchase_request ctrlSetBackgroundColor [(_color # 0) * 0.5, (_color # 1) * 0.5, (_color # 2) * 0.5, _color # 3];
		_purchase_request ctrlSetTextColor [0.5, 0.5, 0.5, 1];
		_purchase_request ctrlSetTooltip ((_availability # 1) joinString "\n");
	};
};