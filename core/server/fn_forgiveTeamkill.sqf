params ["_teamkiller", "_forgiver", "_forgive", "_victim"];

if !(isServer) exitWith {};
if ((owner _forgiver) != remoteExecutedOwner) exitWith {};

if (!_forgive) then {
	private _teamkillerOwner = owner _teamkiller;
	if (_teamkillerOwner < 3) exitwith {};

	private _teamkillerUid = getPlayerUID _teamkiller;

	private _victimActualType = _victim getVariable ["WL2_orderedClass", typeof _victim];
	private _costDB = missionNamespace getVariable ["WL2_costs", createHashMap];
	private _itemCost = _costDB getOrDefault [_victimActualType, 100];

	private _fundsDB = serverNamespace getVariable "fundsDatabase";
	private _teamkillerFunds = _fundsDB getOrDefault [_teamkillerUid, 0];

	private _compensation = round (_itemCost min _teamkillerFunds);
	private _uid = _teamkillerUid;
	[-_compensation, _uid] call WL2_fnc_fundsDatabaseWrite;
	_uid = getPlayerUID _forgiver;
	private _compensationForgiver = round (_compensation * 0.5);
	[_compensationForgiver, _uid] call WL2_fnc_fundsDatabaseWrite;

	private _assetType = if (isPlayer [_victim]) then {
		name _victim
	} else {
		[_victim] call WL2_fnc_getAssetTypeName;
	};
	[_assetType, _compensation] remoteExec ["WL2_fnc_teamkillPunishment", _teamkillerOwner];

	[_compensationForgiver] remoteExec ["WL2_fnc_teamkillCompensation", _forgiver];

	private _friendlyFireVar = format ["WL2_friendlyFire_%1", _teamkillerUid];
	private _friendlyFireIncidents = serverNamespace getVariable [_friendlyFireVar, []];
	_friendlyFireIncidents pushBack serverTime;
	serverNamespace setVariable [_friendlyFireVar, _friendlyFireIncidents];
	[_friendlyFireIncidents] remoteExec ["WL2_fnc_friendlyFireHandleClient", _teamkillerOwner];
};