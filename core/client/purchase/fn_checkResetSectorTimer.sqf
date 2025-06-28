#include "..\..\warlords_constants.inc"

private _sectorSelectedTimestampVar = format ["BIS_WL_sectorSelectedTimestamp_%1", BIS_WL_playerSide];
private _targetResetVotingVar = format ["BIS_WL_targetResetVotingSince_%1", BIS_WL_playerSide];

private _sectorSelectedTimestamp = missionNamespace getVariable [_sectorSelectedTimestampVar, 0];
private _targetResetVoting = missionNamespace getVariable [_targetResetVotingVar, 0];

private _sectorResetTimeout = getMissionConfigValue ["BIS_WL_sectorResetTimeout", 300];

private _resetSectorTimerEnd = _sectorSelectedTimestamp + _sectorResetTimeout;
if (serverTime < _resetSectorTimerEnd) exitWith {
    private _timeLeft = [_resetSectorTimerEnd - serverTime, "MM:SS"] call BIS_fnc_secondsToString;
    [false, format [localize "STR_A3_WL_asset_availability_reset_sector_cooldown", _timeLeft]];
};

private _targetResetVotingEnd = _targetResetVoting + WL_TARGET_RESET_VOTING_TIME;
if (serverTime < _targetResetVotingEnd) exitWith {
    private _timeLeft = [_targetResetVotingEnd - serverTime, "MM:SS"] call BIS_fnc_secondsToString;
    [false, format [localize "STR_A3_WL_asset_availability_reset_target_timeout", _timeLeft]];
};

[true, ""];