#include "..\..\warlords_constants.inc"

private _countSide = playersNumber BIS_WL_playerSide;
private _enemySide = playersNumber BIS_WL_enemySide;

if (_countSide < 10) exitWith {
	[false, format [localize "STR_A3_WL2_asset_availability_forfeit_players_count", _countSide, 10]];
};
if (_countSide < (_enemySide - 5)) exitWith {
	[true, ""];
};

private _forfeitVotingVar = format ["BIS_WL_forfeitVotingSince_%1", BIS_WL_playerSide];
private _forfeitVoting = missionNamespace getVariable [_forfeitVotingVar, 0];
private _forfeitVotingTimer = _forfeitVoting + 1200;
if (serverTime < _forfeitVotingTimer) exitWith {
	private _timeLeft = [_forfeitVotingTimer - serverTime, "MM:SS"] call BIS_fnc_secondsToString;
	[false, format [localize "STR_A3_WL2_asset_availability_forfeit_timer", _timeLeft]];
};

[true, ""];