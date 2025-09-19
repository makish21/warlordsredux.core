#include "..\warlords_constants.inc"
params ["_unit", "_responsibleLeader"];

if (!isPlayer _responsibleLeader) exitWith {};

private _assetActualType = _unit getVariable ["WL2_orderedClass", typeOf _unit];
private _killRewardMap = missionNamespace getVariable ["WL2_killRewards", createHashMap];
private _killReward = _killRewardMap getOrDefault [_assetActualType, 0];

if (typeof _unit == "RuggedTerminal_01_communications_hub_F") then {
	private _unitOwnerSide = _unit getVariable ["WL2_forwardBaseOwner", sideUnknown];
	_killReward = 500;
	if (_unitOwnerSide != side group _responsibleLeader) then {
		_unit setVariable ["BIS_WL_ownerAsset", "0000"];
	};
};

private _isBuilding = _unit isKindOf "Building";
if (_isBuilding && _killReward == 0) exitWith {};
if (_isBuilding && _unit getVariable ["BIS_WL_ownerAsset", "123"] == "123") exitWith {};

private _killerSide = side group _responsibleLeader;
private _unitSide = [_unit] call WL2_fnc_getAssetSide;

if (_killerSide == _unitSide) exitWith {};

private _customText = "";

private _noRewardList = ["B_UAV_AI", "O_UAV_AI", "I_UAV_AI"];
if (_unit isKindOf "Man" && !(_unit in _noRewardList)) then {
	if (isPlayer _unit) then {
		_killReward = 60;
		_customText = "Enemy player killed";
	} else {
		_killReward = 30;
	};
} else {
	if (_killReward == 0) exitWith {};
};

private _targets = [missionNamespace getVariable "BIS_WL_currentTarget_west", missionNamespace getVariable "BIS_WL_currentTarget_east"] select {!(isNull _x)};

if (_responsibleLeader getVariable ["MRTM_3rdPersonDisabled", false]) then {
	_killReward = _killReward * 2;
};
if ((_targets findIf {_unit inArea (_x getVariable "objectAreaComplete")}) != -1) then {
	_killReward = _killReward * 1.2;
};
if (_unitSide != independent && _unitSide != sideUnknown) then {
	_killReward = _killReward * WL_OPPONENT_KILL_REWARD_MULTIPLIER;
};

#if WL_SQUAD_ASSISTS_ENABLED
private _playerId = getPlayerID _responsibleLeader;
private _squadmatesIDs = ["getSquadmates", [_playerId]] call SQD_fnc_server;
private _squadReward = round ((_killReward * 0.5 / (sqrt (count _squadmatesIDs) max 1)) * WL_INCOME_MULTIPLIER);
{
	private _userInfo = getUserInfo _x;
	if (count _userInfo < 3) then {
		continue;
	};
	_uid = _userInfo # 2;
	[_squadReward, _uid] call WL2_fnc_fundsDatabaseWrite;
	[_unit, _squadReward, "Squad assist", "#228b22"] remoteExec ["WL2_fnc_killRewardClient", (getUserInfo _x) # 1];
} forEach _squadmatesIDs;
#endif  // WL_SQUAD_ASSISTS_ENABLED

_uid = getPlayerUID _responsibleLeader;
_killReward = round (_killReward * WL_INCOME_MULTIPLIER);
[_killReward, _uid] call WL2_fnc_fundsDatabaseWrite;

[_unit, _killReward, _customText, "#de0808", _assetActualType] remoteExec ["WL2_fnc_killRewardClient", _responsibleLeader];

["earnPoints", [_uid, _killReward]] call SQD_fnc_server;

// Vehicle crew reward
private _reward = round ((_killReward / 4) * WL_INCOME_MULTIPLIER);
private _vehicle = objectParent _responsibleLeader;
private _crew = (crew _vehicle) select {
	private _isCommander = _x isEqualTo (commander _vehicle);
	private _isDriver = _x isEqualTo (driver _vehicle);
	private _isGunner = _x isEqualTo (gunner _vehicle);
	private _isOnTurret = count (_vehicle unitTurret _x) > 0;

	private _isLeader = _x == _responsibleLeader; // already rewarded
	private _isPlayer = isPlayer _x;

	_isPlayer && !_isLeader && (_isCommander || _isDriver || _isGunner || _isOnTurret);
};
{
	_uid = getPlayerUID _x;
	[_reward, _uid] call WL2_fnc_fundsDatabaseWrite;
	[_unit, _reward] remoteExec ["WL2_fnc_killRewardClient", _x];

	["earnPoints", [_uid, _reward]] call SQD_fnc_server;
} forEach _crew;