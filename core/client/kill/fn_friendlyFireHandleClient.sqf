params ["_friendlyFireIncidents"];

private _uid = getPlayerUID player;
private _isAdmin = _uid in (getArray (missionConfigFile >> "adminIDs"));
if (_isAdmin) exitWith {};

private _incidentCount = count _friendlyFireIncidents;

if (_incidentCount < 3) exitWith {};

// Ensure that the last 3 were committed within 30 minutes
private _lastIncident = _friendlyFireIncidents # (_incidentCount - 1);
private _threeIncidentsAgo = _friendlyFireIncidents # (_incidentCount - 3);
if (_lastIncident - _threeIncidentsAgo > 30 * 60) exitWith {};

private _penaltyEnd = _lastIncident + 30 * 60;
if (_penaltyEnd < serverTime) exitWith {};

[name player] remoteExec ["WL2_fnc_teamkillerMessage", 0];

private _timeRemaining = [(_penaltyEnd - serverTime) max 0, "MM:SS"] call BIS_fnc_secondsToString;
private _penaltyText = format [localize "STR_A3_WL_chat_teamkiller_penalty_text", _timeRemaining];

"BlockScreen" setDebriefingText ["Punished", _penaltyText, "Friendly fire punished."];
endMission "BlockScreen";
forceEnd;