params ["_teamkillerName"];

if (isDedicated) exitWith {};

private _message = format [localize "STR_A3_WL_chat_teamkiller_banned", _teamkillerName];
systemChat _message;