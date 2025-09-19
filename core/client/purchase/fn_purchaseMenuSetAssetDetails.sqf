#include "..\..\warlords_constants.inc"

private _display = uiNamespace getVariable ["BIS_WL_purchaseMenuDisplay", displayNull];

private _purchase_category = _display displayCtrl 100;
private _purchase_items = _display displayCtrl 101;
private _purchase_pic = _display displayCtrl 102;
private _purchase_info_asset = _display displayCtrl 105;
private _purchase_title_cost = _display displayCtrl 121;

private _curSel = (lbCurSel _purchase_items) max 0;

private _assetDetails = (_purchase_items lbData _curSel) splitString "|||";

_assetDetails params [
	"_className",
	"_requirements",
	"_displayName",
	"_picture",
	"_text",
	"_offset"
];

_requirements = call compile _requirements;

_purchase_pic ctrlSetText _picture;
_id = _purchase_category lbValue lbCurSel _purchase_category;
_purchase_info_asset ctrlSetStructuredText parseText format ["<t align = 'left' size = '%2'>%1</t>", _text, 1 call WL2_fnc_getPurchaseMenuUIScale];
_cost = _purchase_items lbValue lbCurSel _purchase_items;

private _infoAssetHeight = ctrlTextHeight _purchase_info_asset;
_purchase_info_asset ctrlSetPositionH ((_infoAssetHeight + 0.05) max (safezoneH * 0.27));
_purchase_info_asset ctrlCommit 0;

private _side = side player;
private _moneySign = [_side] call WL2_fnc_getMoneySign;
private _costDisplay = (_cost call BIS_fnc_numberText) regexReplace [" ", ","];
private _requirementsList = [format ["%1%2: %3 %4", localize "STR_A3_WL_menu_cost", if (toLower language == "french") then {" "} else {""}, _cost, _moneySign]];
if ("A" in _requirements) then {
	_requirementsList pushBack (localize "STR_A3_WL_param32_title");
};
if ("H" in _requirements) then {
	_requirementsList pushBack (localize "STR_A3_WL_module_service_helipad");
}; 
if ("W" in _requirements) then {
	_requirementsList pushBack (localize "STR_A3_WL_param30_title");
};
private _requirementsText = _requirementsList joinString ", ";

_purchase_title_cost ctrlSetStructuredText parseText format ["<t align = 'center' shadow = '0'>%1</t>", _requirementsText];
call WL2_fnc_purchaseMenuRefresh;