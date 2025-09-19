params ["_victimName", "_killerName", ["_isFriendlyFire", false]];

private _killMessage = if !(isNil "_killerName") then {
    if (_isFriendlyFire) then {
        format [localize "STR_A3_Revive_MSG_KILLED_BY_FF", _victimName, _killerName];
    } else {
        format [localize "STR_A3_Revive_MSG_KILLED_BY", _victimName, _killerName];
    };
} else {
    format[localize "STR_A3_Revive_MSG_KILLED", _victimName];
};

systemChat _killMessage;
